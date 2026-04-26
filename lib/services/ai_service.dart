import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dart_openai/dart_openai.dart';

import '../models/recipe.dart';

class AIService {
  AIService({
    required String apiKey,
    this.model = 'gpt-3.5-turbo',
    this.maxRequestsPerMinute = 6,
  }) : _apiKey = apiKey.trim() {
    if (_apiKey.isNotEmpty) {
      OpenAI.apiKey = _apiKey;
    }
  }

  final String _apiKey;
  final String model;
  final int maxRequestsPerMinute;

  final Map<String, Recipe> _recipeCache = {};
  final List<DateTime> _requestTimestamps = [];

  Future<AIResult<Recipe>> generateCreativeRecipe({
    required List<String> ingredients,
    required List<String> dietaryPreferences,
    String? cookingTime,
    String? calorieTarget,
  }) async {
    final cleanIngredients = ingredients.map((e) => e.trim()).where((s) => s.isNotEmpty).toSet().toList();
    if (cleanIngredients.isEmpty) {
      return const AIResult.error(AIError.emptyIngredients);
    }

    if (_apiKey.isEmpty) {
      return const AIResult.error(AIError.misconfigured);
    }

    final cacheKey = _cacheKey(
      kind: 'creative_recipe',
      ingredients: cleanIngredients,
      dietaryPreferences: dietaryPreferences,
      cookingTime: cookingTime,
      calorieTarget: calorieTarget,
    );
    final cached = _recipeCache[cacheKey];
    if (cached != null) return AIResult.ok(cached);

    // Retry loop: if model returns invalid/unrealistic output, try again (up to 2).
    // This reduces "saçma sapan" recipes without surfacing it to the user as often.
    const maxRetries = 2;
    for (var attempt = 0; attempt <= maxRetries; attempt++) {
      final rateErr = _checkRateLimit();
      if (rateErr != null) return AIResult.error(rateErr);

      try {
        final prompt = _buildCreativeRecipePrompt(
          ingredients: cleanIngredients,
          dietaryPreferences: dietaryPreferences,
          cookingTime: cookingTime,
          calorieTarget: calorieTarget,
        );

        final chatCompletion = await OpenAI.instance.chat.create(
          model: model,
          responseFormat: {'type': 'json_object'},
          temperature: 0.35,
          maxTokens: 1100,
          messages: [
            OpenAIChatCompletionChoiceMessageModel(
              role: OpenAIChatMessageRole.user,
              content: [
                OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt),
              ],
            ),
          ],
        );

        final contentItems = chatCompletion.choices.first.message.content;
        final responseText = _contentItemsToText(contentItems);

        final parsed = _parseAIRecipeJson(responseText);
        if (parsed == null) {
          _logFailedGeneration(
            ingredients: cleanIngredients,
            aiResponse: responseText,
            errorReason: 'parse_failed',
          );
          continue;
        }

        final validationError = _validateGeneratedRecipe(
          recipe: parsed,
          providedIngredients: cleanIngredients,
          cookingTime: cookingTime,
        );
        if (validationError != null) {
          _logFailedGeneration(
            ingredients: cleanIngredients,
            aiResponse: responseText,
            errorReason: validationError,
          );
          continue;
        }

        _recipeCache[cacheKey] = parsed;
        return AIResult.ok(parsed);
      } on SocketException {
        return const AIResult.error(AIError.network);
      } catch (e) {
        final msg = e.toString().toLowerCase();
        if (msg.contains('rate') && msg.contains('limit')) {
          return const AIResult.error(AIError.rateLimited);
        }
        // Try again if it's not the last attempt.
        if (attempt < maxRetries) continue;
        return const AIResult.error(AIError.unknown);
      }
    }

    return const AIResult.error(AIError.invalidResponse);
  }

  Future<AIResult<MacroOptimization>> optimizeMacros({
    required Recipe recipe,
    required String targetMacro, // 'protein' | 'carbs' | 'fat'
    required int targetValue,
  }) async {
    if (_apiKey.isEmpty) return const AIResult.error(AIError.misconfigured);
    final rateErr = _checkRateLimit();
    if (rateErr != null) return AIResult.error(rateErr);

    final macro = targetMacro.trim().toLowerCase();
    if (macro != 'protein' && macro != 'carbs' && macro != 'fat') {
      return const AIResult.error(AIError.invalidInput);
    }

    try {
      final prompt = _buildMacroOptimizationPrompt(
        recipe: recipe,
        targetMacro: macro,
        targetValue: targetValue,
      );

      final chatCompletion = await OpenAI.instance.chat.create(
        model: model,
        responseFormat: {'type': 'json_object'},
        temperature: 0.4,
        maxTokens: 700,
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)],
          ),
        ],
      );

      final responseText = _contentItemsToText(chatCompletion.choices.first.message.content);
      final parsed = _parseMacroOptimizationJson(responseText);
      if (parsed == null) return const AIResult.error(AIError.invalidResponse);
      return AIResult.ok(parsed);
    } on SocketException {
      return const AIResult.error(AIError.network);
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('rate') && msg.contains('limit')) {
        return const AIResult.error(AIError.rateLimited);
      }
      return const AIResult.error(AIError.unknown);
    }
  }

  Future<AIResult<WeeklyMealPlan>> generateWeeklyMealPlan({
    required List<String> days, // Mon..Sun keys, whatever UI sends
    List<String> dietaryPreferences = const [],
    String? totalCalorieTarget,
  }) async {
    if (_apiKey.isEmpty) return const AIResult.error(AIError.misconfigured);
    final rateErr = _checkRateLimit();
    if (rateErr != null) return AIResult.error(rateErr);

    try {
      final prompt = _buildWeeklyMealPlanPrompt(
        days: days,
        dietaryPreferences: dietaryPreferences,
        totalCalorieTarget: totalCalorieTarget,
      );

      final chatCompletion = await OpenAI.instance.chat.create(
        model: model,
        responseFormat: {'type': 'json_object'},
        temperature: 0.6,
        maxTokens: 900,
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)],
          ),
        ],
      );

      final responseText = _contentItemsToText(chatCompletion.choices.first.message.content);
      final plan = _parseWeeklyMealPlanJson(responseText);
      if (plan == null) return const AIResult.error(AIError.invalidResponse);
      return AIResult.ok(plan);
    } on SocketException {
      return const AIResult.error(AIError.network);
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('rate') && msg.contains('limit')) {
        return const AIResult.error(AIError.rateLimited);
      }
      return const AIResult.error(AIError.unknown);
    }
  }

  // ---- internals ----

  AIError? _checkRateLimit() {
    final now = DateTime.now();
    _requestTimestamps.removeWhere((t) => now.difference(t) > const Duration(minutes: 1));
    if (_requestTimestamps.length >= maxRequestsPerMinute) {
      return AIError.rateLimited;
    }
    _requestTimestamps.add(now);
    return null;
  }

  String _cacheKey({
    required String kind,
    required List<String> ingredients,
    required List<String> dietaryPreferences,
    required String? cookingTime,
    required String? calorieTarget,
  }) {
    final ing = (List<String>.from(ingredients)..sort()).join('|');
    final prefs = (dietaryPreferences.map((e) => e.trim()).where((s) => s.isNotEmpty).toSet().toList()..sort()).join('|');
    return '$kind::$ing::${cookingTime ?? '-'}::${calorieTarget ?? '-'}::$prefs';
  }

  String _buildCreativeRecipePrompt({
    required List<String> ingredients,
    required List<String> dietaryPreferences,
    String? cookingTime,
    String? calorieTarget,
  }) {
    final ingredientsList = ingredients.join(', ');
    final preferences = dietaryPreferences.isEmpty ? 'Hiçbiri' : dietaryPreferences.join(', ');

    final ctLine = (cookingTime != null && cookingTime.trim().isNotEmpty)
        ? 'PİŞİRME SÜRESİ: ${cookingTime.trim()}'
        : '';
    final calLine = (calorieTarget != null && calorieTarget.trim().isNotEmpty)
        ? 'KALORİ HEDEFİ: ${calorieTarget.trim()}'
        : '';

    return '''
Sen bir Türk yemek şefi ve beslenme uzmanısın. Lezzetli, yapılabilir ve mantıklı bir tarif oluştur.

📌 KULLANICINıN ELİNDEKİ MALZEMELER (Tercih sırasında kullan):
$ingredientsList

BESLENME KISITLAMALARI:
$preferences

${ctLine.isEmpty ? '' : '$ctLine\n'}
${calLine.isEmpty ? '' : '$calLine\n'}

📋 KURALLAR:
1. Kullanıcının elindeki malzemeleri ÖNCELİKLE kullan
2. Eksik standart malzeme (tuz, zeytinyağı, su, baharatlar vb.) ekleyebilirsin - bu tamam
3. Ama tarif MANTIKLI ve LEZZETLI olması çok önemli. Alakasız kombinasyonlar yapma
4. Adım sayısı max 12, her adım max 200 karakter
5. Pişirme süresi 5-60 dakika
6. Ölçüler kesin (g/ml/adet/yk/tk)
7. Makrolar realistic:
   - protein: 5-60g
   - carbs: 10-150g
   - fat: 2-40g

YANIT FORMATI (kesinlikle JSON):
{
  "name": "Tarif Adı (Türkçe)",
  "emoji": "🍽️",
  "ingredients": [
    {"name": "malzeme1", "amount": "100 g"},
    {"name": "malzeme2", "amount": "1 adet"}
  ],
  "steps": ["Adım 1", "Adım 2"],
  "cookingTime": 25,
  "difficulty": "Kolay",
  "macros": {
    "calories": 420,
    "protein": 30,
    "carbs": 45,
    "fat": 15
  },
  "dietaryTags": ["tag1"]
}
''';
  }

  String _buildMacroOptimizationPrompt({
    required Recipe recipe,
    required String targetMacro,
    required int targetValue,
  }) {
    final ingredients = recipe.ingredients.map((i) => '${i.name} (${i.amount})').join(', ');
    final steps = recipe.steps.join('\n');

    return '''
Türkçe yanıt ver. Sadece geçerli JSON döndür. JSON dışında hiçbir metin yazma.

Elimde şu tarif var:
Ad: ${recipe.name}
Malzemeler: $ingredients
Adımlar:
$steps

Amaç: $targetMacro hedefi yaklaşık $targetValue g olacak şekilde tarifi optimize et.

JSON formatı:
{
  "suggestions": ["Tavuk miktarını 250g yap", "Pirinç miktarını azalt"],
  "updatedMacros": {
    "calories": 520,
    "protein": 40,
    "carbs": 35,
    "fat": 14
  }
}
''';
  }

  String _buildWeeklyMealPlanPrompt({
    required List<String> days,
    required List<String> dietaryPreferences,
    required String? totalCalorieTarget,
  }) {
    final prefs = dietaryPreferences.isEmpty ? 'Hiçbiri' : dietaryPreferences.join(', ');
    final cal = (totalCalorieTarget != null && totalCalorieTarget.trim().isNotEmpty)
        ? 'Toplam kalori hedefi (günlük): $totalCalorieTarget\n'
        : '';
    final daysList = days.isEmpty ? 'Pazartesi, Salı, Çarşamba, Perşembe, Cuma, Cumartesi, Pazar' : days.join(', ');

    return '''
Türkçe yanıt ver. Sadece geçerli JSON döndür. JSON dışında hiçbir metin yazma.

Şu günler için 1 öğünlük (1 tarif) haftalık plan oluştur:
Günler: $daysList
Beslenme Tercihleri: $prefs
$cal

JSON formatı:
{
  "days": [
    {
      "day": "Mon",
      "recipe": {
        "name": "Tarif Adı",
        "ingredients": [{"name": "malzeme", "amount": "miktar"}]
      },
      "notes": "İsteğe bağlı not"
    }
  ]
}
''';
  }

  Recipe? _parseAIRecipeJson(String response) {
    try {
      final obj = jsonDecode(_extractJsonObject(response));
      if (obj is! Map) return null;
      final json = Map<String, Object?>.from(obj);

      final name = (json['name'] as String?)?.trim();
      final emoji = (json['emoji'] as String?)?.trim();
      final difficulty = (json['difficulty'] as String?)?.trim();
      final cookingTime = (json['cookingTime'] as num?)?.toInt();
      final tags = (json['dietaryTags'] is List)
          ? (json['dietaryTags'] as List).map((e) => e.toString()).where((s) => s.trim().isNotEmpty).toList(growable: false)
          : const <String>[];

      final ingredients = <RecipeIngredient>[];
      final rawIngredients = json['ingredients'];
      if (rawIngredients is List) {
        for (final it in rawIngredients) {
          if (it is Map) {
            final m = Map<String, Object?>.from(it);
            ingredients.add(
              RecipeIngredient(
                name: (m['name'] as String?)?.trim() ?? '',
                amount: (m['amount'] as String?)?.trim() ?? '',
                unit: (m['unit'] as String?)?.trim() ?? '',
                isAvailable: true,
              ),
            );
          } else if (it is String) {
            final line = it.trim();
            if (line.isEmpty) continue;
            // Supports "name: amount" or "name | amount" formats.
            final split = line.contains('|') ? line.split('|') : line.split(':');
            if (split.length >= 2) {
              final n = split.first.trim();
              final a = split.sublist(1).join(line.contains('|') ? '|' : ':').trim();
              ingredients.add(RecipeIngredient(name: n, amount: a, isAvailable: true));
            } else {
              ingredients.add(RecipeIngredient(name: line, amount: '', isAvailable: true));
            }
          }
        }
      }

      final stepsRaw = json['steps'];
      final steps = (stepsRaw is List)
          ? stepsRaw.map((e) => e.toString()).where((s) => s.trim().isNotEmpty).toList(growable: false)
          : const <String>[];

      final macrosRaw = json['macros'];
      final nutrition = (macrosRaw is Map)
          ? Nutrition.fromJson(Map<String, Object?>.from(macrosRaw))
          : const Nutrition(calories: 0, protein: 0, carbs: 0, fat: 0);

      return Recipe(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
        name: (name == null || name.isEmpty) ? 'AI Tarifi' : name,
        emoji: (emoji == null || emoji.isEmpty) ? '🤖' : emoji,
        category: 'lunch',
        cuisineType: 'turkish',
        servings: 1,
        prepTimeMinutes: cookingTime ?? 20,
        categoryKey: 'all',
        ingredients: ingredients.isEmpty ? const [RecipeIngredient(name: '—', amount: '', unit: '')] : ingredients,
        nutrition: nutrition,
        collections: const ['AI Tarifim'],
        dietaryTags: tags,
        allergens: const [],
        source: 'custom',
        isApproved: true,
        status: 'active',
        isPremium: false,
        difficulty: (difficulty == null || difficulty.isEmpty) ? 'Kolay' : difficulty,
        steps: steps,
      );
    } catch (_) {
      return null;
    }
  }

  String? _validateGeneratedRecipe({
    required Recipe recipe,
    required List<String> providedIngredients,
    required String? cookingTime,
  }) {
    // Name check
    final name = recipe.name.trim();
    if (name.isEmpty || name.length > 100) return 'invalid_name';

    // Ingredients count
    final ing = recipe.ingredients
        .map((i) => i.name.trim())
        .where((s) => s.isNotEmpty && s != '—')
        .toList(growable: false);
    if (ing.isEmpty || ing.length > 25) return 'invalid_ingredients_count';

    for (final i in recipe.ingredients) {
      if (i.name.trim().isEmpty || i.name.trim().length > 100) return 'invalid_ingredient_name';
      if (i.amount.trim().isEmpty || i.amount.trim().length > 60) return 'invalid_ingredient_amount';
    }

    // Steps check
    final steps = recipe.steps.map((s) => s.trim()).where((s) => s.isNotEmpty).toList(growable: false);
    if (steps.isEmpty || steps.length > 12) return 'invalid_steps_count';
    for (final s in steps) {
      if (s.length > 200) return 'invalid_step_length';
    }

    // Time check
    final time = recipe.prepTimeMinutes;
    if (time < 5 || time > 60) return 'invalid_cooking_time';

    // Difficulty
    const validDifficulties = {'Çok Kolay', 'Kolay', 'Orta', 'Zor'};
    if (!validDifficulties.contains(recipe.difficulty.trim())) return 'invalid_difficulty';

    // Macros check
    final protein = recipe.nutrition.protein;
    final carbs = recipe.nutrition.carbs;
    final fat = recipe.nutrition.fat;
    if (protein < 0 || protein > 70) return 'invalid_protein';
    if (carbs < 0 || carbs > 200) return 'invalid_carbs';
    if (fat < 0 || fat > 50) return 'invalid_fat';

    // ✅ MALZEME MATCH KONTROLÜ KALDIRILDI
    // Artık tarif mantıklı mı, adımlar temiz mi diye bakıyoruz. Malzeme match'i artık zorunlu değil.

    return null;
  }

  void _logFailedGeneration({
    required List<String> ingredients,
    required String aiResponse,
    required String errorReason,
  }) {
    debugPrint('=== FAILED AI GENERATION ===');
    debugPrint('Ingredients: ${ingredients.join(', ')}');
    debugPrint('Error: $errorReason');
    debugPrint('AI Response (truncated): ${aiResponse.length > 800 ? aiResponse.substring(0, 800) : aiResponse}');
    debugPrint('Timestamp: ${DateTime.now().toIso8601String()}');
  }

  MacroOptimization? _parseMacroOptimizationJson(String response) {
    try {
      final obj = jsonDecode(_extractJsonObject(response));
      if (obj is! Map) return null;
      final json = Map<String, Object?>.from(obj);
      final suggestionsRaw = json['suggestions'];
      final suggestions = (suggestionsRaw is List)
          ? suggestionsRaw.map((e) => e.toString()).where((s) => s.trim().isNotEmpty).toList(growable: false)
          : const <String>[];
      final updatedRaw = json['updatedMacros'];
      final nutrition = (updatedRaw is Map)
          ? Nutrition.fromJson(Map<String, Object?>.from(updatedRaw))
          : null;
      return MacroOptimization(suggestions: suggestions, updatedMacros: nutrition);
    } catch (_) {
      return null;
    }
  }

  WeeklyMealPlan? _parseWeeklyMealPlanJson(String response) {
    try {
      final obj = jsonDecode(_extractJsonObject(response));
      if (obj is! Map) return null;
      final json = Map<String, Object?>.from(obj);
      final rawDays = json['days'];
      if (rawDays is! List) return null;
      final items = rawDays
          .whereType<Map>()
          .map((m) => Map<String, Object?>.from(m))
          .map(
            (m) => WeeklyMealPlanItem(
              day: (m['day'] as String?)?.trim() ?? '',
              recipeName: ((m['recipe'] is Map) ? (m['recipe'] as Map)['name'] : m['recipeName'])?.toString().trim() ?? '',
              ingredients: _parseRecipeIngredientsFromPlan(m['recipe']),
              notes: (m['notes'] as String?)?.trim() ?? '',
            ),
          )
          .where((i) => i.day.isNotEmpty && i.recipeName.isNotEmpty)
          .toList(growable: false);
      if (items.isEmpty) return null;
      return WeeklyMealPlan(days: items);
    } catch (_) {
      return null;
    }
  }

  List<RecipeIngredient> _parseRecipeIngredientsFromPlan(Object? recipeObj) {
    if (recipeObj is! Map) return const [];
    final recipe = Map<String, Object?>.from(recipeObj);
    final rawIngredients = recipe['ingredients'];
    if (rawIngredients is! List) return const [];
    final out = <RecipeIngredient>[];
    for (final it in rawIngredients) {
      if (it is Map) {
        final m = Map<String, Object?>.from(it);
        out.add(
          RecipeIngredient(
            name: (m['name'] as String?)?.trim() ?? '',
            amount: (m['amount'] as String?)?.trim() ?? '',
            unit: (m['unit'] as String?)?.trim() ?? '',
            isAvailable: true,
          ),
        );
      }
    }
    return out.where((i) => i.name.trim().isNotEmpty).toList(growable: false);
  }

  String _extractJsonObject(String text) {
    final trimmed = text.trim();
    if (trimmed.startsWith('{') && trimmed.endsWith('}')) return trimmed;
    final m = RegExp(r'\{[\s\S]*\}', dotAll: true).firstMatch(text);
    return m?.group(0) ?? text;
  }

  String _contentItemsToText(List<OpenAIChatCompletionChoiceMessageContentItemModel>? items) {
    if (items == null || items.isEmpty) return '';
    final buf = StringBuffer();
    for (final it in items) {
      final t = it.text;
      if (t != null) buf.writeln(t);
    }
    return buf.toString().trim();
  }
}

enum AIError {
  emptyIngredients,
  network,
  rateLimited,
  invalidResponse,
  misconfigured,
  invalidInput,
  unknown,
}

class AIResult<T> {
  final T? data;
  final AIError? error;

  const AIResult._({required this.data, required this.error});

  const AIResult.ok(T data) : this._(data: data, error: null);
  const AIResult.error(AIError error) : this._(data: null, error: error);

  bool get isOk => data != null && error == null;
}

class MacroOptimization {
  final List<String> suggestions;
  final Nutrition? updatedMacros;
  const MacroOptimization({required this.suggestions, required this.updatedMacros});
}

class WeeklyMealPlan {
  final List<WeeklyMealPlanItem> days;
  const WeeklyMealPlan({required this.days});
}

class WeeklyMealPlanItem {
  final String day;
  final String recipeName;
  final List<RecipeIngredient> ingredients;
  final String notes;
  const WeeklyMealPlanItem({
    required this.day,
    required this.recipeName,
    required this.ingredients,
    required this.notes,
  });
}


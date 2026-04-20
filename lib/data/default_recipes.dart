import '../models/diet_keys.dart';
import '../models/recipe.dart';

// ─── Free tier (10) ──────────────────────────────────────────────────────────

final _recipe1 = Recipe(
  id: 'recipe_1',
  name: 'Tavuk & Pirinç',
  emoji: '🍗',
  prepTimeMinutes: 25,
  categoryKey: 'high_protein',
  isPremium: false,
  difficulty: 'Kolay',
  collections: ['Yüksek Protein', 'Öğle Yemeği'],
  dietaryTags: [DietKeys.highProtein, DietKeys.halal, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Chicken', amount: '300 g', isAvailable: true),
    RecipeIngredient(name: 'Rice', amount: '1 cup dry', isAvailable: false),
    RecipeIngredient(name: 'Onion', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Garlic', amount: '2 cloves', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '2 tbsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 520, protein: 42, carbs: 48, fat: 14),
  steps: const [
    'Tavuğu küp doğrayıp tuz ve karabiberle marine et.',
    'Pirinci yıka; soğan ve sarımsağı kavur, tavuğu ekle.',
    'Pirinci ekle, sıcak su ile pişir ve kısık ateşte demle.',
    'Maydanoz ile servis et.',
  ],
);

final _recipe2 = Recipe(
  id: 'recipe_2',
  name: 'Kırmızı Et & Patates',
  emoji: '🥩',
  prepTimeMinutes: 40,
  categoryKey: 'high_protein',
  isPremium: false,
  difficulty: 'Orta',
  collections: ['Yüksek Protein', 'Akşam'],
  dietaryTags: [DietKeys.highProtein, DietKeys.halal, DietKeys.keto],
  ingredients: const [
    RecipeIngredient(name: 'Beef', amount: '400 g', isAvailable: false),
    RecipeIngredient(name: 'Potato', amount: '4 pcs', isAvailable: true),
    RecipeIngredient(name: 'Onion', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '2 tbsp', isAvailable: true),
    RecipeIngredient(name: 'Tomato', amount: '2 pcs', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 610, protein: 48, carbs: 38, fat: 28),
  steps: const [
    'Eti kuşbaşı doğra, patatesi dilimle.',
    'Tencerede soğanı kavur, eti ekleyip mühürle.',
    'Domates ve baharatları ekle, su ilave et.',
    'Patatesi ekle ve kısık ateşte yumuşayana kadar pişir.',
  ],
);

final _recipe3 = Recipe(
  id: 'recipe_3',
  name: 'Balık & Sebze',
  emoji: '🐟',
  prepTimeMinutes: 22,
  categoryKey: 'high_protein',
  isPremium: false,
  difficulty: 'Kolay',
  collections: ['Yüksek Protein', 'Hafif'],
  dietaryTags: [DietKeys.highProtein, DietKeys.glutenFree, DietKeys.halal],
  ingredients: const [
    RecipeIngredient(name: 'Fish Fillet', amount: '250 g', isAvailable: false),
    RecipeIngredient(name: 'Green Pepper', amount: '1 pcs', isAvailable: false),
    RecipeIngredient(name: 'Tomato', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Lemon', amount: '1 pcs', isAvailable: false),
    RecipeIngredient(name: 'Olive Oil', amount: '1 tbsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 380, protein: 36, carbs: 12, fat: 18),
  steps: const [
    'Fırını 190 °C’ye ısıt.',
    'Balık ve sebzeleri tepsiye diz, zeytinyağı ve limon sık.',
    '15–18 dakika pişir.',
    'Sıcak servis et.',
  ],
);

final _recipe4 = Recipe(
  id: 'recipe_4',
  name: 'Tofu & Makarna',
  emoji: '🍝',
  prepTimeMinutes: 20,
  categoryKey: 'high_protein',
  isPremium: false,
  difficulty: 'Kolay',
  collections: ['Vegan Haftası', 'Öğle Yemeği'],
  dietaryTags: [DietKeys.vegan, DietKeys.highProtein, DietKeys.vegetarian],
  ingredients: const [
    RecipeIngredient(name: 'Tofu', amount: '200 g', isAvailable: false),
    RecipeIngredient(name: 'Pasta', amount: '150 g', isAvailable: false),
    RecipeIngredient(name: 'Tomato', amount: '2 pcs', isAvailable: true),
    RecipeIngredient(name: 'Garlic', amount: '2 cloves', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '1 tbsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 480, protein: 28, carbs: 58, fat: 14),
  steps: const [
    'Tofuyu küp doğra ve kızart.',
    'Sarımsaklı domates sosunu hazırla.',
    'Makarnayı haşla ve sosla karıştır.',
    'Üzerine tofu ve fesleğen ekle.',
  ],
);

final _recipe5 = Recipe(
  id: 'recipe_5',
  name: 'Yumurta Omlet',
  emoji: '🍳',
  prepTimeMinutes: 12,
  categoryKey: 'high_protein',
  isPremium: false,
  difficulty: 'Kolay',
  collections: ['Yüksek Protein', 'Kahvaltı'],
  dietaryTags: [DietKeys.highProtein, DietKeys.vegetarian, DietKeys.halal],
  ingredients: const [
    RecipeIngredient(name: 'Eggs', amount: '3 pcs', isAvailable: true),
    RecipeIngredient(name: 'Cheese', amount: '40 g', isAvailable: true),
    RecipeIngredient(name: 'Tomato', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Green Pepper', amount: '1 pcs', isAvailable: false),
    RecipeIngredient(name: 'Olive Oil', amount: '1 tsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 340, protein: 24, carbs: 8, fat: 22),
  steps: const [
    'Yumurtaları çırp, tuz ekle.',
    'Sebzeleri doğra ve hafif kavur.',
    'Karışımı dök ve altını tutunca peyniri serp.',
    'Katlayarak servis et.',
  ],
);

final _recipe6 = Recipe(
  id: 'recipe_6',
  name: 'Mercimek Çorbası',
  emoji: '🥣',
  prepTimeMinutes: 35,
  categoryKey: 'vegan',
  isPremium: false,
  difficulty: 'Kolay',
  collections: ['Çorba', 'Vegan Haftası'],
  dietaryTags: [DietKeys.vegan, DietKeys.vegetarian, DietKeys.halal, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Red Lentils', amount: '1 cup', isAvailable: false),
    RecipeIngredient(name: 'Onion', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Carrot', amount: '1 pcs', isAvailable: false),
    RecipeIngredient(name: 'Olive Oil', amount: '1 tbsp', isAvailable: true),
    RecipeIngredient(name: 'Potato', amount: '1 pcs', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 240, protein: 14, carbs: 36, fat: 6),
  steps: const [
    'Mercimeği yıka.',
    'Soğan ve havucu kavur, mercimek ve patatesi ekle.',
    'Su ekle kaynat, ezerek kıvam ver.',
    'Limon ve nane ile servis et.',
  ],
);

final _recipe7 = Recipe(
  id: 'recipe_7',
  name: 'Kale Salatası',
  emoji: '🥗',
  prepTimeMinutes: 15,
  categoryKey: 'vegan',
  isPremium: false,
  difficulty: 'Kolay',
  collections: ['Vegan Haftası', 'Hafif'],
  dietaryTags: [DietKeys.vegan, DietKeys.vegetarian, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Kale', amount: '150 g', isAvailable: false),
    RecipeIngredient(name: 'Tomato', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Cucumber', amount: '1 pcs', isAvailable: false),
    RecipeIngredient(name: 'Olive Oil', amount: '2 tbsp', isAvailable: true),
    RecipeIngredient(name: 'Lemon', amount: '½ pcs', isAvailable: false),
  ],
  nutrition: const Nutrition(calories: 180, protein: 6, carbs: 14, fat: 12),
  steps: const [
    'Kaleyi doğra ve ovala.',
    'Sebzeleri küp doğra.',
    'Zeytinyağı ve limonla sos hazırla.',
    'Karıştır ve hemen servis et.',
  ],
);

final _recipe8 = Recipe(
  id: 'recipe_8',
  name: 'Kabak Noodle',
  emoji: '🥒',
  prepTimeMinutes: 18,
  categoryKey: 'low_carb',
  isPremium: false,
  difficulty: 'Kolay',
  collections: ['Düşük Karbonhidrat', 'Hızlı'],
  dietaryTags: [DietKeys.lowCarb, DietKeys.keto, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Zucchini', amount: '2 pcs', isAvailable: false),
    RecipeIngredient(name: 'Chicken', amount: '150 g', isAvailable: true),
    RecipeIngredient(name: 'Garlic', amount: '2 cloves', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '1 tbsp', isAvailable: true),
    RecipeIngredient(name: 'Tomato', amount: '1 pcs', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 290, protein: 32, carbs: 10, fat: 12),
  steps: const [
    'Kabakları spiral kes.',
    'Tavuğu baharatla sotele.',
    'Sarımsak ve domatesi ekle.',
    'Kabak noodle ile hızlıca karıştır.',
  ],
);

final _recipe9 = Recipe(
  id: 'recipe_9',
  name: 'Yumurta Muffin',
  emoji: '🧁',
  prepTimeMinutes: 25,
  categoryKey: 'low_carb',
  isPremium: false,
  difficulty: 'Kolay',
  collections: ['Düşük Karbonhidrat', 'Kahvaltı'],
  dietaryTags: [DietKeys.lowCarb, DietKeys.keto, DietKeys.highProtein],
  ingredients: const [
    RecipeIngredient(name: 'Eggs', amount: '4 pcs', isAvailable: true),
    RecipeIngredient(name: 'Cheese', amount: '60 g', isAvailable: true),
    RecipeIngredient(name: 'Green Pepper', amount: '1 pcs', isAvailable: false),
    RecipeIngredient(name: 'Onion', amount: '½ pcs', isAvailable: true),
    RecipeIngredient(name: 'Salt', amount: 'To taste', isAvailable: false),
  ],
  nutrition: const Nutrition(calories: 260, protein: 20, carbs: 6, fat: 16),
  steps: const [
    'Fırını 180 °C’ye ısıt.',
    'Yumurtaları çırp, sebze ve peyniri ekle.',
    'Kalıplara paylaştır.',
    '18–20 dakika pişir.',
  ],
);

final _recipe10 = Recipe(
  id: 'recipe_10',
  name: '5 Dakika Omlet',
  emoji: '⚡',
  prepTimeMinutes: 5,
  categoryKey: 'quick',
  isPremium: false,
  difficulty: 'Kolay',
  collections: ['5 Dakika', 'Öğrenci'],
  dietaryTags: [DietKeys.vegetarian, DietKeys.highProtein, DietKeys.halal],
  ingredients: const [
    RecipeIngredient(name: 'Eggs', amount: '2 pcs', isAvailable: true),
    RecipeIngredient(name: 'Cheese', amount: '30 g', isAvailable: true),
    RecipeIngredient(name: 'Butter', amount: '1 tsp', isAvailable: false),
    RecipeIngredient(name: 'Salt', amount: 'To taste', isAvailable: false),
  ],
  nutrition: const Nutrition(calories: 280, protein: 18, carbs: 2, fat: 20),
  steps: const [
    'Yumurtaları çırp.',
    'Tereyağını tavada erit.',
    'Karışımı dök, 2 dakika pişir.',
    'Peyniri serp, katla ve servis et.',
  ],
);

// ─── Premium only (15) ───────────────────────────────────────────────────────

final _recipe11 = Recipe(
  id: 'recipe_11',
  name: 'Izgara Köfte & Bulgur',
  emoji: '🧆',
  prepTimeMinutes: 35,
  categoryKey: 'dinner',
  isPremium: true,
  difficulty: 'Orta',
  collections: ['Akşam', 'Yüksek Protein'],
  dietaryTags: [DietKeys.highProtein, DietKeys.halal],
  ingredients: const [
    RecipeIngredient(name: 'Ground Beef', amount: '400 g', isAvailable: false),
    RecipeIngredient(name: 'Onion', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Bulgur', amount: '1 cup', isAvailable: false),
    RecipeIngredient(name: 'Parsley', amount: '1 bunch', isAvailable: false),
    RecipeIngredient(name: 'Olive Oil', amount: '2 tbsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 640, protein: 44, carbs: 42, fat: 30),
  steps: const [
    'Köftelik harcı yoğur.',
    'Köfteleri ızgarada pişir.',
    'Bulgur pilavını hazırla.',
    'Salata ile servis et.',
  ],
);

final _recipe12 = Recipe(
  id: 'recipe_12',
  name: 'Nohut Yemeği',
  emoji: '🫘',
  prepTimeMinutes: 45,
  categoryKey: 'vegan',
  isPremium: true,
  difficulty: 'Kolay',
  collections: ['Vegan Haftası', 'Tek Tencere'],
  dietaryTags: [DietKeys.vegan, DietKeys.vegetarian, DietKeys.halal, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Chickpeas', amount: '400 g canned', isAvailable: false),
    RecipeIngredient(name: 'Onion', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Tomato', amount: '2 pcs', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '2 tbsp', isAvailable: true),
    RecipeIngredient(name: 'Garlic', amount: '3 cloves', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 420, protein: 18, carbs: 58, fat: 12),
  steps: const [
    'Soğanı kavur.',
    'Baharat ve domatesi ekle.',
    'Nohutu ekle ve kısık ateşte pişir.',
    'Maydanoz ile servis et.',
  ],
);

final _recipe13 = Recipe(
  id: 'recipe_13',
  name: 'Sebzeli Mercimek',
  emoji: '🍲',
  prepTimeMinutes: 30,
  categoryKey: 'vegan',
  isPremium: true,
  difficulty: 'Kolay',
  collections: ['Vegan Haftası', 'Öğle Yemeği'],
  dietaryTags: [DietKeys.vegan, DietKeys.vegetarian, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Green Lentils', amount: '1 cup', isAvailable: false),
    RecipeIngredient(name: 'Carrot', amount: '2 pcs', isAvailable: false),
    RecipeIngredient(name: 'Onion', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Potato', amount: '2 pcs', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '1 tbsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 360, protein: 16, carbs: 54, fat: 8),
  steps: const [
    'Mercimeği haşla.',
    'Sebzeleri doğra ve sotele.',
    'Karıştır ve baharatla.',
    'Kıvamlı olunca servis et.',
  ],
);

final _recipe14 = Recipe(
  id: 'recipe_14',
  name: 'Fırında Tavuk But',
  emoji: '🍗',
  prepTimeMinutes: 50,
  categoryKey: 'high_protein',
  isPremium: true,
  difficulty: 'Orta',
  collections: ['Yüksek Protein', 'Akşam'],
  dietaryTags: [DietKeys.highProtein, DietKeys.keto, DietKeys.halal, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Chicken', amount: '600 g', isAvailable: true),
    RecipeIngredient(name: 'Potato', amount: '4 pcs', isAvailable: true),
    RecipeIngredient(name: 'Garlic', amount: '6 cloves', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '3 tbsp', isAvailable: true),
    RecipeIngredient(name: 'Thyme', amount: '1 tsp', isAvailable: false),
  ],
  nutrition: const Nutrition(calories: 560, protein: 52, carbs: 32, fat: 22),
  steps: const [
    'Fırını 200 °C’ye ısıt.',
    'Tavuk ve patatesi marine et.',
    'Fırın tepsisine diz.',
    '45 dakika kızarana kadar pişir.',
  ],
);

final _recipe15 = Recipe(
  id: 'recipe_15',
  name: 'Levrek Buğulama',
  emoji: '🐠',
  prepTimeMinutes: 28,
  categoryKey: 'dinner',
  isPremium: true,
  difficulty: 'Orta',
  collections: ['Akşam', 'Hafif'],
  dietaryTags: [DietKeys.highProtein, DietKeys.glutenFree, DietKeys.halal],
  ingredients: const [
    RecipeIngredient(name: 'Sea Bass', amount: '400 g', isAvailable: false),
    RecipeIngredient(name: 'Lemon', amount: '2 pcs', isAvailable: false),
    RecipeIngredient(name: 'Parsley', amount: '1 bunch', isAvailable: false),
    RecipeIngredient(name: 'Olive Oil', amount: '2 tbsp', isAvailable: true),
    RecipeIngredient(name: 'Onion', amount: '1 pcs', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 340, protein: 38, carbs: 8, fat: 16),
  steps: const [
    'Balığı temizle.',
    'Soğan halkaları ve limonla tepsiye yerleştir.',
    'Buharda veya fırında pişir.',
    'Zeytinyağı gezdirerek servis et.',
  ],
);

final _recipe16 = Recipe(
  id: 'recipe_16',
  name: 'Kabak Spagetti Bolonez',
  emoji: '🍅',
  prepTimeMinutes: 32,
  categoryKey: 'low_carb',
  isPremium: true,
  difficulty: 'Orta',
  collections: ['Düşük Karbonhidrat', 'Akşam'],
  dietaryTags: [DietKeys.lowCarb, DietKeys.keto, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Zucchini', amount: '3 pcs', isAvailable: false),
    RecipeIngredient(name: 'Ground Beef', amount: '250 g', isAvailable: false),
    RecipeIngredient(name: 'Tomato', amount: '3 pcs', isAvailable: true),
    RecipeIngredient(name: 'Garlic', amount: '3 cloves', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '1 tbsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 420, protein: 36, carbs: 14, fat: 24),
  steps: const [
    'Kabaktan spaghetti şekli çıkar.',
    'Kıymalı sosu pişir.',
    'Kabakları hızlıca sotele.',
    'Sosla karıştır ve servis et.',
  ],
);

final _recipe17 = Recipe(
  id: 'recipe_17',
  name: 'Protein Chia Puding',
  emoji: '🫙',
  prepTimeMinutes: 10,
  categoryKey: 'quick',
  isPremium: true,
  difficulty: 'Kolay',
  collections: ['5 Dakika', 'Kahvaltı'],
  dietaryTags: [DietKeys.highProtein, DietKeys.vegetarian, DietKeys.noDairy],
  ingredients: const [
    RecipeIngredient(name: 'Chia Seeds', amount: '3 tbsp', isAvailable: false),
    RecipeIngredient(name: 'Protein Powder', amount: '1 scoop', isAvailable: false),
    RecipeIngredient(name: 'Almond Milk', amount: '200 ml', isAvailable: false),
    RecipeIngredient(name: 'Salt', amount: 'pinch', isAvailable: false),
  ],
  nutrition: const Nutrition(calories: 310, protein: 28, carbs: 18, fat: 12),
  steps: const [
    'Tüm malzemeleri çırp.',
    'Kavanoza koy.',
    'Buzdolabında 2 saat beklet.',
    'Meyve ile servis et.',
  ],
);

final _recipe18 = Recipe(
  id: 'recipe_18',
  name: 'Fırında Karnabahar',
  emoji: '🥦',
  prepTimeMinutes: 35,
  categoryKey: 'vegan',
  isPremium: true,
  difficulty: 'Kolay',
  collections: ['Vegan Haftası', 'Atıştırmalık'],
  dietaryTags: [DietKeys.vegan, DietKeys.keto, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Cauliflower', amount: '1 head', isAvailable: false),
    RecipeIngredient(name: 'Olive Oil', amount: '2 tbsp', isAvailable: true),
    RecipeIngredient(name: 'Garlic', amount: '4 cloves', isAvailable: true),
    RecipeIngredient(name: 'Salt', amount: 'To taste', isAvailable: false),
  ],
  nutrition: const Nutrition(calories: 180, protein: 8, carbs: 14, fat: 12),
  steps: const [
    'Karnabaharı parçala.',
    'Baharat ve yağla harmanla.',
    'Fırında 25 dakika kızart.',
    'Sos ile servis et.',
  ],
);

final _recipe19 = Recipe(
  id: 'recipe_19',
  name: 'Tavuklu Quinoa Kasesi',
  emoji: '🥙',
  prepTimeMinutes: 28,
  categoryKey: 'high_protein',
  isPremium: true,
  difficulty: 'Kolay',
  collections: ['Yüksek Protein', 'Öğle Yemeği'],
  dietaryTags: [DietKeys.highProtein, DietKeys.glutenFree, DietKeys.halal],
  ingredients: const [
    RecipeIngredient(name: 'Chicken', amount: '200 g', isAvailable: true),
    RecipeIngredient(name: 'Quinoa', amount: '½ cup', isAvailable: false),
    RecipeIngredient(name: 'Cucumber', amount: '1 pcs', isAvailable: false),
    RecipeIngredient(name: 'Tomato', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '1 tbsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 480, protein: 40, carbs: 38, fat: 14),
  steps: const [
    'Quinoayı pişir.',
    'Tavuğu baharatla ızgarada pişir.',
    'Sebzeleri doğra.',
    'Kasede birleştir.',
  ],
);

final _recipe20 = Recipe(
  id: 'recipe_20',
  name: 'Humus & Tam Buğday',
  emoji: '🫓',
  prepTimeMinutes: 15,
  categoryKey: 'vegan',
  isPremium: true,
  difficulty: 'Kolay',
  collections: ['Vegan Haftası', 'Meze'],
  dietaryTags: [DietKeys.vegan, DietKeys.vegetarian, DietKeys.halal],
  ingredients: const [
    RecipeIngredient(name: 'Chickpeas', amount: '400 g', isAvailable: false),
    RecipeIngredient(name: 'Tahini', amount: '2 tbsp', isAvailable: false),
    RecipeIngredient(name: 'Garlic', amount: '2 cloves', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '3 tbsp', isAvailable: true),
    RecipeIngredient(name: 'Lemon', amount: '1 pcs', isAvailable: false),
  ],
  nutrition: const Nutrition(calories: 380, protein: 14, carbs: 44, fat: 16),
  steps: const [
    'Nohutu ve tahini blend et.',
    'Limon ve sarımsak ekle.',
    'Kıvam için su ayarla.',
    'Ekmekle servis et.',
  ],
);

final _recipe21 = Recipe(
  id: 'recipe_21',
  name: 'Etli Nohut',
  emoji: '🍛',
  prepTimeMinutes: 55,
  categoryKey: 'dinner',
  isPremium: true,
  difficulty: 'Orta',
  collections: ['Akşam', 'Tek Tencere'],
  dietaryTags: [DietKeys.highProtein, DietKeys.halal, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Beef', amount: '300 g', isAvailable: false),
    RecipeIngredient(name: 'Chickpeas', amount: '2 cups', isAvailable: false),
    RecipeIngredient(name: 'Onion', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Tomato', amount: '2 pcs', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '2 tbsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 580, protein: 42, carbs: 48, fat: 22),
  steps: const [
    'Eti kavur.',
    'Soğan ve domatesle sotele.',
    'Nohutu ekle ve pişir.',
    'Dinlendirip servis et.',
  ],
);

final _recipe22 = Recipe(
  id: 'recipe_22',
  name: 'Yulaf Ezmesi Bowl',
  emoji: '🥣',
  prepTimeMinutes: 12,
  categoryKey: 'quick',
  isPremium: true,
  difficulty: 'Kolay',
  collections: ['5 Dakika', 'Kahvaltı'],
  dietaryTags: [DietKeys.vegetarian, DietKeys.highProtein],
  ingredients: const [
    RecipeIngredient(name: 'Oats', amount: '½ cup', isAvailable: false),
    RecipeIngredient(name: 'Milk', amount: '200 ml', isAvailable: false),
    RecipeIngredient(name: 'Eggs', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Salt', amount: 'pinch', isAvailable: false),
  ],
  nutrition: const Nutrition(calories: 340, protein: 16, carbs: 48, fat: 8),
  steps: const [
    'Yulaf ve sütü pişir.',
    'Yumurtayı haşla ve dilimle.',
    'Kaseye diz.',
    'Baharatla servis et.',
  ],
);

final _recipe23 = Recipe(
  id: 'recipe_23',
  name: 'Peynirli Gözleme',
  emoji: '🫔',
  prepTimeMinutes: 30,
  categoryKey: 'dinner',
  isPremium: true,
  difficulty: 'Orta',
  collections: ['Öğle Yemeği', 'Bütçe Dostu'],
  dietaryTags: [DietKeys.vegetarian, DietKeys.halal],
  ingredients: const [
    RecipeIngredient(name: 'Flour', amount: '300 g', isAvailable: false),
    RecipeIngredient(name: 'Cheese', amount: '200 g', isAvailable: true),
    RecipeIngredient(name: 'Parsley', amount: '½ bunch', isAvailable: false),
    RecipeIngredient(name: 'Olive Oil', amount: '2 tbsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 520, protein: 22, carbs: 58, fat: 22),
  steps: const [
    'Hamuru yoğur.',
    'İç harcı hazırla.',
    'Aç ve sacda pişir.',
    'Sıcak servis et.',
  ],
);

final _recipe24 = Recipe(
  id: 'recipe_24',
  name: 'Sebzeli Omlet',
  emoji: '🍳',
  prepTimeMinutes: 14,
  categoryKey: 'quick',
  isPremium: true,
  difficulty: 'Kolay',
  collections: ['5 Dakika', 'Kahvaltı'],
  dietaryTags: [DietKeys.vegetarian, DietKeys.highProtein, DietKeys.keto],
  ingredients: const [
    RecipeIngredient(name: 'Eggs', amount: '3 pcs', isAvailable: true),
    RecipeIngredient(name: 'Zucchini', amount: '½ pcs', isAvailable: false),
    RecipeIngredient(name: 'Tomato', amount: '1 pcs', isAvailable: true),
    RecipeIngredient(name: 'Cheese', amount: '40 g', isAvailable: true),
    RecipeIngredient(name: 'Olive Oil', amount: '1 tsp', isAvailable: true),
  ],
  nutrition: const Nutrition(calories: 320, protein: 22, carbs: 10, fat: 20),
  steps: const [
    'Sebzeleri rendele.',
    'Yumurtayla çırp.',
    'Tavada pişir.',
    'Peynirle servis et.',
  ],
);

final _recipe25 = Recipe(
  id: 'recipe_25',
  name: 'Antep Fıstıklı Fit Bar',
  emoji: '🌰',
  prepTimeMinutes: 20,
  categoryKey: 'snack',
  isPremium: true,
  difficulty: 'Kolay',
  collections: ['Atıştırmalık', 'Meal Prep'],
  dietaryTags: [DietKeys.vegetarian, DietKeys.glutenFree],
  ingredients: const [
    RecipeIngredient(name: 'Pistachio', amount: '100 g', isAvailable: false),
    RecipeIngredient(name: 'Oats', amount: '1 cup', isAvailable: false),
    RecipeIngredient(name: 'Honey', amount: '2 tbsp', isAvailable: false),
    RecipeIngredient(name: 'Salt', amount: 'pinch', isAvailable: false),
  ],
  nutrition: const Nutrition(calories: 280, protein: 10, carbs: 26, fat: 16),
  steps: const [
    'Kuru malzemeleri karıştır.',
    'Bal ile bağla.',
    'Kalıba yay ve sıkıştır.',
    'Buzdolabında dilimle.',
  ],
);

/// Hardcoded Turkish default catalog: 10 free, 15 premium-only.
class DefaultRecipes {
  DefaultRecipes._();

  static List<Recipe> get all => List.unmodifiable(_all);

  static final List<Recipe> _all = [
    _recipe1,
    _recipe2,
    _recipe3,
    _recipe4,
    _recipe5,
    _recipe6,
    _recipe7,
    _recipe8,
    _recipe9,
    _recipe10,
    _recipe11,
    _recipe12,
    _recipe13,
    _recipe14,
    _recipe15,
    _recipe16,
    _recipe17,
    _recipe18,
    _recipe19,
    _recipe20,
    _recipe21,
    _recipe22,
    _recipe23,
    _recipe24,
    _recipe25,
  ];
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Meal Prep';

  @override
  String get navPantry => 'Bozdolabım';

  @override
  String get navRecipes => 'Tarifler';

  @override
  String get navShopping => 'Alışveriş';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get onboarding1Title => 'Mutfağını düzenle';

  @override
  String get onboarding1Body =>
      'Envanteri fotoğrafla veya elle ekle,\nkontrol sende olsun.';

  @override
  String get onboarding2Title => 'Akıllı tarifler';

  @override
  String get onboarding2Body =>
      'Elindekilere göre kişiselleştirilmiş\ntarif fikirleri al.';

  @override
  String get onboarding3Title => 'Alışveriş listesi';

  @override
  String get onboarding3Body =>
      'Eksik malzemeler otomatik listelenir.\nPaylaşması da kolay.';

  @override
  String get skip => 'Atla';

  @override
  String get continueButton => 'Devam';

  @override
  String get letsGo => 'Başlayalım';

  @override
  String get myKitchen => 'Mutfağım';

  @override
  String get yourPantry => 'Envanterin';

  @override
  String totalItemsCount(int count) {
    return 'Toplam: $count ürün';
  }

  @override
  String get addItem => 'Ürün ekle';

  @override
  String get addToPantry => 'Envantere ekle';

  @override
  String get takePhotoOrManual => 'Fotoğraf çek veya manuel gir';

  @override
  String get getStarted => 'Başla';

  @override
  String get delete => 'Sil';

  @override
  String get lowInventoryHint => 'Daha fazla tarif için daha çok ürün ekle';

  @override
  String get addMoreShort => 'Ekle →';

  @override
  String get pantryEmpty => 'Envanter boş';

  @override
  String get pantryEmptySubtitle =>
      'Kişiselleştirilmiş tarifler için mutfak ürünlerini eklemeye başla.';

  @override
  String get addFirstItem => 'İlk ürünü ekle';

  @override
  String get recipeSuggestions => 'Tarif önerileri';

  @override
  String get noPantryItems => 'Envanterinde ürün yok';

  @override
  String get noPantryItemsSubtitle =>
      'Önce mutfak ürünlerini ekle,\nsonra kişisel tarif önerileri al.';

  @override
  String get addItemsButton => 'Ürün ekle';

  @override
  String get discoverRecipes => 'Tarifleri keşfet';

  @override
  String personalizedRecipesBody(int count) {
    return '$count envanter ürününe göre\nsana özel tarifler oluşturalım.';
  }

  @override
  String get generateRecipes => 'Tarifleri oluştur';

  @override
  String get fromPantry => 'Envanterden';

  @override
  String get quickRecipes => 'Hızlı tarifler';

  @override
  String withPantryItemsCount(int count) {
    return 'Envanterinde $count ürünle';
  }

  @override
  String recipesFoundCount(int count) {
    return '$count tarif bulundu!';
  }

  @override
  String get refresh => 'Yenile';

  @override
  String get noRecipesInCategory => 'Bu kategoride tarif yok';

  @override
  String get recipesLoading => 'Tarifler Yükleniyor...';

  @override
  String get recipesLoadFailed => 'Tarifler yüklenemedi, lütfen tekrar deneyin';

  @override
  String get recipesEmpty => 'Henüz tarif yok';

  @override
  String get recipesNoDietMatch => 'Beslenme tercihlerine uygun hiç tarif yok';

  @override
  String get retryLoad => 'Tekrar Dene';

  @override
  String get premiumRecipeCreateHint => 'Premium\'da kendi tarifini oluştur';

  @override
  String get categoryBalanced => 'Dengeli';

  @override
  String prepTimeMin(int n) {
    return '$n dk';
  }

  @override
  String get recipeCardAllAvailable => 'Tüm malzemeler hazır ✓';

  @override
  String recipeCardPartial(int available, int total, int missing) {
    return '$available/$total uygun  ·  $missing eksik';
  }

  @override
  String get savedRecipesTitle => 'Kaydedilen Tarifler';

  @override
  String get premiumUnlimitedSavedRecipes =>
      'Premium için sınırsız kaydedilen tarif';

  @override
  String get upgradeToPremium => 'Premium\'a Yükselt';

  @override
  String get collectionsAll => 'Tümü';

  @override
  String get rateRecipeTitle => 'Değerlendir';

  @override
  String get addCommentLabel => 'Yorum Yap';

  @override
  String get ratingSave => 'Kaydet';

  @override
  String get ratingDelete => 'Sil';

  @override
  String get categoryAll => 'Tümü';

  @override
  String get categoryBreakfast => 'Kahvaltı';

  @override
  String get categoryDinner => 'Akşam';

  @override
  String get categorySnack => 'Atıştırmalık';

  @override
  String get categoryHighProtein => 'Yüksek protein';

  @override
  String get categoryVeganFilter => 'Vegan';

  @override
  String get categoryLowCarb => 'Düşük karbonhidrat';

  @override
  String get categoryQuick => 'Hızlı';

  @override
  String get categoryLunch => 'Öğle';

  @override
  String get difficultyEasy => 'Kolay';

  @override
  String get difficultyVeryEasy => 'Çok Kolay';

  @override
  String get difficultyMedium => 'Orta';

  @override
  String get difficultyHard => 'Zor';

  @override
  String get dietHighProtein => 'Yüksek protein';

  @override
  String get dietLowCarb => 'Düşük karbonhidrat';

  @override
  String get premiumFeatureTitle => 'Bu özellik Premium\'da var';

  @override
  String get premiumFeatureDefaultBody =>
      'Yapay zekâ araçları, haftalık plan ve sınırsız filtre ve kayıt için yükselt.';

  @override
  String get upgradeToPremiumCta => 'Premium\'a Yükselt';

  @override
  String get premiumUnlimitedFiltersTitle => 'Premium\'da sınırsız filtre';

  @override
  String get premiumUnlimitedFiltersBody =>
      'İstediğin kadar beslenme filtresi seçebilirsin.';

  @override
  String get premiumUnlimitedSavedTitle => 'Premium\'da sınırsız kaydetme';

  @override
  String get premiumUnlimitedSavedBody =>
      'İstediğin kadar tarif kaydedebilirsin.';

  @override
  String get featAiRecipeCreate => 'Yaratıcı Tarif Üret';

  @override
  String get aiCreateTitle => 'Kendi Tarifini Oluştur';

  @override
  String get aiCreateIngredientsLabel =>
      'Hangi malzemeleri kullanmak istiyorsun?';

  @override
  String get aiCreateIngredientHint => 'Malzeme ekle...';

  @override
  String get aiDietaryPreference => 'Beslenme Tercihi';

  @override
  String get aiCookingTime => 'Pişirme Süresi';

  @override
  String get aiCalorieTarget => 'Kalori Hedefi';

  @override
  String get aiGenerateRecipe => 'Tarifi Üret';

  @override
  String get aiGenerating => 'AI tarif oluşturuyor...';

  @override
  String get aiRecipeCreated => 'Tarif başarıyla oluşturuldu';

  @override
  String get aiOpenRecipe => 'Tarife Git';

  @override
  String get aiAddMissingToShopping => 'Eksikleri Alışverişe Ekle';

  @override
  String get aiAddedToShopping => 'Alışveriş listesine eklendi';

  @override
  String get aiRecipeBadge => '🤖 AI Tarifi';

  @override
  String get aiEditRecipe => 'Tarifi Düzenle';

  @override
  String get aiSaveRecipe => 'Kaydet';

  @override
  String get aiRecipeSaved => 'Tarif kaydedildi';

  @override
  String get aiRecipeNameLabel => 'Tarif adı';

  @override
  String get aiRecipeIngredientsLabel => 'Malzemeler';

  @override
  String get aiRecipeStepsLabel => 'Adımlar';

  @override
  String get aiMultilineHint => 'Her satıra bir öğe';

  @override
  String get aiRecipeUpdated => 'Tarif güncellendi';

  @override
  String get aiSaveUpdatedRecipe => 'Güncellenmiş Tarifi Kaydet';

  @override
  String get aiEmptyIngredients => 'Lütfen en az 1 malzeme seç';

  @override
  String get aiConnectionError => 'Bağlantı hatası, lütfen tekrar deneyin';

  @override
  String get aiRateLimited => 'Çok sık istek, lütfen birkaç dakika bekle';

  @override
  String get aiInvalidResponse =>
      'AI tarafından geçersiz tarif, lütfen tekrar dene';

  @override
  String get aiMisconfigured => 'AI yapılandırması eksik';

  @override
  String get aiUnknownError => 'Tarif oluşturulamadı, lütfen tekrar deneyin';

  @override
  String get aiInvalidInput => 'Lütfen geçerli bir değer gir';

  @override
  String get macroOptimizeTitle => 'Makroları Optimize Et';

  @override
  String get macroCurrentMacrosLabel => 'Mevcut makrolar';

  @override
  String get macroTargetMacroLabel => 'Hedef makro';

  @override
  String get macroTargetValueLabel => 'Hedef (g)';

  @override
  String get macroOptimizeButton => 'Makroları Optimize Et';

  @override
  String get macroOptimizing => 'Optimize ediliyor...';

  @override
  String get macroOptimizationResultTitle => 'Öneriler';

  @override
  String get macroUpdatedMacrosLabel => 'Güncellenmiş makrolar (tahmini)';

  @override
  String get mealPlanCreateTitle => 'Haftalık Plan Oluştur';

  @override
  String get mealPlanDaysLabel => 'Hangi günler?';

  @override
  String get mealPlanTotalCaloriesLabel => 'Toplam kalori? (opsiyonel)';

  @override
  String get mealPlanGenerateButton => 'Planı Oluştur';

  @override
  String get mealPlanGenerating => 'Plan oluşturuluyor...';

  @override
  String get mealPlanCreated => 'Plan oluşturuldu';

  @override
  String get mealPlanAddAllToShopping => 'Tümünü Alışverişe Ekle';

  @override
  String get mealPlanAddedToShopping =>
      'Plan malzemeleri alışveriş listene eklendi';

  @override
  String get featMacroOptimize => 'Makro Optimize Et';

  @override
  String get featWeeklyMealPlan => 'Haftalık Meal Plan';

  @override
  String get advancedFiltersTitle => 'Gelişmiş filtre';

  @override
  String get filterCookTime => 'Pişirme süresi';

  @override
  String get filterAny => 'Fark etmiyor';

  @override
  String filterUpToMinutes(int minutes) {
    return '≤ $minutes dk';
  }

  @override
  String get filter45Plus => '45+ dk';

  @override
  String get filterCaloriesMin => 'Kalori (min)';

  @override
  String get filterCaloriesMax => 'Kalori (max)';

  @override
  String get filterDifficulty => 'Zorluk';

  @override
  String get filterExcludeIngredients => 'Hariç tutulanlar';

  @override
  String get filterFavoriteIngredients => 'Favori malzemeler';

  @override
  String get filterCommaSeparatedHint => 'Virgülle ayır (örn: soğan, sarımsak)';

  @override
  String get clearAll => 'Temizle';

  @override
  String get applyFilters => 'Uygula';

  @override
  String get featNutritionAnalysis => 'Beslenme Analizi';

  @override
  String get authFullName => 'Ad Soyad';

  @override
  String get authTermsAgree => 'Şartları okudum ve kabul ediyorum';

  @override
  String get authTermsOpen => 'Şartlar';

  @override
  String get termsPlaceholderBody =>
      'Kullanım şartları burada yer alacaktır. Bu ekran MVP için örnek bir sayfadır.';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get freeTierBadge => 'Bedava';

  @override
  String get premiumRecipeBadge => 'Premium';

  @override
  String get shoppingListTitle => 'Alışveriş listesi';

  @override
  String get shoppingListsTitle => 'Alışveriş listeleri';

  @override
  String get newShoppingList => 'Yeni liste';

  @override
  String get shoppingListNameLabel => 'Liste adı';

  @override
  String get shoppingListNameHint => 'Örn. hafta sonu akşam yemeği, parti…';

  @override
  String get shoppingListDescriptionLabel => 'Açıklama';

  @override
  String get shoppingListDescriptionHint => 'İsteğe bağlı — bu liste ne için?';

  @override
  String get createShoppingList => 'Liste oluştur';

  @override
  String get saveList => 'Kaydet';

  @override
  String get editShoppingList => 'Listeyi düzenle';

  @override
  String get deleteShoppingList => 'Listeyi sil';

  @override
  String get deleteShoppingListConfirm =>
      'Bu liste ve içindeki tüm ürünler silinsin mi?';

  @override
  String get cannotDeleteLastList => 'En az bir alışveriş listesi gerekli.';

  @override
  String get chooseListForRecipe => 'Eksik malzemeleri şuraya ekle:';

  @override
  String get confirmAddToList => 'Listeye ekle';

  @override
  String listItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ürün',
      one: '1 ürün',
    );
    return '$_temp0';
  }

  @override
  String shoppingListProgress(int bought, int total) {
    return '$bought / $total tamam';
  }

  @override
  String get emptyListDetailTitle => 'Henüz bir şey yok';

  @override
  String get emptyListDetailBody =>
      'Tariften eksik malzeme ekleyebilir veya başka bir listeyi kullanabilirsin.';

  @override
  String get shoppingListNotFoundTitle => 'Alışveriş listesi bulunamadı';

  @override
  String get shoppingListNotFoundBody =>
      'Bu liste silinmiş olabilir ya da artık erişilemiyor.';

  @override
  String get goBack => 'Geri dön';

  @override
  String get cancel => 'İptal';

  @override
  String get shareTooltip => 'Paylaş';

  @override
  String get listCopied => 'Liste panoya kopyalandı!';

  @override
  String get copiedToClipboard => 'Panoya kopyalandı';

  @override
  String get dietaryPreferencesTitle => 'Beslenme Tercihleri';

  @override
  String get dietaryLimitFreeHint =>
      'Ücretsiz planda en fazla 2 tercih seçebilirsin';

  @override
  String get dietVegan => 'Vegan';

  @override
  String get dietVegetarian => 'Vejetaryen';

  @override
  String get dietKeto => 'Keto';

  @override
  String get dietGlutenFree => 'Glutensiz';

  @override
  String get dietHalal => 'Halal';

  @override
  String get dietNoDairy => 'Sütü Seçme';

  @override
  String itemsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ürün kaldı',
      one: '1 ürün kaldı',
    );
    return '$_temp0';
  }

  @override
  String itemsCompleted(int bought, int total) {
    return '$bought / $total tamamlandı';
  }

  @override
  String get emptyShoppingTitle => 'Alışveriş listen boş';

  @override
  String get emptyShoppingBody =>
      'Bir tarif seç ve eksik malzemeleri\notomatik olarak listene ekle.';

  @override
  String get goToRecipes => 'Tariflere git';

  @override
  String get emptyShoppingTip =>
      'Tarif ekranında \"Bu tarifi seç\"e basarak eksikleri listene ekleyebilirsin.';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get sectionFeatures => 'Özellikler';

  @override
  String get sectionGeneral => 'Genel';

  @override
  String get sectionAbout => 'Hakkında';

  @override
  String get language => 'Dil';

  @override
  String get notifications => 'Bildirimler';

  @override
  String get darkMode => 'Koyu tema';

  @override
  String get rateApp => 'Uygulamayı oyla';

  @override
  String get shareFriends => 'Arkadaşlarla paylaş';

  @override
  String get version => 'Sürüm';

  @override
  String get userLabel => 'Kullanıcı';

  @override
  String get freePlan => 'Ücretsiz plan';

  @override
  String get premiumPlan => '⭐ Premium';

  @override
  String get goPremium => 'Premium’a geç';

  @override
  String get premiumPrice => '₺/ay benzeri \$4.99';

  @override
  String get premiumBullet1 => '🤖 Yapay zekâ ile tarif kişiselleştirme';

  @override
  String get premiumBullet2 => '📊 Ayrıntılı beslenme takibi';

  @override
  String get premiumBullet3 => '🔄 Sınırsız envanter';

  @override
  String get premiumBullet4 => '📅 Haftalık planlama';

  @override
  String get tryFree7Days => 'Ücretsiz dene — 7 gün';

  @override
  String get premiumMemberTitle => 'Premium üyesin';

  @override
  String get premiumMemberSubtitle => 'Tüm özellikler açık';

  @override
  String get upgradedPremium => 'Premium’a yükseltildin! 🎉';

  @override
  String get featInventory => 'Envanter takibi';

  @override
  String get featRecipes => 'Tarif önerileri';

  @override
  String get featShopping => 'Alışveriş listesi';

  @override
  String get featAiPhoto => 'Yapay zekâ fotoğraf tanıma';

  @override
  String get featAiPersonal => 'Yapay zekâ kişiselleştirme';

  @override
  String get featNutrition => 'Beslenme takibi';

  @override
  String get featWeekly => 'Haftalık planlama';

  @override
  String get featUnlimited => 'Sınırsız tarif';

  @override
  String get proBadge => 'PRO';

  @override
  String get upgradeSheetTitle => 'Premium’a geç';

  @override
  String get upgradeSheetSubtitle =>
      'Yapay zekâ tarif önerileri, beslenme takibi ve daha fazlası.';

  @override
  String get upgradeSheetCta => '7 gün ücretsiz dene — \$4.99/ay';

  @override
  String get notNow => 'Şimdi değil';

  @override
  String get addToPantryTitle => 'Envantere ekle';

  @override
  String get tabPhoto => 'Fotoğraf';

  @override
  String get tabManual => 'Manuel';

  @override
  String itemsAddedToPantry(int count) {
    return '$count ürün envantere eklendi!';
  }

  @override
  String get cameraPreview => 'Kamera önizlemesi';

  @override
  String get cameraHint => 'Malzemelerini fotoğrafla,\nyapay zekâ tanısın';

  @override
  String get takePhoto => 'Fotoğraf çek';

  @override
  String get chooseFromLibrary => 'Galeriden seç';

  @override
  String get aiPhotoTip =>
      'Yapay zekâ, fotoğraftaki malzemeleri otomatik tanıyıp listeye ekleyecek.';

  @override
  String itemsDetectedBanner(int count) {
    return '$count ürün tespit edildi! Düzenle ve ekle.';
  }

  @override
  String get retake => 'Yeniden çek';

  @override
  String addAllCount(int count) {
    return 'Tümünü ekle ($count)';
  }

  @override
  String get itemName => 'Ürün adı';

  @override
  String get nameHint => 'Örn. domates, yumurta...';

  @override
  String get quantity => 'Miktar';

  @override
  String get addToPantryButton => 'Envantere ekle';

  @override
  String get quickAdd => 'Hızlı ekle';

  @override
  String itemAdded(String name) {
    return '$name eklendi!';
  }

  @override
  String get nutritionEstimated => 'Besin değeri (tahmini)';

  @override
  String get calories => 'Kalori';

  @override
  String get protein => 'Protein';

  @override
  String get carbs => 'Karbonhidrat';

  @override
  String get fat => 'Yağ';

  @override
  String get kcal => 'kcal';

  @override
  String get ingredientsSection => 'Malzemeler';

  @override
  String get instructionsSection => 'Hazırlanış';

  @override
  String missingCountShort(int count) {
    return '$count eksik';
  }

  @override
  String get legendHave => 'Var';

  @override
  String get legendMissing => 'Eksik';

  @override
  String missingIngredientsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eksik malzeme',
      one: '1 eksik malzeme',
    );
    return '$_temp0 — listene ekleyebilirsin';
  }

  @override
  String get allIngredientsAvailable => 'Tüm malzemeler envanterinde!';

  @override
  String selectRecipeWithMissing(int count) {
    return 'Bu tarifi seç  ($count eksik → listeye eklenir)';
  }

  @override
  String get selectRecipe => 'Bu tarifi seç';

  @override
  String get sheetReadyTitle => 'Pişirmeye hazırsın!';

  @override
  String get sheetSelectedTitle => 'Tarif seçildi!';

  @override
  String sheetReadyBody(String recipeName) {
    return '$recipeName için her şey tamam.\nAfiyet olsun!';
  }

  @override
  String sheetAddedBody(int count, String recipeName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eksik malzeme',
      one: '1 eksik malzeme',
    );
    return '$_temp0 ($recipeName)\nalışveriş listene eklendi.';
  }

  @override
  String get done => 'Tamam';

  @override
  String get generalGroup => 'Genel';

  @override
  String get recipeR1Name => 'Şakşuka';

  @override
  String get recipeR2Name => 'Tavuk sote';

  @override
  String get recipeR3Name => 'Peynirli omlet';

  @override
  String get recipeR4Name => 'Patates kızartması';

  @override
  String get recipeR5Name => 'Sarımsaklı tavuk';

  @override
  String get recipeR1Step0 => 'Soğanı ince doğrayıp zeytinyağında kavur.';

  @override
  String get recipeR1Step1 => 'Biber ve domatesi doğra, tavaya ekle ve kavur.';

  @override
  String get recipeR1Step2 => 'Yumurtaları kırıp karıştır.';

  @override
  String get recipeR1Step3 =>
      'Kısık ateşte pişir, tuz ve karabiberle tatlandır.';

  @override
  String get recipeR1Step4 => 'Sıcak servis et.';

  @override
  String get recipeR2Step0 => 'Tavuğu küp küp doğra.';

  @override
  String get recipeR2Step1 => 'Soğan ve sarımsağı zeytinyağında kavur.';

  @override
  String get recipeR2Step2 => 'Tavuğu ekle ve her yüzünü kızart.';

  @override
  String get recipeR2Step3 =>
      'Domates ve biberi ekle, tuz ve karabiberle tatlandır.';

  @override
  String get recipeR2Step4 => 'Kapağı kapat, 15 dakika kısık ateşte pişir.';

  @override
  String get recipeR2Step5 => 'Kuru kekikle bitip sıcak servis et.';

  @override
  String get recipeR3Step0 => 'Yumurtaları tuzla çırp.';

  @override
  String get recipeR3Step1 => 'Tereyağını yapışmaz tavada erit.';

  @override
  String get recipeR3Step2 => 'Yumurta karışımını dök.';

  @override
  String get recipeR3Step3 =>
      'Altı tutunca bir tarafa rendelenmiş peyniri serp.';

  @override
  String get recipeR3Step4 => 'Katlayıp tabağa al.';

  @override
  String get recipeR4Step0 => 'Patatesleri soyup şerit doğra.';

  @override
  String get recipeR4Step1 => 'Kağıt havluyla iyice kurula.';

  @override
  String get recipeR4Step2 => 'Sıcak yağda kızart.';

  @override
  String get recipeR4Step3 => 'Yağını süz, hemen tuzla.';

  @override
  String get recipeR4Step4 => 'Sıcak servis et.';

  @override
  String get recipeR5Step0 =>
      'Sarımsak, zeytinyağı ve limon suyunu tavuk için marine sos olarak karıştır.';

  @override
  String get recipeR5Step1 => '30 dakika marine et.';

  @override
  String get recipeR5Step2 => 'Fırını 200 °C’ye ısıt.';

  @override
  String get recipeR5Step3 => 'Kekik ve tuz serp.';

  @override
  String get recipeR5Step4 => '25–30 dakika pişir.';

  @override
  String get ingEggs => 'Yumurta';

  @override
  String get ingTomato => 'Domates';

  @override
  String get ingGreenPepper => 'Yeşil biber';

  @override
  String get ingOnion => 'Soğan';

  @override
  String get ingOliveOil => 'Zeytinyağı';

  @override
  String get ingChicken => 'Tavuk';

  @override
  String get ingGarlic => 'Sarımsak';

  @override
  String get ingRedPepper => 'Kırmızı biber';

  @override
  String get ingCheese => 'Peynir';

  @override
  String get ingButter => 'Tereyağı';

  @override
  String get ingSalt => 'Tuz';

  @override
  String get ingPotato => 'Patates';

  @override
  String get ingSunflowerOil => 'Ayçiçek yağı';

  @override
  String get ingLemon => 'Limon';

  @override
  String get ingThyme => 'Kekik';

  @override
  String get ingCucumber => 'Salatalık';

  @override
  String get ingParsley => 'Maydanoz';

  @override
  String get ingBroccoli => 'Brokoli';

  @override
  String get ingMilk => 'Süt';

  @override
  String get ingBread => 'Ekmek';

  @override
  String get ingBanana => 'Muz';

  @override
  String get ingApple => 'Elma';

  @override
  String get amtToTaste => 'İsteğe göre';

  @override
  String get unitPcs => 'adet';

  @override
  String get unitG => 'g';

  @override
  String get unitKg => 'kg';

  @override
  String get unitMl => 'ml';

  @override
  String get unitL => 'L';

  @override
  String get unitBunch => 'demet';

  @override
  String get unitBox => 'kutu';

  @override
  String get unitBottle => 'şişe';

  @override
  String get unitCloves => 'diş';

  @override
  String get unitHead => 'baş';

  @override
  String get unitTbsp => 'yk';

  @override
  String get unitTsp => 'çk';

  @override
  String get unitMlLong => 'ml';

  @override
  String get langEnglish => 'İngilizce';

  @override
  String get langSpanish => 'İspanyolca';

  @override
  String get langTurkish => 'Türkçe';

  @override
  String get authScreenTitle => 'Hesap';

  @override
  String get authHeadlineSignIn => 'Tekrar hoş geldin';

  @override
  String get authHeadlineSignUp => 'Hesap oluştur';

  @override
  String get authSubSignIn =>
      'Mutfağını cihazlar arasında senkronize etmek için giriş yap.';

  @override
  String get authSubSignUp => 'Meal Prep’e katıl, daha akıllıca plan yap.';

  @override
  String get authEmail => 'E-posta';

  @override
  String get authPassword => 'Şifre';

  @override
  String get authConfirmPassword => 'Şifre tekrar';

  @override
  String get authForgotPassword => 'Şifremi unuttum';

  @override
  String get authSignInButton => 'Giriş yap';

  @override
  String get authSignUpButton => 'Kayıt ol';

  @override
  String get authToggleNoAccount => 'Hesabın yok mu?';

  @override
  String get authToggleHasAccount => 'Zaten hesabın var mı?';

  @override
  String get authToggleSignUp => 'Kayıt ol';

  @override
  String get authToggleSignIn => 'Giriş yap';

  @override
  String get authOrWith => 'veya şununla devam et';

  @override
  String get authContinueGoogle => 'Google';

  @override
  String get authContinueApple => 'Apple';

  @override
  String get authUiOnlySnack => 'Şimdilik sadece arayüz — yakında!';

  @override
  String get addManualIngredientFab => 'Malzeme ekle';

  @override
  String get shoppingIngredientNameLabel => 'Malzeme adı';

  @override
  String get shoppingIngredientNameHint => 'Örn. domates, süt…';

  @override
  String get shoppingUnitFieldLabel => 'Birim';

  @override
  String get shoppingAddIngredientButton => 'Ekle';

  @override
  String get shoppingBoughtSemantics => 'Satın alındı';

  @override
  String get shoppingDeleteItemTooltip => 'Sil';

  @override
  String get manualShoppingGroup => 'Elle eklenenler';

  @override
  String get shoppingNameRequired => 'Malzeme adı lazım';

  @override
  String get shoppingQuantityInvalid => 'Miktar 0\'dan büyük olsun';

  @override
  String get addToShoppingListShort => 'Alışverişe ekle';

  @override
  String get sortTooltip => 'Sırala';

  @override
  String get sortBestMatch => 'En iyi eşleşme';

  @override
  String get sortNewest => 'Yeni';

  @override
  String get sortPopular => 'Popüler';

  @override
  String get sortRating => 'Puan';

  @override
  String get matchPerfectShort => 'Mükemmel eşleşme ✓';

  @override
  String get matchNeedPrefix => 'Gerekli:';

  @override
  String get inventorySearchHint => 'Envanterde ara';

  @override
  String get inventoryEmptyTitle => 'Henüz ürün yok';

  @override
  String get inventoryEmptyBody =>
      'Tarif eşleşmesi için Mutfağım ekranından ürün eklemeye başla.';

  @override
  String get inventoryNoResults => 'Sonuç bulunamadı';

  @override
  String get inventoryTryDifferentSearch => 'Farklı bir arama deneyin.';

  @override
  String get inventoryEditItemTitle => 'Ürünü düzenle';

  @override
  String get inventoryItemNameLabel => 'Ürün adı';

  @override
  String get inventoryAmountLabel => 'Miktar';

  @override
  String get inventoryEmojiLabel => 'Emoji';

  @override
  String get inventorySavedToast => 'Kaydedildi';

  @override
  String get inventoryAddFailedToast => 'Ürün eklenemedi. Lütfen tekrar dene.';

  @override
  String get inventoryUnitMismatchTitle => 'Birim uyuşmuyor';

  @override
  String get inventoryUseExistingUnitCta => 'Mevcut birimi kullan';

  @override
  String inventoryUnitMismatchBody(
    String item,
    String existingUnit,
    String pickedUnit,
  ) {
    return '$item zaten $existingUnit olarak kayıtlı. Sen $pickedUnit seçtin.';
  }
}

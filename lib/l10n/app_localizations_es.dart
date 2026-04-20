// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Meal Prep';

  @override
  String get navPantry => 'Despensa';

  @override
  String get navRecipes => 'Recetas';

  @override
  String get navShopping => 'Compra';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get onboarding1Title => 'Organiza tu cocina';

  @override
  String get onboarding1Body =>
      'Controla tu despensa con una foto\no añade productos a mano.';

  @override
  String get onboarding2Title => 'Recetas inteligentes';

  @override
  String get onboarding2Body =>
      'Recibe ideas de recetas personalizadas\nsegún lo que ya tienes.';

  @override
  String get onboarding3Title => 'Lista de compra';

  @override
  String get onboarding3Body =>
      'Los ingredientes que faltan se listan\nautomáticamente. Fácil de compartir.';

  @override
  String get skip => 'Saltar';

  @override
  String get continueButton => 'Continuar';

  @override
  String get letsGo => 'Empezar';

  @override
  String get myKitchen => 'Mi cocina';

  @override
  String get yourPantry => 'Tu despensa';

  @override
  String totalItemsCount(int count) {
    return 'Total: $count productos';
  }

  @override
  String get addItem => 'Añadir';

  @override
  String get addToPantry => 'Añadir a la despensa';

  @override
  String get takePhotoOrManual => 'Haz una foto o añade a mano';

  @override
  String get getStarted => 'Empezar';

  @override
  String get delete => 'Eliminar';

  @override
  String get lowInventoryHint =>
      'Añade más productos para descubrir más recetas';

  @override
  String get addMoreShort => 'Añadir →';

  @override
  String get pantryEmpty => 'Despensa vacía';

  @override
  String get pantryEmptySubtitle =>
      'Empieza añadiendo ingredientes para descubrir recetas personalizadas.';

  @override
  String get addFirstItem => 'Añadir el primero';

  @override
  String get recipeSuggestions => 'Sugerencias de recetas';

  @override
  String get noPantryItems => 'No hay productos en tu despensa';

  @override
  String get noPantryItemsSubtitle =>
      'Primero añade ingredientes a tu despensa\npara obtener sugerencias personalizadas.';

  @override
  String get addItemsButton => 'Añadir productos';

  @override
  String get discoverRecipes => 'Descubre recetas';

  @override
  String personalizedRecipesBody(int count) {
    return 'Crearemos recetas personalizadas\nsegún tus $count productos en despensa.';
  }

  @override
  String get generateRecipes => 'Generar recetas';

  @override
  String get fromPantry => 'Desde despensa';

  @override
  String get quickRecipes => 'Recetas rápidas';

  @override
  String withPantryItemsCount(int count) {
    return 'Con $count productos en tu despensa';
  }

  @override
  String recipesFoundCount(int count) {
    return '¡$count recetas encontradas!';
  }

  @override
  String get refresh => 'Actualizar';

  @override
  String get noRecipesInCategory => 'No hay recetas en esta categoría';

  @override
  String get recipesLoading => 'Cargando recetas…';

  @override
  String get recipesLoadFailed =>
      'No se pudieron cargar las recetas. Inténtalo de nuevo.';

  @override
  String get recipesEmpty => 'Aún no hay recetas';

  @override
  String get recipesNoDietMatch =>
      'Ninguna receta coincide con tus preferencias';

  @override
  String get retryLoad => 'Reintentar';

  @override
  String get premiumRecipeCreateHint => 'Crea tu propia receta con Premium';

  @override
  String get categoryBalanced => 'Equilibrada';

  @override
  String prepTimeMin(int n) {
    return '$n min';
  }

  @override
  String get recipeCardAllAvailable => 'Todos los ingredientes disponibles ✓';

  @override
  String recipeCardPartial(int available, int total, int missing) {
    return '$available/$total disponibles  ·  $missing faltan';
  }

  @override
  String get savedRecipesTitle => 'Recetas guardadas';

  @override
  String get premiumUnlimitedSavedRecipes =>
      'Recetas guardadas ilimitadas con Premium';

  @override
  String get upgradeToPremium => 'Mejorar a Premium';

  @override
  String get collectionsAll => 'Todas';

  @override
  String get rateRecipeTitle => 'Valorar';

  @override
  String get addCommentLabel => 'Añadir comentario';

  @override
  String get ratingSave => 'Guardar';

  @override
  String get ratingDelete => 'Eliminar';

  @override
  String get categoryAll => 'Todas';

  @override
  String get categoryBreakfast => 'Desayuno';

  @override
  String get categoryDinner => 'Cena';

  @override
  String get categorySnack => 'Snack';

  @override
  String get categoryHighProtein => 'Alta proteína';

  @override
  String get categoryVeganFilter => 'Vegano';

  @override
  String get categoryLowCarb => 'Bajo carbohidratos';

  @override
  String get categoryQuick => 'Rápido';

  @override
  String get categoryLunch => 'Almuerzo';

  @override
  String get difficultyEasy => 'Fácil';

  @override
  String get difficultyVeryEasy => 'Muy fácil';

  @override
  String get difficultyMedium => 'Medio';

  @override
  String get difficultyHard => 'Difícil';

  @override
  String get dietHighProtein => 'Alta proteína';

  @override
  String get dietLowCarb => 'Bajo carbohidratos';

  @override
  String get premiumFeatureTitle => 'Esta función es Premium';

  @override
  String get premiumFeatureDefaultBody =>
      'Desbloquea IA, plan semanal y filtros y guardados ilimitados.';

  @override
  String get upgradeToPremiumCta => 'Mejorar a Premium';

  @override
  String get premiumUnlimitedFiltersTitle => 'Filtros ilimitados en Premium';

  @override
  String get premiumUnlimitedFiltersBody =>
      'Elige todos los filtros dietéticos que necesites.';

  @override
  String get premiumUnlimitedSavedTitle => 'Guardados ilimitados en Premium';

  @override
  String get premiumUnlimitedSavedBody =>
      'Guarda todas las recetas que quieras.';

  @override
  String get featAiRecipeCreate => 'Crear receta (IA)';

  @override
  String get featMacroOptimize => 'Optimizar macros';

  @override
  String get featWeeklyMealPlan => 'Plan semanal';

  @override
  String get featNutritionAnalysis => 'Análisis nutricional';

  @override
  String get authFullName => 'Nombre completo';

  @override
  String get authTermsAgree => 'He leído y acepto los términos';

  @override
  String get authTermsOpen => 'Términos';

  @override
  String get termsPlaceholderBody =>
      'Los términos del servicio aparecerán aquí. Esta es una pantalla provisional para el MVP.';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get freeTierBadge => 'Gratis';

  @override
  String get premiumRecipeBadge => 'Premium';

  @override
  String get shoppingListTitle => 'Lista de compra';

  @override
  String get shoppingListsTitle => 'Listas de compra';

  @override
  String get newShoppingList => 'Nueva lista';

  @override
  String get shoppingListNameLabel => 'Nombre de la lista';

  @override
  String get shoppingListNameHint => 'p. ej. Cena del fin de semana, Fiesta…';

  @override
  String get shoppingListDescriptionLabel => 'Descripción';

  @override
  String get shoppingListDescriptionHint =>
      'Opcional — ¿para qué es esta lista?';

  @override
  String get createShoppingList => 'Crear lista';

  @override
  String get saveList => 'Guardar';

  @override
  String get editShoppingList => 'Editar lista';

  @override
  String get deleteShoppingList => 'Eliminar lista';

  @override
  String get deleteShoppingListConfirm =>
      '¿Eliminar esta lista y todos sus artículos?';

  @override
  String get cannotDeleteLastList => 'Necesitas al menos una lista de compra.';

  @override
  String get chooseListForRecipe => 'Añadir ingredientes faltantes a';

  @override
  String get confirmAddToList => 'Añadir a la lista';

  @override
  String listItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count artículos',
      one: '1 artículo',
    );
    return '$_temp0';
  }

  @override
  String shoppingListProgress(int bought, int total) {
    return '$bought / $total hecho';
  }

  @override
  String get emptyListDetailTitle => 'Aún no hay nada';

  @override
  String get emptyListDetailBody =>
      'Añade ingredientes desde una receta u otra lista.';

  @override
  String get shoppingListNotFoundTitle => 'Lista no encontrada';

  @override
  String get shoppingListNotFoundBody =>
      'Esta lista puede haberse eliminado o ya no está disponible.';

  @override
  String get goBack => 'Volver';

  @override
  String get cancel => 'Cancelar';

  @override
  String get shareTooltip => 'Compartir';

  @override
  String get listCopied => '¡Lista copiada al portapapeles!';

  @override
  String get copiedToClipboard => 'Copiado al portapapeles';

  @override
  String get dietaryPreferencesTitle => 'Preferencias alimentarias';

  @override
  String get dietaryLimitFreeHint =>
      'En el plan gratis puedes elegir hasta 2 preferencias';

  @override
  String get dietVegan => 'Vegano';

  @override
  String get dietVegetarian => 'Vegetariano';

  @override
  String get dietKeto => 'Keto';

  @override
  String get dietGlutenFree => 'Sin gluten';

  @override
  String get dietHalal => 'Halal';

  @override
  String get dietNoDairy => 'Sin lácteos';

  @override
  String itemsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Quedan $count artículos',
      one: 'Queda 1 artículo',
    );
    return '$_temp0';
  }

  @override
  String itemsCompleted(int bought, int total) {
    return '$bought / $total completados';
  }

  @override
  String get emptyShoppingTitle => 'La lista está vacía';

  @override
  String get emptyShoppingBody =>
      'Elige una receta y añade los ingredientes que faltan\na tu lista automáticamente.';

  @override
  String get goToRecipes => 'Ir a recetas';

  @override
  String get emptyShoppingTip =>
      'En la pantalla de recetas, pulsa \"Seleccionar esta receta\" para añadir lo que falta a tu lista.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get sectionFeatures => 'Funciones';

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionAbout => 'Acerca de';

  @override
  String get language => 'Idioma';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get rateApp => 'Valorar la app';

  @override
  String get shareFriends => 'Compartir con amigos';

  @override
  String get version => 'Versión';

  @override
  String get userLabel => 'Usuario';

  @override
  String get freePlan => 'Plan gratuito';

  @override
  String get premiumPlan => '⭐ Premium';

  @override
  String get goPremium => 'Hazte Premium';

  @override
  String get premiumPrice => '4,99 \$/mes';

  @override
  String get premiumBullet1 => '🤖 Personalización de recetas con IA';

  @override
  String get premiumBullet2 => '📊 Seguimiento nutricional detallado';

  @override
  String get premiumBullet3 => '🔄 Inventario ilimitado';

  @override
  String get premiumBullet4 => '📅 Planificación semanal';

  @override
  String get tryFree7Days => 'Prueba gratis — 7 días';

  @override
  String get premiumMemberTitle => 'Eres miembro Premium';

  @override
  String get premiumMemberSubtitle => 'Todas las funciones desbloqueadas';

  @override
  String get upgradedPremium => '¡Te has pasado a Premium! 🎉';

  @override
  String get featInventory => 'Control de inventario';

  @override
  String get featRecipes => 'Sugerencias de recetas';

  @override
  String get featShopping => 'Lista de compra';

  @override
  String get featAiPhoto => 'Reconocimiento por foto con IA';

  @override
  String get featAiPersonal => 'Personalización con IA';

  @override
  String get featNutrition => 'Seguimiento nutricional';

  @override
  String get featWeekly => 'Planificación semanal';

  @override
  String get featUnlimited => 'Recetas ilimitadas';

  @override
  String get proBadge => 'PRO';

  @override
  String get upgradeSheetTitle => 'Hazte Premium';

  @override
  String get upgradeSheetSubtitle =>
      'Sugerencias con IA, información nutricional y más.';

  @override
  String get upgradeSheetCta => 'Prueba 7 días gratis — 4,99 \$/mes';

  @override
  String get notNow => 'Ahora no';

  @override
  String get addToPantryTitle => 'Añadir a la despensa';

  @override
  String get tabPhoto => 'Foto';

  @override
  String get tabManual => 'Manual';

  @override
  String itemsAddedToPantry(int count) {
    return '¡$count productos añadidos a la despensa!';
  }

  @override
  String get cameraPreview => 'Vista previa';

  @override
  String get cameraHint =>
      'Fotografía los ingredientes\ny deja que la IA los identifique';

  @override
  String get takePhoto => 'Hacer foto';

  @override
  String get chooseFromLibrary => 'Elegir de la galería';

  @override
  String get aiPhotoTip =>
      'La IA detectará los ingredientes en la foto y los añadirá a tu lista.';

  @override
  String itemsDetectedBanner(int count) {
    return '¡$count productos detectados! Revísalos y añádelos.';
  }

  @override
  String get retake => 'Repetir';

  @override
  String addAllCount(int count) {
    return 'Añadir todo ($count)';
  }

  @override
  String get itemName => 'Nombre del producto';

  @override
  String get nameHint => 'p. ej. tomates, huevos...';

  @override
  String get quantity => 'Cantidad';

  @override
  String get addToPantryButton => 'Añadir a la despensa';

  @override
  String get quickAdd => 'Añadir rápido';

  @override
  String itemAdded(String name) {
    return '¡$name añadido!';
  }

  @override
  String get nutritionEstimated => 'Nutrición (estimada)';

  @override
  String get calories => 'Calorías';

  @override
  String get protein => 'Proteínas';

  @override
  String get carbs => 'Carbos';

  @override
  String get fat => 'Grasas';

  @override
  String get kcal => 'kcal';

  @override
  String get ingredientsSection => 'Ingredientes';

  @override
  String get instructionsSection => 'Preparación';

  @override
  String missingCountShort(int count) {
    return 'Faltan $count';
  }

  @override
  String get legendHave => 'Lo tienes';

  @override
  String get legendMissing => 'Falta';

  @override
  String missingIngredientsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Faltan $count ingredientes',
      one: 'Falta 1 ingrediente',
    );
    return '$_temp0 — puedes añadirlos a tu lista';
  }

  @override
  String get allIngredientsAvailable =>
      '¡Todos los ingredientes están en tu despensa!';

  @override
  String selectRecipeWithMissing(int count) {
    return 'Seleccionar receta  ($count faltan → se añaden a la lista)';
  }

  @override
  String get selectRecipe => 'Seleccionar esta receta';

  @override
  String get sheetReadyTitle => '¡Listo para cocinar!';

  @override
  String get sheetSelectedTitle => '¡Receta seleccionada!';

  @override
  String sheetReadyBody(String recipeName) {
    return 'Tienes todo lo necesario para\n$recipeName. ¡Buen provecho!';
  }

  @override
  String sheetAddedBody(int count, String recipeName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ingredientes que faltan',
      one: '1 ingrediente que falta',
    );
    return '$_temp0 para $recipeName\nañadidos a tu lista de compra.';
  }

  @override
  String get done => 'Listo';

  @override
  String get generalGroup => 'General';

  @override
  String get recipeR1Name => 'Huevos shakshuka';

  @override
  String get recipeR2Name => 'Salteado de pollo';

  @override
  String get recipeR3Name => 'Tortilla de queso';

  @override
  String get recipeR4Name => 'Patatas fritas';

  @override
  String get recipeR5Name => 'Pollo al ajo';

  @override
  String get recipeR1Step0 =>
      'Pica la cebolla fina y sofríela en aceite de oliva.';

  @override
  String get recipeR1Step1 =>
      'Corta el pimiento y el tomate, añádelos a la sartén y sofríe.';

  @override
  String get recipeR1Step2 => 'Incorpora los huevos y mezcla.';

  @override
  String get recipeR1Step3 => 'Cocina a fuego lento, salpimienta al gusto.';

  @override
  String get recipeR1Step4 => 'Sirve caliente.';

  @override
  String get recipeR2Step0 => 'Corta el pollo en dados.';

  @override
  String get recipeR2Step1 => 'Sofríe la cebolla y el ajo en aceite de oliva.';

  @override
  String get recipeR2Step2 => 'Añade el pollo y dóralo por todos lados.';

  @override
  String get recipeR2Step3 => 'Añade tomate y pimiento, salpimienta.';

  @override
  String get recipeR2Step4 => 'Tapa y cocina a fuego lento 15 minutos.';

  @override
  String get recipeR2Step5 => 'Termina con tomillo seco y sirve caliente.';

  @override
  String get recipeR3Step0 => 'Bate los huevos con sal.';

  @override
  String get recipeR3Step1 =>
      'Derrite la mantequilla en una sartén antiadherente.';

  @override
  String get recipeR3Step2 => 'Vierte la mezcla de huevo.';

  @override
  String get recipeR3Step3 =>
      'Cuando cuaje la base, espolvorea queso rallado en un lado.';

  @override
  String get recipeR3Step4 => 'Dobla y sirve en un plato.';

  @override
  String get recipeR4Step0 => 'Pela las patatas y córtalas en bastones.';

  @override
  String get recipeR4Step1 => 'Sécalas bien con papel de cocina.';

  @override
  String get recipeR4Step2 => 'Fríe en aceite caliente hasta dorar.';

  @override
  String get recipeR4Step3 => 'Escurre el aceite y sal al momento.';

  @override
  String get recipeR4Step4 => 'Sirve caliente.';

  @override
  String get recipeR5Step0 =>
      'Mezcla ajo, aceite de oliva y limón como marinada para el pollo.';

  @override
  String get recipeR5Step1 => 'Marina 30 minutos.';

  @override
  String get recipeR5Step2 => 'Precalienta el horno a 200 °C.';

  @override
  String get recipeR5Step3 => 'Espolvorea tomillo y sal.';

  @override
  String get recipeR5Step4 => 'Hornea 25–30 minutos.';

  @override
  String get ingEggs => 'Huevos';

  @override
  String get ingTomato => 'Tomate';

  @override
  String get ingGreenPepper => 'Pimiento verde';

  @override
  String get ingOnion => 'Cebolla';

  @override
  String get ingOliveOil => 'Aceite de oliva';

  @override
  String get ingChicken => 'Pollo';

  @override
  String get ingGarlic => 'Ajo';

  @override
  String get ingRedPepper => 'Pimiento rojo';

  @override
  String get ingCheese => 'Queso';

  @override
  String get ingButter => 'Mantequilla';

  @override
  String get ingSalt => 'Sal';

  @override
  String get ingPotato => 'Patata';

  @override
  String get ingSunflowerOil => 'Aceite de girasol';

  @override
  String get ingLemon => 'Limón';

  @override
  String get ingThyme => 'Tomillo';

  @override
  String get ingCucumber => 'Pepino';

  @override
  String get ingParsley => 'Perejil';

  @override
  String get ingBroccoli => 'Brócoli';

  @override
  String get ingMilk => 'Leche';

  @override
  String get ingBread => 'Pan';

  @override
  String get ingBanana => 'Plátano';

  @override
  String get ingApple => 'Manzana';

  @override
  String get amtToTaste => 'Al gusto';

  @override
  String get unitPcs => 'uds.';

  @override
  String get unitG => 'g';

  @override
  String get unitKg => 'kg';

  @override
  String get unitMl => 'ml';

  @override
  String get unitL => 'L';

  @override
  String get unitBunch => 'manojo';

  @override
  String get unitBox => 'caja';

  @override
  String get unitBottle => 'botella';

  @override
  String get unitCloves => 'dientes';

  @override
  String get unitHead => 'cabeza';

  @override
  String get unitTbsp => 'cda.';

  @override
  String get unitTsp => 'cdta.';

  @override
  String get unitMlLong => 'ml';

  @override
  String get langEnglish => 'Inglés';

  @override
  String get langSpanish => 'Español';

  @override
  String get langTurkish => 'Turco';

  @override
  String get authScreenTitle => 'Cuenta';

  @override
  String get authHeadlineSignIn => 'Bienvenido de nuevo';

  @override
  String get authHeadlineSignUp => 'Crea tu cuenta';

  @override
  String get authSubSignIn =>
      'Inicia sesión para sincronizar tu cocina entre dispositivos.';

  @override
  String get authSubSignUp =>
      'Únete a Meal Prep y planifica comidas con más inteligencia.';

  @override
  String get authEmail => 'Correo';

  @override
  String get authPassword => 'Contraseña';

  @override
  String get authConfirmPassword => 'Confirmar contraseña';

  @override
  String get authForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get authSignInButton => 'Iniciar sesión';

  @override
  String get authSignUpButton => 'Registrarse';

  @override
  String get authToggleNoAccount => '¿No tienes cuenta?';

  @override
  String get authToggleHasAccount => '¿Ya tienes cuenta?';

  @override
  String get authToggleSignUp => 'Regístrate';

  @override
  String get authToggleSignIn => 'Inicia sesión';

  @override
  String get authOrWith => 'o continúa con';

  @override
  String get authContinueGoogle => 'Google';

  @override
  String get authContinueApple => 'Apple';

  @override
  String get authUiOnlySnack => 'Por ahora esta pantalla es solo diseño.';

  @override
  String get addManualIngredientFab => 'Añadir ingrediente';

  @override
  String get shoppingIngredientNameLabel => 'Nombre del producto';

  @override
  String get shoppingIngredientNameHint => 'p. ej. tomates, leche…';

  @override
  String get shoppingUnitFieldLabel => 'Unidad';

  @override
  String get shoppingAddIngredientButton => 'Añadir';

  @override
  String get shoppingBoughtSemantics => 'Comprado';

  @override
  String get shoppingDeleteItemTooltip => 'Eliminar';

  @override
  String get manualShoppingGroup => 'Añadidos a mano';

  @override
  String get shoppingNameRequired => 'Escribe un nombre';

  @override
  String get shoppingQuantityInvalid => 'La cantidad debe ser mayor que 0';

  @override
  String get addToShoppingListShort => 'Añadir a la lista';
}

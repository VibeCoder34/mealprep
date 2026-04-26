import 'package:flutter_test/flutter_test.dart';
import 'package:mealprep/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: 'http://localhost',
      anonKey: 'test_anon_key',
      authOptions: const FlutterAuthClientOptions(autoRefreshToken: false),
    );
    await tester.pumpWidget(const MealPrepApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    final tr = find.text('Tekrar hoş geldin').evaluate().isNotEmpty;
    final en = find.text('Welcome back').evaluate().isNotEmpty;
    expect(tr || en, true);
  });
}

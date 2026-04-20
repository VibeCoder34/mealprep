import 'package:flutter_test/flutter_test.dart';
import 'package:mealprep/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MealPrepApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Tekrar hoş geldin'), findsOneWidget);
  });
}

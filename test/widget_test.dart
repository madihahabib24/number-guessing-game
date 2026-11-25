import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';

void main() {
  testWidgets('Number Guessing Game test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Number Guessing Game'), findsOneWidget);
    expect(find.text('Start Game'), findsOneWidget);
    expect(find.text('View History'), findsOneWidget);
  });
}

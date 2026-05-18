import 'package:flutter_test/flutter_test.dart';
import 'package:herafi_app/app/herafi_app.dart';

void main() {
  testWidgets('shows welcome screen on launch', (WidgetTester tester) async {
    await tester.pumpWidget(const HerafiApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Herafi'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}

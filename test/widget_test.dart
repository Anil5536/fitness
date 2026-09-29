import 'package:flutter_test/flutter_test.dart';

import 'package:routinely/main.dart';

void main() {
  testWidgets('Splash advances to welcome, then to role select', (WidgetTester tester) async {
    await tester.pumpWidget(const RoutinelyApp());
    expect(find.text('Get started'), findsNothing);

    await tester.pumpAndSettle(const Duration(milliseconds: 1500));
    expect(find.text('Get started'), findsOneWidget);

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text("I'm a trainer"), findsOneWidget);
    expect(find.text('I have a trainer'), findsOneWidget);
    expect(find.text('Continue as trainer'), findsOneWidget);
  });

  testWidgets('Selecting client and continuing opens the client phone entry screen', (WidgetTester tester) async {
    await tester.pumpWidget(const RoutinelyApp());
    await tester.pumpAndSettle(const Duration(milliseconds: 1500));
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('I have a trainer'));
    await tester.pumpAndSettle();
    expect(find.text('Continue as client'), findsOneWidget);

    await tester.tap(find.text('Continue as client'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Send OTP'), findsOneWidget);
  });
}

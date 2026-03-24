import 'package:cau1/app/myapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Submit button is disabled by default', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final submitButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Dang Ky'),
    );
    expect(submitButton.onPressed, isNull);
  });

  testWidgets('Submit button enables when form is valid and terms accepted',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Ho va ten'),
      'Nguyen Van A',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'example@domain.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Mat khau'),
      '123456',
    );
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    final submitButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Dang Ky'),
    );
    expect(submitButton.onPressed, isNotNull);
  });

  testWidgets('Submit button stays disabled with invalid email',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Ho va ten'),
      'Nguyen Van A',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'invalid-email',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Mat khau'),
      '123456',
    );
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    final submitButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Dang Ky'),
    );
    expect(submitButton.onPressed, isNull);
  });
}

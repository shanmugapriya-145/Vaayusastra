import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Vaayusastra/login_page.dart';

void main() {
  testWidgets('LoginPage renders correctly', (WidgetTester tester) async {
    // Build the LoginPage widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Verify that the email and password TextFields are present.
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify that the login button is present.
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Username and password text fields input', (WidgetTester tester) async {
    // Build the LoginPage widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Find the email and password TextFields by Key
    final emailField = find.byKey(Key('emailField'));
    final passwordField = find.byKey(Key('passwordField'));

    // Enter text into the email and password TextFields
    await tester.enterText(emailField, 'testuser');
    await tester.enterText(passwordField, 'password');

    // Verify that the text was entered correctly
    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);
  });
}

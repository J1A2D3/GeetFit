import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:integration_test/integration_test.dart';
import 'package:geet_fit/flutter_flow/flutter_flow_icon_button.dart';
import 'package:geet_fit/flutter_flow/flutter_flow_widgets.dart';
import 'package:geet_fit/flutter_flow/flutter_flow_theme.dart';
import 'package:geet_fit/index.dart';
import 'package:geet_fit/main.dart';
import 'package:geet_fit/flutter_flow/flutter_flow_util.dart';

import 'package:provider/provider.dart';
import 'package:geet_fit/backend/firebase/firebase_config.dart';
import 'package:geet_fit/auth/firebase_auth/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initFirebase();
  });

  setUp(() async {
    await authManager.signOut();
    FFAppState.reset();
    final appState = FFAppState();
    await appState.initializePersistedState();
  });

  testWidgets('Login Test', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: const MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const ValueKey('Login-Email_ma33')), '6testing7@gmail.com');
    await tester.enterText(
        find.byKey(const ValueKey('Login-Password_oz8o')), 'idcab!4');
    await tester.tap(find.byKey(const ValueKey('Login_Button_e45o')));
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
    expect(find.text('Meal Plan'), findsWidgets);
  });

  testWidgets('Incorrect Password Attempt', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: const MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    await tester.enterText(
        find.byKey(const ValueKey('Login-Email_ma33')), 'test10@gmail.com');
    await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    await tester.enterText(
        find.byKey(const ValueKey('Login-Password_oz8o')), 'test');
    await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    await tester.tap(find.byKey(const ValueKey('Login_Button_e45o')));
    expect(find.text('Login'), findsWidgets);
  });

  testWidgets('signup user ', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: MyApp(
        entryPage: SignupPageWidget(),
      ),
    ));
    await GoogleFonts.pendingFonts();

    await tester.enterText(
        find.byKey(const ValueKey('Signup-Email_mq81')), 'abcd@azzz.com');
    await tester.enterText(
        find.byKey(const ValueKey('Signup-Password_dqmu')), 'abcdefgHIjkl');
    await tester.enterText(
        find.byKey(const ValueKey('Signup-Confirm-Password_vmbj')),
        'abcdefgHIjkl');
    await tester.tap(find.byKey(const ValueKey('Register_Button_15aj')));
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
    expect(find.text('Full Name'), findsWidgets);
  });

  testWidgets('Meal  Tracking Test', (WidgetTester tester) async {
    _overrideOnError();

    await tester.pumpWidget(ChangeNotifierProvider(
      create: (context) => FFAppState(),
      child: const MyApp(),
    ));
    await GoogleFonts.pendingFonts();

    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const ValueKey('Login-Email_ma33')), '6testing7@gmail.com');
    await tester.enterText(
        find.byKey(const ValueKey('Login-Password_oz8o')), 'idcab!4');
    await tester.tap(find.byKey(const ValueKey('Login_Button_e45o')));
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
    await tester.tap(find.byKey(const ValueKey('Go_To_MealPlan_kpxv')));
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
    await tester.tap(find.byKey(const ValueKey('meal1_button_8eny')));
    await tester.tap(find.byKey(const ValueKey('Set_Meal_1_pxn6')));
    await tester.enterText(
        find.byKey(const ValueKey('Set_Meal_1_pxn6')), 'rice');
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
    expect(find.byKey(const ValueKey('Set_Meal_1_pxn6')), findsWidgets);
  });
}

// There are certain types of errors that can happen during tests but
// should not break the test.
void _overrideOnError() {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (errorDetails) {
    if (_shouldIgnoreError(errorDetails.toString())) {
      return;
    }
    originalOnError(errorDetails);
  };
}

bool _shouldIgnoreError(String error) {
  // It can fail to decode some SVGs - this should not break the test.
  if (error.contains('ImageCodecException')) {
    return true;
  }
  // Overflows happen all over the place,
  // but they should not break tests.
  if (error.contains('overflowed by')) {
    return true;
  }
  // Sometimes some images fail to load, it generally does not break the test.
  if (error.contains('No host specified in URI') ||
      error.contains('EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE')) {
    return true;
  }
  // These errors should be avoided, but they should not break the test.
  if (error.contains('setState() called after dispose()')) {
    return true;
  }

  return false;
}

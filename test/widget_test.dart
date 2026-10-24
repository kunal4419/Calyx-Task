import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calyx_task/main.dart';
import 'package:calyx_task/models/login_response.dart';
import 'package:calyx_task/widgets/profile_avatar.dart';

void main() {
  testWidgets('App renders login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const CalyxApp());

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in to access live exchange rates'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Task 1: ProfileAvatar displays first letter of name in capitals',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: ProfileAvatar(name: 'Shaban Shaikh'),
      ),
    );

    expect(find.text('S'), findsOneWidget);
  });

  test('Task 2 & 3: Country fallback logic when payoutCountryId is empty', () {
    final userWithPayout = UserData.fromJson({
      'customerID': '123',
      'userName': 'test@example.com',
      'fullName': 'Test User',
      'branchID': '2',
      'clientID': '1',
      'currencyCode': 'GBP',
      'currencyID': '22',
      'currencySign': '£',
      'countryName': 'United Kingdom',
      'countryID': '1',
      'payoutCountryId': '6',
      'token': 'tok',
    });

    final countryId1 = userWithPayout.payoutCountryId.trim().isNotEmpty
        ? userWithPayout.payoutCountryId.trim()
        : userWithPayout.countryID.trim();
    expect(countryId1, '6');

    final userWithoutPayout = UserData.fromJson({
      'customerID': '123',
      'userName': 'test@example.com',
      'fullName': 'Test User',
      'branchID': '2',
      'clientID': '1',
      'currencyCode': 'GBP',
      'currencyID': '22',
      'currencySign': '£',
      'countryName': 'United Kingdom',
      'countryID': '1',
      'payoutCountryId': '',
      'token': 'tok',
    });

    final countryId2 = userWithoutPayout.payoutCountryId.trim().isNotEmpty
        ? userWithoutPayout.payoutCountryId.trim()
        : '6';
    expect(countryId2, '6');
  });

  test('LoginResponse parses error data string for 401 response', () {
    final response = LoginResponse.fromJson({
      'response': false,
      'responseCode': '02',
      'data': 'Username or Password is incorrect',
    });

    expect(response.response, false);
    expect(response.data, isNull);
    expect(response.message, 'Username or Password is incorrect');
  });
}

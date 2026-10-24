import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';

class AuthService {
  final http.Client client;

  AuthService({http.Client? client}) : client = client ?? http.Client();

  static const String loginUrl =
      'https://currencyexchangesoftware.eu/pilot/api/userlogin/checklogin';

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse(loginUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userName': username.trim(),
        'password': password,
        'credentialFlag': '',
        'clientID': '1',
        'branchID': '2',
        'otp': '',
        'resendotp': '',
        'captcha': '',
        'latitude': '',
        'longitude': '',
        'deviceId': '',
        'ipAddress': '',
      }),
    );

    try {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } catch (_) {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}

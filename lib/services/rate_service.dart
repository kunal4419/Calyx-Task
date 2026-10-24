import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exchange_rate.dart';

class RateService {
  final http.Client client;

  RateService({http.Client? client}) : client = client ?? http.Client();

  static const String ratesUrl =
      'https://currencyexchangesoftware.eu/pilot/api/rate/dashboardrates';

  Future<List<ExchangeRate>> fetchRates({
    required String token,
    required String customerID,
    required String clientID,
    required String branchID,
    required String countryID,
    required String fromCurrencyCode,
  }) async {
    final response = await client.post(
      Uri.parse(ratesUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'customerID': customerID,
        'clientID': clientID,
        'branchID': branchID,
        'countryID': countryID,
        'fromCurrencyCode': fromCurrencyCode,
        'newAgentBranch': '',
        'newAgentID': '',
        'commentFlag': '',
        'offer_rate_flag': '1',
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (body['data'] is List) {
        final list = body['data'] as List;
        return list.map((item) => ExchangeRate.fromJson(item)).toList();
      }
      return [];
    } else {
      throw Exception('Failed to load rates: ${response.statusCode}');
    }
  }
}

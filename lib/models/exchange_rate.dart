class ExchangeRate {
  final String id;
  final String currencyCode;
  final String currencyName;
  final String rate;
  final String imageName;
  final String countryFlag;
  final String countryID;
  final String currencyID;

  const ExchangeRate({
    required this.id,
    required this.currencyCode,
    required this.currencyName,
    required this.rate,
    required this.imageName,
    required this.countryFlag,
    required this.countryID,
    required this.currencyID,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      id: json['ID']?.toString() ?? '',
      currencyCode: json['currencyCode']?.toString() ?? '',
      currencyName: json['currencyName']?.toString() ?? '',
      rate: json['rate']?.toString() ?? '0.0000',
      imageName: json['imageName']?.toString() ?? '',
      countryFlag: json['countryFlag']?.toString() ?? '',
      countryID: json['countryID']?.toString() ?? '',
      currencyID: json['currencyID']?.toString() ?? '',
    );
  }
}

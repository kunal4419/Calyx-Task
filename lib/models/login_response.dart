class LoginResponse {
  final bool response;
  final String responseCode;
  final UserData? data;
  final String? message;

  const LoginResponse({
    required this.response,
    required this.responseCode,
    this.data,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    String? resolvedMessage;

    if (rawData is String && rawData.trim().isNotEmpty) {
      resolvedMessage = rawData.trim();
    } else if (json['message'] != null &&
        json['message'].toString().trim().isNotEmpty) {
      resolvedMessage = json['message'].toString().trim();
    }

    return LoginResponse(
      response: json['response'] == true,
      responseCode: json['responseCode']?.toString() ?? '',
      data: rawData is Map<String, dynamic>
          ? UserData.fromJson(rawData)
          : null,
      message: resolvedMessage,
    );
  }
}

class UserData {
  final String customerID;
  final String userName;
  final String fullName;
  final String branchID;
  final String clientID;
  final String currencyCode;
  final String currencyID;
  final String currencySign;
  final String countryName;
  final String countryID;
  final String payoutCountryId;
  final String? customerProfileImage;
  final String token;

  const UserData({
    required this.customerID,
    required this.userName,
    required this.fullName,
    required this.branchID,
    required this.clientID,
    required this.currencyCode,
    required this.currencyID,
    required this.currencySign,
    required this.countryName,
    required this.countryID,
    required this.payoutCountryId,
    this.customerProfileImage,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      customerID: json['customerID']?.toString() ?? '',
      userName: json['userName']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      branchID: json['branchID']?.toString() ?? '',
      clientID: json['clientID']?.toString() ?? '',
      currencyCode: json['currencyCode']?.toString() ?? '',
      currencyID: json['currencyID']?.toString() ?? '',
      currencySign: json['currencySign']?.toString() ?? '',
      countryName: json['countryName']?.toString() ?? '',
      countryID: json['countryID']?.toString() ?? '',
      payoutCountryId: json['payoutCountryId']?.toString() ?? '',
      customerProfileImage: json['customer_profileimage'] as String?,
      token: json['token']?.toString() ?? '',
    );
  }
}

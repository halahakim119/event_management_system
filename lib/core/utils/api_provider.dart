import 'dart:convert';

import 'package:http/http.dart' as http;

import '../error/exception.dart';

class ApiProvider {
  static const String baseUrl = 'http://35.180.62.182/api';

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      final errorResponse = jsonDecode(response.body);
      final error = errorResponse['ERROR'];
      if (error == 'INVALID METHOD') {
        throw ApiException('Invalid method');
      } else if (error == 'BAD REQUEST MISSING INFO') {
        throw ApiException('Missing required fields');
      } else if (error.contains('Number')) {
        throw ApiException('Invalid phone number: $error');
      } else if (error.contains('Already Exists')) {
        throw ApiException(
            'User with the same name or phone number already exists');
      } else if (error.contains('PhoneNumber')) {
        throw ApiException('Phone number already exists: $error');
      } else if (error == 'BAD REQUEST') {
        throw ApiException('Invalid verification code');
      } else if (error == 'Wrong Verification Code!') {
        throw ApiException('Wrong verification code');
      } else {
        throw ApiException(error);
      }
    }
  }
}

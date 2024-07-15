library begin_id_sdk_dart;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'const.dart';

/// A BeginId Service
class BeginIdService {
  /// Resolves address with appropriate information by begin-id name
  ///
  /// e.g pass parameter "begin"
  ///
  /// result: Map<String, dynamic> (name, image, addresses, text)
  Future<Map<String, dynamic>> resolveAddress(
      {required name, required chainNumber}) async {
    try {
      final response = await http.post(
        Uri.parse(beginResolveURL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': beginApiKey,
        },
        body: jsonEncode({
          'name': name
              .replaceAll('@', '')
              .replaceAll(RegExp(r'(\.bgin\.id|\.beginid\.io|\.bgn\.is)$'), ''),
          'chain': chainNumber,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'name': data['result']['name'],
          'domain': '${data['result']['name']}$beginDomainUrl',
          'image': data['result']['image'],
          'address': data['result']['addresses'][chainNumber.toString()],
          'text': data['result']['text'],
        };
      } else {
        throw Exception(
            'Failed to resolve address with status code, ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to resolve address. $error');
    }
  }

  /// Reverse resolves profile with appropriate information by <paymentAddress|rewardAddress>
  ///
  /// e.g pass parameter "any payment or reward address"
  ///
  /// result: Map<String, dynamic> (name, image, addresses, text)
  Future<Map<String, dynamic>> resolveAddressReverse(
      {required address, required chainNumber}) async {
    try {
      final response = await http.post(
        Uri.parse(beginResolveReverseURL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': beginApiKey,
        },
        body: jsonEncode({
          'address': address,
          'chain': chainNumber,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'name': data['result']['name'],
          'domain': '${data['result']['name']}$beginDomainUrl',
          'image': data['result']['image'],
          'address': data['result']['addresses'][chainNumber.toString()],
        };
      } else {
        throw Exception(
            'Failed to reverse resolve address with status code, ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to reverse resolve address. $error');
    }
  }
}

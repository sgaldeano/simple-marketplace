import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBrALQdkBX8vmmeNV3eXKRDL1yXmG9eF2U';

  final secureStorage = const FlutterSecureStorage();

  Future<String?> registerUser(String email, String password) async {
    final Uri url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
        'key': _firebaseToken
      }
    );

    final Map<String, dynamic> bodyData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(url, body: json.encode(bodyData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      await secureStorage.write(key: 'token', value: decodedResponse['idToken']);
      return null;
    }

    return decodedResponse['error']['message'];
  }

  Future<String?> loginUser(String email, String password) async {
    final Uri url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
        'key': _firebaseToken
      }
    );

    final Map<String, dynamic> bodyData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final response = await http.post(url, body: json.encode(bodyData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      await secureStorage.write(key: 'token', value: decodedResponse['idToken']);
      return null;
    }

    return decodedResponse['error']['message'];
  }

  Future logout() async {
    await secureStorage.delete(key: 'token');
  }

  Future<String> getAuthToken() async {
    final String authToken = await secureStorage.read(key: 'token') ?? '';
    return authToken;
  }

}
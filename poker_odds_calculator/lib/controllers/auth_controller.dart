import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:poker_odds_calculator/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController {
  final String baseUrl =
      'https://poker-odds-calculator-backend-production.up.railway.app';

  Future<String> login(String username, String password) async {
    final url = (baseUrl + '/login');
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('_id', data['_id']);

        return 'Giriş başarılı';
      } else {
        return 'Username veya Password hatalı';
      }
    } catch (e) {
      print('Error: $e');
      return 'Giriş Başarısız';
    }
  }

  Future<String> signUp(String username, String password, String email) async {
    final url = (baseUrl + '/register');
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('_id', data['_id']);
      print(data['_id']);
      return data['message'];
    } else {
      return 'Üyelik Başarısız';
    }
  }

  Future<bool> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.get('_id'));
    return prefs.containsKey('_id');
  }

  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.pushReplacementNamed(context, '/login');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Successfull logout')),
    );
    await prefs.remove('_id');
  }
}

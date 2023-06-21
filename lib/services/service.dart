import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/currencies.dart';
import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  static String baseUrl = "10.0.2.2:9090";

  UserViewModel();

  /*static Future<User?> login(
    ) async {
    
  }

  static Future<List<Currency>> fetchCurrencies() async {
    
  }

  static Future<bool> buyCurrency(
    
  ) async {
   
  }

  static Future<List<Map<String, dynamic>>> fetchCurrencyList() async {
   
  }*/
}

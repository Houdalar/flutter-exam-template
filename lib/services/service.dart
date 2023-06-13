import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/currencies.dart';
import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  static String baseUrl = "10.0.2.2:9090";

  UserViewModel();

  static Future<User?> login(
      String? email, String? password, BuildContext context) async {
    Map<String, dynamic> userData = {"username": email, "identifier": password};

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    http.Response response = await http.post(
      Uri.http(baseUrl, "/api/users/login/id"),
      body: json.encode(userData),
      headers: headers,
    );

    if (response.statusCode == 200) {
      User user = User.fromJson(json.decode(response.body));
      //store the user in the shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', user.id);

      Navigator.pushNamed(context, '/home', arguments: user);

      return user;
    } else if (response.statusCode == 401) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              "Sign in failed",
              style: TextStyle(color: Colors.red),
            ),
            content: Text("Username or ID are incorrect"),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              "Something went wrong",
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              "Please check your internet connection and try again",
            ),
          );
        },
      );
    }

    return null;
  }

  static Future<List<Currency>> fetchCurrencies() async {
    final url = 'http://$baseUrl/api/currencies';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((currencyJson) => Currency.fromJson(currencyJson))
          .toList();
    } else {
      throw Exception('Failed to fetch currencies');
    }
  }

  static Future<bool> buyCurrency(
    String currencyId,
    double quantity,
    String userId,
  ) async {
    final Map<String, dynamic> requestBody = {
      'currencyId': currencyId,
      'quantity': quantity,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    final url = 'http://$baseUrl/api/currencies/$userId';

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to buy currency');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchCurrencyList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user');
    final url = 'http://$baseUrl/api/currencies/liste/$userId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to fetch currency list');
    }
  }
}

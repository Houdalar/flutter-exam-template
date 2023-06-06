import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/currencies.dart';
import '../models/user.dart';

class CurrencyDetailsScreen extends StatelessWidget {
  final Currency currency;

  CurrencyDetailsScreen({required this.currency});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Details'),
      ),
      body: FutureBuilder<String>(
        future: _getUserFromSharedPreferences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final user = snapshot.data!;

            return Column(
              children: [
                // Display the necessary currency details and user code
                Text('Currency: ${currency.name} (${currency.code})'),
                Text('Unit Price: ${currency.unitPrice}'),
                Text('User Code: ${user}'),
                // Add the remaining UI elements as per your requirements
              ],
            );
          }

          // Handle the case when user data is not available
          return Text('User data not found');
        },
      ),
    );
  }

  Future<String> _getUserFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');

    if (userData != null) {
      return userData;
    }

    throw Exception('User data not found in shared preferences');
  }
}

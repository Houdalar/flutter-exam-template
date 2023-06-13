import 'package:flutter/material.dart';

import '../models/currencies.dart';
import '../services/service.dart';
import 'gridview_item.dart';

class CurrencyListScreen extends StatefulWidget {
  CurrencyListScreen();

  @override
  _CurrencyListScreenState createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  List<Map<String, dynamic>> currencyList = [];

  @override
  void initState() {
    super.initState();
    fetchCurrencyList();
  }

  Future<void> fetchCurrencyList() async {
    try {
      final list = await UserViewModel.fetchCurrencyList();
      setState(() {
        currencyList = list;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Coins'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: currencyList.length,
        itemBuilder: (context, index) {
          final currencyData = currencyList[index];
          final currency = Currency(
            id: currencyData['currency']['_id'],
            image: currencyData['currency']['image'],
            name: currencyData['currency']['name'],
            unitPrice: currencyData['currency']['unitPrice'].toDouble(),
            code: currencyData['currency']['code'],
            description: currencyData['currency']['description'],
          );
          final String quantity = currencyData['quantity'].toString();

          return GridItem(currency: currency, quantity: quantity);
        },
      ),
    );
  }
}

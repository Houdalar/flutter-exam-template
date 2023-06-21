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
  }

  Future<void> fetchCurrencyList() async {}

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
        },
      ),
    );
  }
}

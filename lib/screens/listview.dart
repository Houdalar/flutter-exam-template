import 'package:flutter/material.dart';

import '../models/currencies.dart';
import '../models/user.dart';
import '../services/service.dart';
import 'list_item.dart';

class ListViewScreen extends StatefulWidget {
  final User user;

  ListViewScreen({required this.user});

  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<Currency> items = [];

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    try {
      List<Currency> currencies = await UserViewModel.fetchCurrencies();
      setState(() {
        items = currencies;
      });
    } catch (e) {
      print('Error fetching currencies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'BALANCE\n \$${widget.user.balance.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'popular coins',
          style: TextStyle(fontSize: 15),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListItem(currency: items[index]);
            },
          ),
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'dart:ffi';

import 'package:exam/services/service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/currencies.dart';

class CurrencyDetailsScreen extends StatefulWidget {
  final Currency currency;

  CurrencyDetailsScreen({required this.currency});

  @override
  State<CurrencyDetailsScreen> createState() => _CurrencyDetailsScreenState();
}

class _CurrencyDetailsScreenState extends State<CurrencyDetailsScreen> {
  late TextEditingController _amountController;
  late double _totalAmount;
  String? _userId;
  bool _isBuying = false;
  double quantity = 0;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _totalAmount = 0.0;
    _getUserIdFromSharedPreferences();
  }

  Future<void> _buyCurrency() async {
    if (_userId == null) {
      // Handle the case when user data is not available
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('User data not found'),
            content: const Text('Please login to buy currency.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to login screen or handle the login process
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final String currencyId = widget.currency.id;
    final double quantity = double.tryParse(_amountController.text) ?? 0.0;

    try {
      bool success =
          await UserViewModel.buyCurrency(currencyId, quantity, _userId!);
      if (success) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Congrats'),
              content: Text('you bought $quantity of ${widget.currency.name}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Additional actions if needed
                  },
                  child: const Text('Dismiss'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('warning'),
            content: const Text('no available funds'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currency.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/${widget.currency.image}'),
                radius: 100,
              ),
              const SizedBox(height: 30),
              Text(
                "${widget.currency.name}  [${widget.currency.code}]",
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              Text("\$ ${widget.currency.unitPrice}"),
              const SizedBox(height: 20),
              Text(widget.currency.description),
              const SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: _userId ?? '',
                  border: const OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          quantity = int.parse(value).toDouble();
                          _totalAmount = double.parse(value) *
                              double.parse(
                                  widget.currency.unitPrice.toString());
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 80),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      enabled: false,
                      controller: TextEditingController(
                        text: _totalAmount.toStringAsFixed(2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    await _buyCurrency();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.shopping_basket),
                      SizedBox(width: 8.0),
                      Text('Buy'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');

    if (userData != null) {
      setState(() {
        _userId = userData;
      });
    }
  }
}

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

  Future<void> fetchCurrencies() async {}

  @override
  Widget build(BuildContext context) {}
}

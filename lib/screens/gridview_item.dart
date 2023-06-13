import 'package:flutter/material.dart';

import '../models/currencies.dart';
import 'product_details.dart';

class GridItem extends StatelessWidget {
  final Currency currency;
  final String quantity;

  GridItem({required this.currency, required this.quantity})
      : assert(quantity != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/${currency.image}'),
            radius: 45,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 6),
              Text(
                currency.name,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList(this.userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320, // Fixe hohehe im moment notwendig damit Scroll funktioniert.
      color: Colors.black12,
      child: ListView(
        children: userTransactions.map((tx) {
          return TransactionCard(tx);
        }).toList(),
      ),
    );
  }
}

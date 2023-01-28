import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList(this.userTransactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: userTransactions.map((tx) {
        return TransactionCard(tx);
      }).toList(),
    );
  }
}

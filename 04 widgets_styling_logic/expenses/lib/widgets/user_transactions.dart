import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 25.84,
        date: DateTime.now()),
    Transaction(id: 't3', title: 'New T3', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't4', title: 'New T4', amount: 29.99, date: DateTime.now()),
    Transaction(id: 't5', title: 'New T5', amount: 19.99, date: DateTime.now()),
    Transaction(id: 't6', title: 'New T6', amount: 39.99, date: DateTime.now()),
  ];

  void _addTransactionHandler(String title, double amount) {
    setState(() {
      final transaction = Transaction(
          id: 't' + DateTime.now().toString(),
          title: title,
          amount: amount,
          date: DateTime.now());
      _userTransactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NewTransaction(_addTransactionHandler),
        TransactionList(_userTransactions),
      ],
    );
  }
}

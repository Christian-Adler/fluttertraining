import 'package:expenses/widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
            // onTap: () {}, //nicht mehr notwendig
            // behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addTransactionHandler));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: [
          IconButton(
              onPressed: () {
                _startAddNewTransaction(context);
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                // color: Colors.black12,
                child: Text('chart'),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add_circle_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

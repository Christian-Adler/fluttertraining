import 'package:expenses/transaction_card.dart';
import 'package:flutter/material.dart';

import 'transaction.dart';

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

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 25.84,
        date: DateTime.now()),
  ];

  String titleInput;
  String amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
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
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    onChanged: (val) => titleInput = val,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    onChanged: (val) => titleInput = val,
                  ),
                  TextButton(
                      onPressed: () => print(titleInput),
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(color: Colors.purple),
                      ))
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: transactions.map((tx) {
              return TransactionCard(tx);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

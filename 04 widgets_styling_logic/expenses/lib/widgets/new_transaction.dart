import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function(String title, double amount) addTransaction;

  NewTransaction(this.addTransaction, {Key key}) : super(key: key);

  final titelController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titelController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            TextButton(
                onPressed: () => addTransaction(
                    titelController.text, double.parse(amountController.text)),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.purple),
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function(String title, double amount) addTransaction;

  NewTransaction(this.addTransaction, {Key key}) : super(key: key);

  final titelController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    var enteredTitle = titelController.text;
    var enteredAmount = double.parse(amountController.text);
    print(enteredAmount);
    if (enteredTitle.isEmpty || enteredAmount.isNaN || enteredAmount <= 0)
      return;

    addTransaction(enteredTitle, enteredAmount);
  }

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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) =>
                  submitData(), // _ get an argument but don't use is convention
            ),
            TextButton(
                onPressed: submitData,
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

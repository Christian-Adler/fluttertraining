import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function(String id) deleteTransactionHandler;

  TransactionList(this.userTransactions, this.deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320, // Fixe hohehe im moment notwendig damit Scroll funktioniert.
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: userTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No data',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover)),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionCard(userTransactions[index],
                    () => deleteTransactionHandler(userTransactions[index].id));
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}

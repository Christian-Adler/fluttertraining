import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function(String id) deleteTransactionHandler;

  TransactionList(this.userTransactions, this.deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No data',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset('assets/images/waiting.png',
                            fit: BoxFit.cover)),
                  ],
                );
              })
            : ListView(
                children: userTransactions
                    .map((tx) => TransactionCard(
                          tx,
                          () => deleteTransactionHandler(tx.id),
                          key: ValueKey(tx.id),
                        ))
                    .toList(),
              )

        // ListView.builder hat aktuell Bug mit Key...!?
        // ListView.builder(
        //     itemBuilder: (ctx, index) {
        //       return TransactionCard(
        //         userTransactions[index],
        //         () => deleteTransactionHandler(userTransactions[index].id),
        //         key: ValueKey(userTransactions[index].id),
        //       );
        //     },
        //     itemCount: userTransactions.length,
        //   )
        ;
  }
}

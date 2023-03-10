import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback deleteTransactionHandler;

  const TransactionCard(this.transaction, this.deleteTransactionHandler,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQueryContext = MediaQuery.of(context);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('${transaction.amount} €'),
            ),
          ),
        ),
        title: Text(
          '${transaction.title}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: Container(
          width: mediaQueryContext.size.width > 460 ? 120 : 50,
          // color: Colors.green,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: deleteTransactionHandler,
              ),
              if (mediaQueryContext.size.width > 460)
                TextButton(
                  onPressed: deleteTransactionHandler,
                  child: Text('Delete',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

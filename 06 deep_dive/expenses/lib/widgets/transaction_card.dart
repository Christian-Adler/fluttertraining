import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  final VoidCallback deleteTransactionHandler;

  const TransactionCard(this.transaction, this.deleteTransactionHandler,
      {Key key})
      : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.black,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    // no setState here - build runs anyways after initState

    super.initState();
  }

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
          backgroundColor: _bgColor, // Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('${widget.transaction.amount} €'),
            ),
          ),
        ),
        title: Text(
          '${widget.transaction.title}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: Container(
          width: mediaQueryContext.size.width > 460 ? 120 : 50,
          // color: Colors.green,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: widget.deleteTransactionHandler,
              ),
              if (mediaQueryContext.size.width > 460)
                TextButton(
                  onPressed: widget.deleteTransactionHandler,
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

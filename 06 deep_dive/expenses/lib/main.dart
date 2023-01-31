import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  // Allow only one orientation:
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      // theme: ThemeData(primarySwatch: Colors.purple, accentColor: Colors.amber),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              labelLarge:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .titleLarge,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _showChart = false;
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1',
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 25.84,
        date: DateTime.now()),
    Transaction(
        id: 't3',
        title: 'New T3',
        amount: 69.99,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(id: 't4', title: 'New T4', amount: 29.99, date: DateTime.now()),
    Transaction(id: 't5', title: 'New T5', amount: 19.99, date: DateTime.now()),
    Transaction(id: 't6', title: 'New T6', amount: 39.99, date: DateTime.now()),
  ];

  void _addTransactionHandler(
      String title, double amount, DateTime chosenDate) {
    setState(() {
      final transaction = Transaction(
          id: 't' + DateTime.now().toString(),
          title: title,
          amount: amount,
          date: chosenDate);
      _userTransactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    print('delete: ' + id);
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
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

  List<Transaction> get _recentTransactions {
    var before7Days = DateTime.now().subtract(Duration(days: 7));
    return _userTransactions
        .where((element) => element.date.isAfter(before7Days))
        .toList();
  }

  List<Transaction> get _sortedTransactions {
    _userTransactions.sort((a, b) {
      return a.date.millisecondsSinceEpoch - b.date.millisecondsSinceEpoch;
    });
    return _userTransactions;
  }

  Widget _buildChartContent(double height) {
    return Container(
      height: height,
      width: double.infinity,
      child: Chart(_recentTransactions),
    );
  }

  List<Widget> _buildLandscapeContent(
      double availableBodyHeight, Widget transactionListContainer) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Show Chart"),
          Switch(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              }),
        ],
      ),
      _showChart
          ? _buildChartContent(availableBodyHeight * 0.7)
          : transactionListContainer
    ];
  }

  List<Widget> _buildPortraitContent(
      double availableBodyHeight, Widget transactionListContainer) {
    return [
      _buildChartContent(availableBodyHeight * 0.3),
      transactionListContainer
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(
              Icons.add_circle_outline,
            ))
      ],
    );

    var availableBodyHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

    var transactionListContainer = Container(
        height: availableBodyHeight * 0.7,
        child: TransactionList(_sortedTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isLandscape)
                ..._buildLandscapeContent(
                    availableBodyHeight, transactionListContainer),
              if (!isLandscape)
                ..._buildPortraitContent(
                    availableBodyHeight, transactionListContainer),
            ],
          ),
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

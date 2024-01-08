import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widgets/new_transaction.dart';
import 'package:flutter_complete_guide/Widgets/transaction_list.dart';
import '../models/transaction.dart';
import './Widgets/chart.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
          accentColor: Colors.amber,
          primarySwatch: Colors.purple,
          //fontFamily: 'Quicksand',
          // textTheme: TextTheme(
          //     headline6: TextStyle(
          //         fontFamily: 'OpenSans',
          //         fontWeight: FontWeight.bold,
          //         fontSize: 20)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'New Shoe', amount: 599, date: DateTime.now()),
    Transaction(id: 't2', title: 'Growsery', amount: 499, date: DateTime.now())
  ];
  bool _showChart = false;

  void updateList(String title, double amount, DateTime date) {
    setState(() {
      transactions.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date));
    });
  }

  void deleteTx(Transaction tx) {
    setState(() {
      //transactions.removeWhere((element) => element.id == id);
      transactions.remove(tx);
    });
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(updateList);
        });
  }

  List<Transaction> get resentTransaction {
    return transactions.where((element) {
      return (element.date.isAfter(DateTime.now().subtract(Duration(days: 7))));
    }).toList();
  }

  List<Widget> buildLandscapeMode(
      Widget txWidget, MediaQueryData mediaQuery, AppBar appBar) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch.adaptive(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart == true
          ? Container(
              child: Chart(resentTransaction),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
            )
          : txWidget
    ];
  }

  List<Widget> buildPotrateMode(
      Widget txWidget, MediaQueryData mediaQuery, AppBar appBar) {
    return [
      Container(
        child: Chart(resentTransaction),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
      ),
      txWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    //print('MyHomePageState Build');
    final mediaQuery = MediaQuery.of(context);
    final _landscapeMode = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      // backgroundColor: Colors.purple,
      title: Text('Expense Planner'),
      actions: [
        IconButton(
            onPressed: () {
              startNewTransaction(context);
            },
            icon: Icon(Icons.add))
      ],
    );
    final txWidget = Container(
        child: TransactionList(transactions, deleteTx),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(children: [
          if (_landscapeMode == true)
            ...buildLandscapeMode(txWidget, mediaQuery, appBar),
          if (!_landscapeMode)
            ...buildPotrateMode(txWidget, mediaQuery, appBar),
        ]),
      ),
      floatingActionButton:
          ((_showChart == false || !_landscapeMode) && Platform.isAndroid)
              ? FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    startNewTransaction(context);
                  },
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

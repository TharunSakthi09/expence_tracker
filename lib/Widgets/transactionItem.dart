import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transactions;
  final Function deleteTx;
  Key key;
  TransactionItem(this.transactions, this.deleteTx, this.key) : super(key: key);
  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColor = [
      Colors.pink,
      Colors.purple,
      Colors.amber,
      Colors.blue
    ];

    _bgColor = availableColor[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print('Transaction Item Build');
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor, //Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '₹${widget.transactions.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transactions.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
            fontSize: 17,
          ),
        ),
        subtitle: Text(
          DateFormat('yMMMd').format(widget.transactions.date),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.deleteTx(widget.transactions);
                },
                label: Text('Delete'),
                style:
                    TextButton.styleFrom(primary: Theme.of(context).errorColor),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  widget.deleteTx(widget.transactions);
                },
              ),
      ),
    );
  }
}

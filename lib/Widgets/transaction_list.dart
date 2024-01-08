import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widgets/transactionItem.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    //print('transaction List Build');
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'Opp\'s there is no content!',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  //margin: EdgeInsets.only(top: 10),
                  child: Image.asset('assets/images/waiting.png'),
                  height: constraints.maxHeight * 0.6,
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (conx, index) {
              return TransactionItem(transactions[index], deleteTx,
                  ValueKey(transactions[index].id));
            });
  }
}

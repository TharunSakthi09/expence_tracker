import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widgets/chartBar.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> tranaction;
  const Chart(this.tranaction);

  List<Map<String, Object>> get resentTransaction {
    return List.generate(7, (index) {
      var totalAmount = 0.0;
      final weekday = DateTime.now().subtract(Duration(days: 6 - index));

      for (var tx in tranaction) {
        // if (DateFormat('yMMMd').format(tx.date) ==
        //     DateFormat('yMMMMd').format(weekday)) {
        if (tx.date.day == weekday.day) {
          totalAmount += tx.amount;
        }
      }
      return {
        'day': DateFormat('E').format(weekday).substring(0, 1),
        'amount': totalAmount
      };
    }); //.reversed.toList();
  }

  double get totalAmountOfWeek {
    return resentTransaction.fold(0.0, (previousValue, element) {
      return previousValue = previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('Chart Build');
    // print(resentTransaction);
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: resentTransaction.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                data['day'],
                data['amount'],
                totalAmountOfWeek == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalAmountOfWeek),
          );
        }).toList(),
      ),
    );
  }
}

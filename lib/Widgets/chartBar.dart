import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double amount;
  final double totalAmountOfWeek;

  ChartBar(this.lable, this.amount, this.totalAmountOfWeek);

  @override
  Widget build(BuildContext context) {
    //print('Chart Bar Build');
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          Container(
            height: constraint.maxHeight * 0.15,
            child: FittedBox(
                child: Text(
              '₹${amount.toStringAsFixed(0)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      // color: Color.fromARGB(210, 161, 161, 160),
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                    heightFactor: (1 - totalAmountOfWeek),
                    child: Container(
                      decoration: BoxDecoration(
                          // color: Colors.green,
                          color: Color.fromARGB(210, 161, 161, 160),
                          borderRadius: BorderRadius.circular(10)),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.15,
            child: FittedBox(
              child: Text(lable),
            ),
          )
        ],
      );
    });
  }
}

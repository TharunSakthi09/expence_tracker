import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function updateList;

  const NewTransaction(this.updateList);
  // {
  //   print('Widget Constructor');
  // }

  @override
  State<NewTransaction> createState() {
    print('Create State');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final anmountController = TextEditingController();

  DateTime date;

  _NewTransactionState() {
    print('State Constructor');
  }

  @override
  void initState() {
    // TODO: implement initState
    print('initState()');

    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose');
    super.dispose();
  }

  void submitted() {
    if (titleController.text.isNotEmpty &&
        double.parse(anmountController.text) >= 0 &&
        date != null) {
      widget.updateList(
          titleController.text, double.parse(anmountController.text), date);
      Navigator.of(context).pop();
    }
  }

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        date = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build()');
    //print('New Transaction Build');
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) {
                submitted();
              },
            ),
            TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: anmountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  submitted();
                }),
            Container(
              height: 60,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: date == null
                        ? Text('No Date  Chossen',
                            style: TextStyle(fontWeight: FontWeight.bold))
                        : Text(DateFormat.yMd().format(date)),
                  ),
                  TextButton(
                    onPressed: datePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: submitted,
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                child: Text(
                  'Save Expense',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ]),
        ),
      ),
    );
  }
}

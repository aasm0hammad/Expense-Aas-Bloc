import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AddExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              expense("Enter title "),
              SizedBox(
                height: 11,
              ),
              expense("Enter Desc "),
              SizedBox(
                height: 11,
              ),
              expense("Enter Amount "),
              SizedBox(
                height: 11,
              ),

            ],
          )),
    );
  }

  Widget expense(String hintText) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}

import 'package:expense_manager/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {

  List<ExpenseModel> expenseList;


   ExpenseList({ Key? key, required this.expenseList }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(height: 400, child: ListView.builder(itemBuilder: (context,position){
           return Column(children: [
          Card(
            elevation: 5,
            child: Row(
              children: [
                Container(
                  child: Text(
                    "\$"+expenseList[position].amount.toStringAsFixed(2),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expenseList[position].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat.yMEd().format(expenseList[position].dateTime),
                        style: TextStyle(fontWeight: FontWeight.normal)),
                  ],
                ),
              ],
            ))]);},itemCount: expenseList.length));



      
    
  }
}
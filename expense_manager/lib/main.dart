import 'dart:ui';

import 'package:expense_manager/expense_model.dart';
import 'package:flutter/material.dart';

import 'add_expense.dart';
import 'chart.dart';
import 'expenselist.dart';

void main() => runApp(ExpenseApp());

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainWidgetState();
  }
}

class MainWidgetState extends State<MainWidget> {
  final List<ExpenseModel> expenseList = [
    ExpenseModel(
        id: "1",
        title: "Grocery",
        amount: 100,
        dateTime: DateTime.now().subtract(Duration(days: 3))),
    ExpenseModel(
        id: "2",
        title: "Cloth shopping",
        amount: 99.99,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
  ];

  List<ExpenseModel> get weeklyExpenseList {
    return expenseList.where((element) {
      if (element.dateTime
          .isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Manager"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => startAddingExpense(context),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(weeklyExpenseList),
          ExpenseList(expenseList: expenseList)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => startAddingExpense(context),
      ),
    );
  }

  void addButtonPressed(String titleText, double amountValue,String date) {
    var newExpense = ExpenseModel(
        id: DateTime.now().toString(),
        title: titleText,
        amount: amountValue,
        dateTime: DateTime.parse(date));

    setState(() {
      expenseList.add(newExpense);
    });
  }

  void startAddingExpense(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: AddExpense(addButtonPressed: addButtonPressed),
            onTap: () {},
            behavior: HitTestBehavior.translucent,
          );
        });
  }
}

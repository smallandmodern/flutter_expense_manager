import 'package:expense_manager/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  //var totalSum=0.0;
  final List<ExpenseModel> weeklyExpenseList;

  const Chart(@required this.weeklyExpenseList, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedweeklyExpenseList {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < weeklyExpenseList.length; i++) {
        if (weeklyExpenseList[i].dateTime.day == weekDay.day &&
            weeklyExpenseList[i].dateTime.month == weekDay.month &&
            weeklyExpenseList[i].dateTime.year == weekDay.year) {
          totalSum += weeklyExpenseList[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSum {
    return groupedweeklyExpenseList.fold(0.0, (sum, element) {
      return sum = sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: groupedweeklyExpenseList.map((expenseModel) {
        return Flexible(
            fit: FlexFit.loose,
            child: ChartBar(
                label: expenseModel['day'] as String,
                amount: expenseModel['amount'] as double,
                percentage: (expenseModel['amount'] as double) / totalSum));
      }).toList(),
    );
  }
}

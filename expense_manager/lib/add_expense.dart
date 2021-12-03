import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  final Function addButtonPressed;

  AddExpense({Key? key, required this.addButtonPressed}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  var _selectedDate = null;
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  void submitData() {


    if(amountController.text.isEmpty)
    return;
    String name;
    double amount;

    name = titleController.text;
    amount = double.parse(amountController.text);

    if (name.isEmpty || amount <= 0 || _selectedDate==null) return;

    widget.addButtonPressed(name, amount,_selectedDate);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Card(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: "Title"),
                  onSubmitted: (_) => submitData()),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(hintText: "Amount"),
                onSubmitted: (_) => submitData(),
              ),
              Row(children: [
                _selectedDate == null
                    ? const Text("No date Chosen!")
                    : Text("Picked date : $_selectedDate"),
                TextButton(
                    onPressed: () => _TextButtonPressed(context),
                    child: const Text("Choose date"))
              ]),
              ElevatedButton(
                  onPressed: () => submitData(),
                  child: const Text("Add Transaction")),
            ],
          ),
        ));
  }

  void _TextButtonPressed(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2017, 1, 1),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _selectedDate = DateFormat("yyyy-MM-dd").format(value as DateTime);
        submitData();
      });
    });
  }
}

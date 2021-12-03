import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;

  const ChartBar(
      {required this.label,
      required this.amount,
      required this.percentage,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label),
        Container(width:10, height: 150,child:Stack(
          children: [
            Container(
              decoration:BoxDecoration( border:Border.all(color:Colors.black),
                    color: Colors.grey, shape: BoxShape.rectangle,)),
            FractionallySizedBox(
                heightFactor: percentage,
                child: Container(color: Colors.orange),)
          ],
        )),
        FittedBox(child:Text(amount.toString()))
      ],
    );
  }
}

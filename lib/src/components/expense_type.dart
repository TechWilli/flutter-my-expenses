import 'package:flutter/material.dart';
import 'package:flutter_my_expenses/src/models/transaction_model.dart';
import 'package:flutter_my_expenses/utils/utils.dart' show getExpenseTypeProps;

class ExpenseType extends StatelessWidget {
  final TransactionModel transaction;

  const ExpenseType({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: getExpenseTypeProps(
          transaction.type,
        )['baseColor']
            .withOpacity(.5),
        border: Border.all(
          color: getExpenseTypeProps(
            transaction.type,
          )['accentColor'],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        getExpenseTypeProps(transaction.type)['translation'],
        style: TextStyle(
          fontSize: 10,
          color: getExpenseTypeProps(transaction.type)['accentColor'],
        ),
      ),
    );
  }
}

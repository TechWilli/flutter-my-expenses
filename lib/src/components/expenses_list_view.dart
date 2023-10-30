import 'package:flutter/material.dart';
import 'package:flutter_my_expenses/src/components/expense_type.dart';

import 'package:flutter_my_expenses/utils/utils.dart'
    show formatDate, formatValue;
import 'package:flutter_my_expenses/src/models/transaction_model.dart';

class ExpensesListView extends StatelessWidget {
  final List<TransactionModel> transactions;
  final void Function(int index) onDelete;

  const ExpensesListView({
    required this.transactions,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (_, index) {
              final TransactionModel transaction = transactions[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          // color: Colors.amber,
                          padding: const EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                transaction.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                formatDate(transaction.date),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              ExpenseType(transaction: transaction),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        // color: Colors.black,
                        margin: const EdgeInsets.only(
                          left: 5,
                          right: 8,
                        ),
                        child: FittedBox(
                          alignment: Alignment.centerRight,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            formatValue(transaction.value),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onDelete(index),
                        child: const Icon(
                          Icons.delete,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Você ainda não tem despesas cadastradas :(',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
  }
}

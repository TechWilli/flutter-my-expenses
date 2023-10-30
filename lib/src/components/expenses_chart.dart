import 'package:flutter/material.dart';
import 'package:flutter_my_expenses/src/models/transaction_model.dart';
import 'package:flutter_my_expenses/utils/utils.dart'
    show formatValue, getExpenseTypeProps;

class ExpenseChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const ExpenseChart({this.transactions = const [], super.key});

  List<Widget> renderExpensesAmountByType() {
    // final Iterable<Map<String, Object>> expensesTypeAndValue =
    //     transactions.map((e) => {'type': e.type, 'value': e.value});
    // final amountByExpenseType = {};

    // /* aqui eu armazeno no Map amountByExpenseType o nome do tipo e seu total correspondente
    // o ponto negativo é que ficou tudo dynamic */
    // void calculateAmount(Map<String, Object> element) {
    //   amountByExpenseType[element['type']] =
    //       amountByExpenseType[element['type']] != null
    //           ? amountByExpenseType[element['type']] + element['value']
    //           : element['value'];
    // }

    // expensesTypeAndValue.forEach(calculateAmount);

    /* fold é igual ao reduce do JS, que aceita um valor inicial podendo ser qualquer objeto.
    Diferente do próprio método reduce aqui que só aceita retorno do mesmo tipo do iterável */
    final Map<TransactionType, double> amountByExpenseType =
        transactions.fold({}, (previousValue, element) {
      // poderia ser assim também
      // previousValue[element.type] = previousValue[element.type] != null
      //     ? (previousValue[element.type]! + element.value)
      //     : element.value;
      // return previousValue;

      return {
        ...previousValue,
        element.type: previousValue[element.type] != null
            ? (previousValue[element.type]! + element.value)
            : element.value
      };
    });

    return amountByExpenseType.entries.map((e) {
      return Container(
        width: 120,
        margin: EdgeInsets.only(
            right: amountByExpenseType.entries.toList().last.toString() !=
                    e.toString()
                ? 8
                : 0),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: getExpenseTypeProps(e.key)['baseColor'],
          border: Border.all(
            color: getExpenseTypeProps(e.key)['accentColor'],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getExpenseTypeProps(e.key)['translation'],
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                formatValue(e.value),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: transactions.isNotEmpty
            ? renderExpensesAmountByType()
            : [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Nenhuma categoria no momento',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
      ),
    );
  }
}

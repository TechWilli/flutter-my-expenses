import 'package:flutter/material.dart';

import 'package:flutter_my_expenses/src/components/expenses_chart.dart';
import 'package:flutter_my_expenses/src/components/expenses_list_view.dart';
import 'package:flutter_my_expenses/src/components/new_transaction_form.dart';
import 'package:flutter_my_expenses/src/models/transaction_model.dart';

class MyExpenses extends StatefulWidget {
  const MyExpenses({super.key});

  @override
  State<MyExpenses> createState() => _MyExpensesState();
}

class _MyExpensesState extends State<MyExpenses> {
  late final List<TransactionModel> _transactions;

  late TransactionModel _lastDeletedTransaction;

  String get transactionsAmount => _transactions.isNotEmpty
      ? _transactions
          .map((element) => element.value)
          .reduce((accumulator, currentValue) => accumulator += currentValue)
          .toStringAsFixed(2)
      : '0,00';

  void _onSubmit(TransactionModel transaction) {
    setState(() {
      _transactions.insert(0, transaction);
    });
  }

  // ver de colocar um dálogo para excluir, ou um toast com "Despesa excluída. Desfazer"
  void onDelete(int index) {
    final SnackBar snackBar = SnackBar(
      content: const Text(
        'Despesa deletada com sucesso.',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      elevation: 10,
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            _transactions.insert(index, _lastDeletedTransaction);
          });
        },
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
    );

    setState(() {
      _lastDeletedTransaction = _transactions.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    debugPrint('chamou o initState que o corre antes do build');
    /* momento ideial para chamar algum back-end que retorna informações para serem exibidas em tela,
    neste caso simulando que as transações vem do back */
    _transactions = TransactionModel.mockTransactionList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // strech é uma boa pra evitar colocar container com width double infinity ou o MediaQuery
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Suas despesas na palma da mão',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text(
              'Gerencie suas despesas de forma prática e objetiva.',
              style: TextStyle(fontSize: 13),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Categorias',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ExpenseChart(transactions: _transactions),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Divider(color: Colors.grey, thickness: 0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                            color: Colors.grey,
                            fontFamily:
                                'Nunito' /* tive que setar aqui pois o rich text não pega a fonte padrão */),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Qtde. de despesas\n',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: '${_transactions.length}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                            color: Colors.grey,
                            fontFamily:
                                'Nunito' /* tive que setar aqui pois o rich text não pega a fonte padrão */),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Total de despesas\n',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: 'R\$ $transactionsAmount',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Despesas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          isDismissible: false,
                          // enableDrag: false,
                          // para quando usar o modal inteiro, não passar da statusbar
                          useSafeArea: true,
                          // habilita modal de tela inteira
                          isScrollControlled: true,
                          context: context,
                          builder: (_) {
                            return NewTransactionForm(
                              onSubmit: _onSubmit,
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 14,
                    ),
                    label: const Text(
                      'Adicionar',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.amber.shade300,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ExpensesListView(
                  transactions: _transactions, onDelete: onDelete),
            ),
          ],
        ),
      ),
    );
  }
}

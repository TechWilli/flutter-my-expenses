import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_my_expenses/src/models/transaction_model.dart';
import 'package:flutter_my_expenses/utils/utils.dart'
    show formatDate, getExpenseTypeProps;

class NewTransactionForm extends StatefulWidget {
  final void Function(TransactionModel transaction) onSubmit;

  const NewTransactionForm({required this.onSubmit, super.key});

  @override
  State<NewTransactionForm> createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  final TextEditingController _transactionTitleController =
      TextEditingController();
  final TextEditingController _transactionValueController =
      TextEditingController();
  final TextEditingController _transactionDateController =
      TextEditingController();

  TransactionType _dropdownValue = TransactionType.others;
  DateTime? _transactionDate;
  bool _showRequiredFieldsMessage = false;

  InputDecoration _customInputDecoration({required String label}) =>
      InputDecoration(
        // filled: true,
        fillColor: Colors.amber.shade100,
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 3),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      );

  List<DropdownMenuItem<TransactionType>> dropdownItems() {
    return TransactionType.values
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text('${getExpenseTypeProps(value)['translation']}'),
            ))
        .toList();
  }

  void _clearInputValue() {
    _transactionDateController.text = '';
    _transactionDate = null;
    _transactionTitleController.text = '';
    _transactionValueController.text = '';
    _dropdownValue = TransactionType.others;
  }

  void _handleInsertNewTransaction() {
    final newTransaction = TransactionModel(
      id: Random().nextInt(5000),
      title: _transactionTitleController.text,
      date: _transactionDate ?? DateTime.now(),
      type: _dropdownValue,
      value: double.tryParse(_transactionValueController.text) ?? 0,
    );

    // caso não tenha nome ou valor, nao faz nada;
    if (newTransaction.title.isEmpty || newTransaction.value <= 0) {
      setState(() {
        _showRequiredFieldsMessage = true;
      });
      return;
    }

    widget.onSubmit(newTransaction);
    Navigator.of(context).pop();
    // limpando os inputs depois de setar
    _clearInputValue();

    setState(() {
      _showRequiredFieldsMessage = false;
    });
  }

  void _closeModalForm() {
    Navigator.of(context).pop();
    _clearInputValue();
  }

  void _handleDropdownChange(TransactionType? value) {
    setState(() {
      _dropdownValue = value!;
    });
  }

  Future<void> _showDatePicker() async {
    _transactionDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    _transactionDateController.text =
        formatDate(_transactionDate ?? DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // faz o child ser X fração do espaço válido, neste caso foi útil pois o modal bottom tem tamanho fixo
    return FractionallySizedBox(
      heightFactor: .85,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: 50,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade400,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              'Cadastro de nova despesa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: _transactionTitleController,
                        decoration: _customInputDecoration(label: 'Nome'),
                      ),
                      TextField(
                          // numberWithOptions para funcionar no iphone tbm
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: _transactionValueController,
                          decoration: _customInputDecoration(label: 'Valor')),
                      TextField(
                        readOnly: true,
                        controller: _transactionDateController,
                        onTap: _showDatePicker,
                        decoration: _customInputDecoration(label: 'Data'),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Categoria',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButton(
                        isExpanded: true,
                        elevation: 4,
                        // para estilizar a borda underline, neste caso não quis a borda kkk
                        underline: Container(
                          height: 0,
                          color: Colors.black,
                        ),
                        value: _dropdownValue,
                        onChanged: _handleDropdownChange,
                        items: dropdownItems(),
                      ),
                      Visibility(
                        visible: _showRequiredFieldsMessage,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red.shade50,
                          ),
                          child: const Text(
                            'Nome e Valor são obrigatórios!',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              shape: const StadiumBorder(),
                              foregroundColor: Colors
                                  .black, // para ficar no mesmo estilo do FilledButton
                            ),
                            onPressed: _closeModalForm,
                            child: const Text('Fechar'),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: _handleInsertNewTransaction,
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.amber.shade300,
                              foregroundColor: Colors.black,
                            ),
                            child: const Text('Inserir'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

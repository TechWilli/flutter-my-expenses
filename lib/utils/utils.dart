import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_my_expenses/src/models/transaction_model.dart'
    show TransactionType;

String formatDate(DateTime date) =>
    // posso colocar horas tbm HH:mm
    DateFormat('d MMM, y').format(date);

String formatValue(double value) =>
    'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';

Map<String, dynamic> getExpenseTypeProps(TransactionType type) {
  switch (type) {
    case TransactionType.food:
      return {
        'translation': 'Alimentação',
        'baseColor': Colors.green.shade100,
        'accentColor': Colors.green
      };
    case TransactionType.leisure:
      return {
        'translation': 'Lazer',
        'baseColor': Colors.cyan.shade100,
        'accentColor': Colors.cyan
      };
    case TransactionType.study:
      return {
        'translation': 'Estudos',
        'baseColor': Colors.purple.shade100,
        'accentColor': Colors.purple
      };
    case TransactionType.wellness:
      return {
        'translation': 'Bem-estar',
        'baseColor': Colors.orange.shade100,
        'accentColor': Colors.orange
      };
    case TransactionType.others:
      return {
        'translation': 'Outros',
        'baseColor': Colors.brown.shade100,
        'accentColor': Colors.brown
      };
  }
}

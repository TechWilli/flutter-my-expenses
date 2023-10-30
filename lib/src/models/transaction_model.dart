enum TransactionType { food, wellness, study, leisure, others }

class TransactionModel {
  final int id;
  final String title;
  final TransactionType type;
  final double value;
  final DateTime date;

  static List<TransactionModel> mockTransactionList = [
    TransactionModel(
      id: 1,
      title: 'Curso Flutter',
      type: TransactionType.study,
      value: 39.90,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 2,
      title: '2 Halteres 10Kg',
      type: TransactionType.wellness,
      value: 310.0,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 3,
      title: 'Amigurumi',
      type: TransactionType.others,
      value: 100.00,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 4,
      title: 'Mangá Junji Ito',
      type: TransactionType.leisure,
      value: 65.90,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 5,
      title: 'Chocolate',
      type: TransactionType.food,
      value: 5.99,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 5,
      title: 'Curso de Dart',
      type: TransactionType.study,
      value: 30.00,
      date: DateTime.now(),
    ),
    TransactionModel(
      id: 5,
      title: 'Tapioca',
      type: TransactionType.food,
      value: 9.98,
      date: DateTime.now(),
    )
  ];

  TransactionModel({
    required this.id,
    required this.title,
    required this.type,
    required this.value,
    required this.date,
  });
}

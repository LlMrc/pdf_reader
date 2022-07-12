import 'package:hive/hive.dart';
import 'package:pdf_reader/model/transaction.dart';

class Boxes {
  static Box<Transaction> getTransaction() =>
      Hive.box<Transaction>('transaction');
}

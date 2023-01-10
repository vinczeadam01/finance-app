import 'package:flutter/material.dart';
import 'package:money_management_app/models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];

  int get length => _transactions.length;

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    //print(transaction.toString());
    notifyListeners();
  }

  double getIncome() {
    double sum = 0;
    _transactions.where((element) => element.type == "Income").forEach((element) { sum += element.amount;});
    return sum;
  }

  double getExpense() {
    double sum = 0;
    _transactions.where((element) => element.type == "Expense").forEach((element) { sum += element.amount;});
    return sum;
  }

  double getFullBalance() {
    return getIncome() - getExpense();
  }
}
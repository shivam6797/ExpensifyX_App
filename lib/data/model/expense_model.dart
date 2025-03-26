import 'package:ExpensifyX_App/data/local/db_helper.dart';

class ExpenseModel {
  int? id;
  int userId;
  String title;
  String? description;
  double amount;
  int categoryId;
  String date;
  String? time;
  int? week;
  String month;
  String year;
  int type; // 1 for Debit, 2 for Credit
  double balance;
  String? createdAt;

  ExpenseModel({
    this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.time,
    this.week,
    required this.month,
    required this.year,
    required this.type,
    required this.balance,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      DbHelper.EXPENSE_COLUMN_ID: id,
      DbHelper.EXPENSE_COLUMN_USER_ID: userId,
      DbHelper.EXPENSE_COLUMN_TITLE: title,
      DbHelper.EXPENSE_COLUMN_DESC: description,
      DbHelper.EXPENSE_COLUMN_AMOUNT: amount,
      DbHelper.EXPENSE_COLUMN_CATEGORY_ID: categoryId,
      DbHelper.EXPENSE_COLUMN_DATE: date,
      DbHelper.EXPENSE_COLUMN_TIME: time,
      DbHelper.EXPENSE_COLUMN_WEEK: week,
      DbHelper.EXPENSE_COLUMN_MONTH: month,
      DbHelper.EXPENSE_COLUMN_YEAR: year,
      DbHelper.EXPENSE_COLUMN_TYPE: type,
      DbHelper.EXPENSE_COLUMN_BALANCE: balance,
      DbHelper.EXPENSE_COLUMN_CREATED_AT:
          createdAt ?? DateTime.now().toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map[DbHelper.EXPENSE_COLUMN_ID],
      userId: map[DbHelper.EXPENSE_COLUMN_USER_ID],
      title: map[DbHelper.EXPENSE_COLUMN_TITLE],
      description: map[DbHelper.EXPENSE_COLUMN_DESC],
      amount: map[DbHelper.EXPENSE_COLUMN_AMOUNT],
      categoryId: map[DbHelper.EXPENSE_COLUMN_CATEGORY_ID],
      date: map[DbHelper.EXPENSE_COLUMN_DATE],
      time: map[DbHelper.EXPENSE_COLUMN_TIME],
      week: map[DbHelper.EXPENSE_COLUMN_WEEK],
      month: map[DbHelper.EXPENSE_COLUMN_MONTH],
      year: map[DbHelper.EXPENSE_COLUMN_YEAR],
      type: map[DbHelper.EXPENSE_COLUMN_TYPE],
      balance: map[DbHelper.EXPENSE_COLUMN_BALANCE],
      createdAt: map[DbHelper.EXPENSE_COLUMN_CREATED_AT],
    );
  }
}

import 'package:ExpensifyX_App/db/db_helper.dart';

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? birthDate;
  String? phone;
  String? password;
  String? createdAt;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
    required this.phone,
    required this.password,
    this.createdAt,
  });

  /// Convert UserModel object to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      DbHelper.USER_COLUMN_ID: id,
      DbHelper.USER_COLUMN_FIRST_NAME: firstName,
      DbHelper.USER_COLUMN_LAST_NAME: lastName,
      DbHelper.USER_COLUMN_EMAIL: email,
      DbHelper.USER_COLUMN_BIRTH_DATE: birthDate,
      DbHelper.USER_COLUMN_PHONE: phone,
      DbHelper.USER_COLUMN_PASSWORD: password,
      DbHelper.USER_COLUMN_CREATED_AT:
          createdAt ?? DateTime.now().toIso8601String(),
    };
  }

  /// Convert Map to UserModel object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[DbHelper.USER_COLUMN_ID],
      firstName: map[DbHelper.USER_COLUMN_FIRST_NAME],
      lastName: map[DbHelper.USER_COLUMN_LAST_NAME],
      email: map[DbHelper.USER_COLUMN_EMAIL],
      birthDate: map[DbHelper.USER_COLUMN_BIRTH_DATE],
      phone: map[DbHelper.USER_COLUMN_PHONE],
      password: map[DbHelper.USER_COLUMN_PASSWORD],
      createdAt: map[DbHelper.USER_COLUMN_CREATED_AT],
    );
  }
}

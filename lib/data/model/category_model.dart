import 'package:ExpensifyX_App/data/local/db_helper.dart';

class CategoryModel {
  int? id;
  int userId;
  String name;
  String? image;
  int status; // 1 for Active, 0 for Inactive
  String? createdAt;

  CategoryModel({
    this.id,
    required this.userId,
    required this.name,
    this.image,
    this.status = 1, // Default status is Active
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      DbHelper.CATEGORY_COLUMN_ID: id,
      DbHelper.CATEGORY_COLUMN_USER_ID: userId,
      DbHelper.CATEGORY_COLUMN_NAME: name,
      DbHelper.CATEGORY_COLUMN_IMAGE: image,
      DbHelper.CATEGORY_COLUMN_STATUS: status,
      DbHelper.CATEGORY_COLUMN_CREATED_AT:
          createdAt ?? DateTime.now().toIso8601String(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map[DbHelper.CATEGORY_COLUMN_ID],
      userId: map[DbHelper.CATEGORY_COLUMN_USER_ID],
      name: map[DbHelper.CATEGORY_COLUMN_NAME],
      image: map[DbHelper.CATEGORY_COLUMN_IMAGE],
      status: map[DbHelper.CATEGORY_COLUMN_STATUS] ?? 1,
      createdAt: map[DbHelper.CATEGORY_COLUMN_CREATED_AT],
    );
  }
}

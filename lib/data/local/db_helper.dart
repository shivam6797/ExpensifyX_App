import 'dart:io';
import 'package:ExpensifyX_App/data/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper _instance = DbHelper._();
  static DbHelper getInstance() => _instance;

  // user Column & table varibale
  static String TABLE_USERS = "users";
  static String USER_COLUMN_ID = "uId";
  static String USER_COLUMN_FIRST_NAME = "uFirst_Name";
  static String USER_COLUMN_LAST_NAME = "uLast_Name";
  static String USER_COLUMN_EMAIL = "uEmail";
  static String USER_COLUMN_BIRTH_DATE = "uBirth_Date";
  static String USER_COLUMN_PHONE = "uPhone";
  static String USER_COLUMN_PASSWORD = "uPassword";
  static String USER_COLUMN_CREATED_AT = "uCreated_At";

  // expense Column & table varibale
  static String TABLE_EXPNESES = "expenses";
  static String EXPENSE_COLUMN_ID = "eId";
  static String EXPENSE_COLUMN_USER_ID = "uId";
  static String EXPENSE_COLUMN_TITLE = "eTitle";
  static String EXPENSE_COLUMN_DESC = "eDesc";
  static String EXPENSE_COLUMN_AMOUNT = "eAmt";
  static String EXPENSE_COLUMN_CATEGORY_ID = "eCat_Id";
  static String EXPENSE_COLUMN_DATE = "eDate";
  static String EXPENSE_COLUMN_TIME = "eTime";
  static String EXPENSE_COLUMN_WEEK = "eWeek";
  static String EXPENSE_COLUMN_MONTH = "eMonth";
  static String EXPENSE_COLUMN_YEAR = "eYear";
  static String EXPENSE_COLUMN_TYPE = "eType";
  static String EXPENSE_COLUMN_BALANCE = "eBalance";
  static String EXPENSE_COLUMN_CREATED_AT = "eCreated_At";

  // category Column & table varibale
  static String TABLE_CATEGORY = "category";
  static String CATEGORY_COLUMN_ID = "cId";
  static String CATEGORY_COLUMN_USER_ID = "uId";
  static String CATEGORY_COLUMN_NAME = "cName";
  static String CATEGORY_COLUMN_IMAGE = "cImage";
  static String CATEGORY_COLUMN_STATUS = "cStatus";
  static String CATEGORY_COLUMN_CREATED_AT = "cCreated_At";

  Database? _db;
  Future<Database> getDB() async {
    _db ??= await openDB();
    return _db!;
  }

  Future<Database> openDB() async {
    Directory appdocDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(appdocDirectory.path, "expenseDB.db");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE $TABLE_USERS($USER_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, $USER_COLUMN_FIRST_NAME TEXT NOT NULL, $USER_COLUMN_LAST_NAME TEXT NOT NULL, $USER_COLUMN_EMAIL TEXT UNIQUE NOT NULL, $USER_COLUMN_BIRTH_DATE TEXT NOT NULL, $USER_COLUMN_PHONE TEXT UNIQUE NOT NULL, $USER_COLUMN_PASSWORD TEXT NOT NULL, $USER_COLUMN_CREATED_AT TEXT DEFAULT CURRENT_TIMESTAMP)");
        db.execute(
            "CREATE TABLE $TABLE_EXPNESES($EXPENSE_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, $EXPENSE_COLUMN_USER_ID INTEGER NOT NULL, $EXPENSE_COLUMN_TITLE TEXT NOT NULL, $EXPENSE_COLUMN_DESC TEXT, $EXPENSE_COLUMN_AMOUNT REAL NOT NULL, $EXPENSE_COLUMN_CATEGORY_ID INTEGER NOT NULL, $EXPENSE_COLUMN_DATE TEXT NOT NULL, $EXPENSE_COLUMN_TIME TEXT, $EXPENSE_COLUMN_WEEK INTEGER, $EXPENSE_COLUMN_MONTH TEXT NOT NULL, $EXPENSE_COLUMN_YEAR TEXT NOT NULL, $EXPENSE_COLUMN_TYPE INTEGER NOT NULL, $EXPENSE_COLUMN_BALANCE  REAL NOT NULL, $EXPENSE_COLUMN_CREATED_AT TEXT DEFAULT CURRENT_TIMESTAMP)");
        db.execute(
            "CREATE TABLE $TABLE_CATEGORY($CATEGORY_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, $CATEGORY_COLUMN_USER_ID INTEGER NOT NULL, $CATEGORY_COLUMN_NAME TEXT NOT NULL UNIQUE, $CATEGORY_COLUMN_IMAGE TEXT, $CATEGORY_COLUMN_STATUS INTEGER DEFAULT 1, $CATEGORY_COLUMN_CREATED_AT TEXT DEFAULT CURRENT_TIMESTAMP)");
      },
    );
  }

  // Events for Users

  // register USER
  Future<bool> registerUser(UserModel newUser) async {
    var db = await getDB();
    int rowsEffected = await db.insert(TABLE_USERS, newUser.toMap());
    return rowsEffected > 0;
  }

  //  check email before register user
  Future<bool> isEmailAlreadyExist({required String email}) async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db
        .query(TABLE_USERS, where: "$USER_COLUMN_ID = ?", whereArgs: [email]);
    return mData.isNotEmpty;
  }

  // authenticate USER
  Future<UserModel?> authenticateUser(
      {required String input,
      required String password,
      required bool isEmail}) async {
    var db = await getDB();
    print(
        "Authenticating User - Input: $input, Password: $password, isEmail: $isEmail");
    final List<Map<String, dynamic>> usersData = await db.query(TABLE_USERS,
        where:
            "${isEmail ? USER_COLUMN_EMAIL : USER_COLUMN_PHONE} = ? AND $USER_COLUMN_PASSWORD = ?",
        whereArgs: [input, password]);

    if (usersData.isNotEmpty) {
      return UserModel.fromMap(usersData.first);
    }
    print("DB Query Result: $usersData");
    return null;
  }

  // fetch all USERS
  Future<List<UserModel>> getAllUsers() async {
    final db = await getDB();
    List<Map<String, dynamic>> users =
        await db.query(TABLE_USERS); // Table name
    return users.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<void> testQuery() async {
    List<UserModel> users = await getAllUsers();
    for (var user in users) {
      print("User: ${user.toMap()}"); // Agar toMap() hai, to isse print hoga
    }
  }
}

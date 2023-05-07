import 'package:my_diary/Login&Signup/Models/UserModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static Database? _db;

  static const String DB_Name = 'myDiary.db';
  static const String Table_User = 'user';
  static const int dbVersion = 1;
//Columns Names In The Table
  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getTemporaryDirectory();
    print(documentsDirectory);
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: dbVersion, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int Version) async {
    await db.execute("CREATE TABLE $Table_User("
        "$C_UserID TEXT, "
        "$C_UserName TEXT, "
        "$C_Email TEXT, "
        "$C_Password TEXT, "
        " PRIMARY KEY ($C_UserID)"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient!.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel?> getUserLoginDetails(
      String userEmail, String userPassword) async {
    var dbClient = await db;
    // var res = await dbClient!.rawQuery('SELECT * FROM $Table_User WHERE'
    //     '$C_Email=$userEmail AND'
    //     '$C_Password=$userPassword ');
    var res = await dbClient!.rawQuery("SELECT * FROM $Table_User "
        "WHERE "
        "$C_Email = '$userEmail' AND "
        "$C_Password = '$userPassword'");
    if (res.isNotEmpty) {
      return UserModel.fromMap(res.first);
    }
    return null;
  }
}

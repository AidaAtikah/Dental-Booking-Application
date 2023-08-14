import 'package:dental_check/Model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DatabaseUser {
  static Database database_user;

  static const String DB_Name = 'dental';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String userID = 'user_id';
  static const String UserName = 'user_name';
  static const String Email = 'email';
  static const String Password = 'password';

  Future<Database> get db async {
    if (database_user != null) {
      return database_user;
    }
    database_user = await initDb();
    return database_user;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $userID TEXT, "
        " $UserName TEXT, "
        " $Email TEXT,"
        " $Password TEXT, "
        " PRIMARY KEY ($userID)"
        ")");
  }

  Future<int> saveData(User user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }

  Future<User> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$userID = '$userId' AND "
        "$Password = '$password'");

    if (res.length > 0) {
      return User.fromMap(res.first);
    }

    return null;
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$userID = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(Table_User, where: '$userID = ?', whereArgs: [user_id]);
    return res;
  }
}

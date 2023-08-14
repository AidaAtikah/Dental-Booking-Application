import 'package:dental_check/Model/dental_service.dart';
import 'package:dental_check/Model/booking.dart';
import 'package:path/path.dart';
import 'package:dental_check/Screen/service_form_page.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'dental');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 2,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE servicestype(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
    );

    await db.execute(
      'CREATE TABLE appointments(id INTEGER PRIMARY KEY, name TEXT, email TEXT, contactNo TEXT, appdate TEXT, servicetypeId INTEGER, FOREIGN KEY (servicetypeId) REFERENCES servicestype(id) ON DELETE SET NULL)',
    );
  }


  Future<void> insertServiceType(DentalService servicetype) async {
    final db = await _databaseService.database;
    await db.insert(
      'servicestype',
      servicetype.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAppointment(Booking appointment) async {
    final db = await _databaseService.database;
    await db.insert(
      'appointments',
      appointment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DentalService>> servicestype() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('servicestype');
    return List.generate(maps.length, (index) => DentalService.fromMap(maps[index]));
  }

  Future<DentalService> servicetype(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('servicestype', where: 'id = ?', whereArgs: [id]);
    return DentalService.fromMap(maps[0]);
  }

  Future<List<Booking>> appointments() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('appointments');
    return List.generate(maps.length, (index) => Booking.fromMap(maps[index]));
  }
 
  Future<void> updateServiceType(DentalService servicetype) async {
    final db = await _databaseService.database;
    await db.update('servicestype',servicetype.toMap(),where: 'id = ?',whereArgs: [servicetype.id],
    );
  }

  Future<void> updateAppointment(Booking appointment) async {
    final db = await _databaseService.database;
    await db.update('appointments', appointment.toMap(), where: 'id = ?', whereArgs: [appointment.id]);
  }

  Future<void> deleteServiceType(int id) async {
    final db = await _databaseService.database;
    await db.delete('servicestype',where: 'id = ?',whereArgs: [id]);
  }

  Future<void> deleteAppointment(int id) async {
    final db = await _databaseService.database;
    await db.delete('appointments', where: 'id = ?', whereArgs: [id]);
  }
}

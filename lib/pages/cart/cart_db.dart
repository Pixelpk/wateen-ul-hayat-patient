import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:swift_care/model/data_model/service_provider_model.dart';

import '../../export.dart';
import 'cart_data_model.dart';

class DatabaseHelper {
  static final _databaseName = "service.db";
  static final _databaseVersion = 1;
  static final table = 'services_table';

  static final columnId = 'id';
  static final providerId = 'providerId';
  static final columnName = 'name';
  static final columnGender = 'gender';
  static final columnPrice = 'price';

  static final cartTable = 'cart_table';
  static final serviceId = 'service_id';
  static final difference = 'total_days';
  static final price = 'price';
  static final startTime = 'start_time';
  static final endTime = 'end_time';
  static final slotId = 'slotId';

  static final slotStartTime = 'subscribed_start_time';
  static final slotEndTime = 'subscribed_end_time';
  static final slotBookingType = 'booking_type';
  static final unavailableDate = 'unavailable_date';

  static final typeId = 'type_id';
  static final familyId = 'member_id';
  static final familyName = 'family_name';

  static final address = 'address';
  static final latitude = 'latitude';
  static final longitude = 'longitude';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the db_task
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the db_task (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the db_task table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $providerId INTEGER NOT NULL,
            $columnName TEXT NOT NULL,
            $columnGender TEXT NOT NULL,
            $columnPrice INTEGER NOT NULL,
            $serviceId INTEGER NOT NULL,
            $difference INTEGER NULL,
            $startTime TEXT NOT NULL,
            $endTime TEXT NOT NULL,      
            $familyName TEXT NULL,      
            $address TEXT NULL,      
            $familyId INTEGER NULL,
            $slotBookingType INTEGER NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $cartTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $serviceId INTEGER NOT NULL,
            $providerId INTEGER NOT NULL,
            $startTime TEXT NOT NULL,
            $endTime TEXT NOT NULL,
            $typeId INTEGER NOT NULL,
            $familyId INTEGER NULL,
            $difference INTEGER NULL,
            $familyName TEXT NULL,   
            $columnName TEXT NOT NULL,
            $columnGender TEXT NOT NULL,
            $unavailableDate TEXT NOT NULL,
            $address TEXT NULL,      
            $latitude TEXT NULL,      
            $longitude TEXT NULL,      
            $price INTEGER NOT NULL,
            $slotBookingType INTEGER NOT NULL,
            $slotStartTime TEXT NULL,
            $slotEndTime TEXT NULL
          )
          ''');
  }

  Future<int> insert(ServiceDB car) async {
    Database db = await instance.database;
    return await db.insert(table, {
      'providerId': car.providerId,
      'name': car.name,
      'gender': car.gender,
      'price': car.price,
      'total_days': car.difference,
      'service_id': car.serviceId,
      'start_time': car.startTime,
      'end_time': car.endTime,
      'family_name': car.familyName,
      'address': car.address,
      'booking_type': car.slotBookingType,
    });
  }

  Future<int> insertSlot(ServiceDB car) async {
    Database db = await instance.database;
    var res = await db
        .insert(cartTable, car.toSlotMap())
        .onError((error, stackTrace) {
      debugPrint(error.toString());
      return 0;
    });
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllSlots() async {
    Database db = await instance.database;
    return await db.query(cartTable);
  }

  Future<List<Map<String, dynamic>>> queryRows(price) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnName LIKE '%$price%'");
  }

  Future queryProvider(id) async {
    Database db = await instance.database;
    // var res = await db.query(table,
    //     columns: ['providerId'], where: 'providerId = ?', whereArgs: [id]);
    return await db.query(table);
    /* if (res.isNotEmpty) {
      return res ;
    }*/
  }

  Future calculateTotal() async {
    Database db = await instance.database;
    var result = await db.rawQuery("SELECT SUM(price) as Total FROM $table");
    return (result[0])['Total'];
  }

  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    var count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));

    return count;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteSlot(int id) async {
    Database db = await instance.database;
    return await db.delete(cartTable, where: '$id = ?', whereArgs: [id]);
  }

  Future deleteAll() async {
    Database db = await instance.database;
    return await db.delete(table);
  }

  Future deleteAllSlots() async {
    Database db = await instance.database;
    return await db.delete(cartTable);
  }
}

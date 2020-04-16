import 'dart:io';

import 'package:path/path.dart';
import 'package:qr_reader/src/models/scan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsdirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsdirectory.path, 'ScanDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' type text,'
          ' value text'
          ')');
    });
  }

  // INSERTS
  Future<int> addScanRaw(ScanModel scan) async {
    final db = await database;
    final res = await db.rawInsert(
        "INSERT INTO Scans (id, type, value) VALUES (${scan.id},'${scan.type}','${scan.value}')");
    return res;
  }

  Future<int> addScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert('Scans', scan.toJson());
    return res;
  }

  // GETTERS
  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final scan = await db.query('Scans', where: 'id == ?', whereArgs: [id]);
    return scan.isNotEmpty ? ScanModel.fromJson(scan.first) : null;
  }

  Future<List<ScanModel>> getAll() async {
    final db = await database;
    final scans = await db.query('Scans');
    List<ScanModel> scanList = scans.isNotEmpty
        ? scans.map((x) => ScanModel.fromJson(x)).toList()
        : [];
    return scanList;
  }

  Future<List<ScanModel>> getAllByType(String type) async {
    final db = await database;
    final scans =
        await db.query('Scans', where: 'type == ?', whereArgs: [type]);
    List<ScanModel> scanList = scans.isNotEmpty
        ? scans.map((x) => ScanModel.fromJson(x)).toList()
        : [];
    return scanList;
  }

  // UPDATE
  updateScan(ScanModel scan) async {
    final db = await database;
    final res = await db
        .update('Scans', scan.toJson(), where: 'id == ?', whereArgs: [scan.id]);
    return res;
  }

  // DELETE
  Future<int> deleteScan(int scanId) async {
    final db = await database;
    final res = db.delete('Scans', where: 'id == ?', whereArgs: [scanId]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = db.delete('Scans');
    return res;
  }
}

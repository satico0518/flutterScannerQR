import 'dart:async';

import 'package:qr_reader/src/models/scan.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // get data
    getAll();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();
  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  addScan(ScanModel scan) async {
    await DBProvider.db.addScan(scan);
    getAll();
  }

  getAll() async {
    _scansController.sink.add(await DBProvider.db.getAll());
  }

  deleteScan(int scanId) async {
    await  DBProvider.db.deleteScan(scanId);
    getAll();
  }

  deleteAll() async {
    await  DBProvider.db.deleteAll();
    _scansController.sink.add([]);
  }
}

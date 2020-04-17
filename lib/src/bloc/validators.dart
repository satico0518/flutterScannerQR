import 'dart:async';

import 'package:qr_reader/src/models/scan.dart';

class Validators {
  final geoValidation = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink ) {
      final geoScans = scans.where((s) => s.type == 'geo').toList();
      sink.add(geoScans);
    }
  );
  final httpValidation = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink ) {
      final geoScans = scans.where((s) => s.type == 'http').toList();
      sink.add(geoScans);
    }
  );
}
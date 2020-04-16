import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_reader/src/bloc/scans_bloc.dart';
import 'package:qr_reader/src/models/scan.dart';
import 'package:qr_reader/src/pages/direction.dart';
import 'package:qr_reader/src/pages/maps.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_reader/src/utils/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              onPressed: scansBloc.deleteAll)
        ],
      ),
      body: _getPage(currentIndexPage),
      bottomNavigationBar: _getBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.filter_center_focus),
          onPressed: _scanQr),
    );
  }

  _scanQr() async {
    String futureString = '';
    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }
    scansBloc.addScan(ScanModel(value: futureString));
    // scansBloc.addScan(ScanModel(value: 'geo:3976.1102033887933,-74.03941368570634'));
    Platform.isIOS ?
      Future.delayed(Duration(milliseconds: 750), () => launchURL(futureString)) :  
      launchURL(futureString);
  }

  Widget _getPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return MapsPage();
      case 1:
        return DirectionsPage();
      default:
        return MapsPage();
    }
  }

  Widget _getBottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Maps')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Directions')),
      ],
      currentIndex: currentIndexPage,
      onTap: (index) {
        setState(() {
          currentIndexPage = index;
        });
      },
    );
  }
}

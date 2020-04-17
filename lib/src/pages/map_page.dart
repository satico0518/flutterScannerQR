import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_reader/src/models/scan.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  MapController mapControler = new MapController();
  String mapType = 'satellite';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.my_location), onPressed: () {
            mapControler.move(scan.getLatLng(), 15);
          })
        ],),
        body: _flutterMap(scan),
        floatingActionButton: _createFloatingButton(context),
    );
  }

  Widget _flutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapControler,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        _createMap(),
        _createMarks(scan)
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJjanY2MjF4NGIwMG9nM3lvMnN3ZDM1dWE5In0.0SfmUpbW6UFj7ZnRdRyNAw',
        'id': 'mapbox.$mapType'
      }
    );
  }

  _createMarks(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100,
          height: 100,
          point: scan.getLatLng(),
          builder: (context) => 
            Container(
              child: Icon(Icons.location_on, size: 60, color: Theme.of(context).primaryColor,)))
      ]
    );
  }

  Widget _createFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        setState(() {
          if (mapType == 'streets') {
            mapType = 'dark';
          } else if (mapType == 'dark') {
            mapType = 'light';
          } else if (mapType == 'light') {
            mapType = 'outdoors';
          } else if (mapType == 'outdoors') {
            mapType = 'satellite';
          } else {
            mapType = 'streets';
          }
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:qr_reader/src/models/scan.dart';

// import 'package:flutter_map/flutter_map.dart';
// import 'package:qr_reader/src/models/scan.dart';



class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),
      body: Center(child: Text('coodinates: ${scan.value}'),)
    );
  }

  // Widget _createFlutterMap( ScanModel scan ) {

  //   return FlutterMap(
  //     options: MapOptions(
  //       center: scan.getLatLng(),
  //       zoom: 10
  //     ),
  //     layers: [
  //       _createMap(),
  //     ],
  //   );

  // }

  // _createMap() {

  //   return TileLayerOptions(
  //     urlTemplate: 'https://api.mapbox.com/v4/'
  //     '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
  //     additionalOptions: {
  //       'accessToken': 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJjanY2MjF4NGIwMG9nM3lvMnN3ZDM1dWE5In0.0SfmUpbW6UFj7ZnRdRyNAw',
  //       'id': 'mapbox.streets'
  //     }
  //   );


  // }

}

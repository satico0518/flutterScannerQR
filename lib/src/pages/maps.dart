import 'package:flutter/material.dart';
import 'package:qr_reader/src/bloc/scans_bloc.dart';
import 'package:qr_reader/src/models/scan.dart';
import 'package:qr_reader/src/utils/utils.dart';

class MapsPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.getAll();
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          final scans = snapshot.data;
          if (scans.length == 0) {
            return Center(child: Text('No data'));
          }

          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int index) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.redAccent),
              onDismissed: (direction) {
                scansBloc.deleteScan(scans[index].id);
              },
              child: ListTile(
                leading: Icon(
                  Icons.map,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[index].value),
                subtitle: Text('Id: ${scans[index].id.toString()}'),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  if (scans[index].type == 'http') {
                    launchURL(scans[index].value);
                  } else {
                    Navigator.pushNamed(context, 'map', arguments: scans[index]);
                  }
                },
              ),
            )
          );
        }
      },
    );
  }
}

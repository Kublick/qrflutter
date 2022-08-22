import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrsqlite/providers/scan_list_provider.dart';
import 'package:qrsqlite/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key, required this.tipo}) : super(key: key);

  final String tipo;
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanlistProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, int i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanlistProvider>(context, listen: false)
              .borrarPorId(scans[i].id!);
        },
        child: ListTile(
            leading: Icon(
                tipo == 'http' ? Icons.home_outlined : Icons.map_outlined,
                color: Theme.of(context).primaryColor),
            title: Text(scans[i].valor),
            subtitle: Text((scans[i].id.toString())),
            trailing:
                const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            onTap: () {
              launchURL(context, scans[i]);
            }),
      ),
    );
  }
}

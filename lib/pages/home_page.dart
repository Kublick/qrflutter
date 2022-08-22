import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrsqlite/pages/direcciones_page.dart';
import 'package:qrsqlite/pages/mapas_pages.dart';
import 'package:qrsqlite/providers/db_provider.dart';
import 'package:qrsqlite/providers/scan_list_provider.dart';
import 'package:qrsqlite/providers/ui_provider.dart';
import 'package:qrsqlite/widgets/custom_navigatorbar.dart';
import 'package:qrsqlite/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanlistProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                scanListProvider.borrarTodos();
              })
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obtener selectedMenuOpt
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    final tempScan = ScanModel(valor: 'http://incrementa.com');
    // final intTemp = DBProvider.db.nuevoScan(tempScan);
    // DBProvider.db.getScanById(1).then((scan) => print(scan));
    DBProvider.db.getAllScan().then(print);

    final scanListProvider =
        Provider.of<ScanlistProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return const MapasPage();

      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const DireccionesPage();

      default:
        return const MapasPage();
    }
  }
}

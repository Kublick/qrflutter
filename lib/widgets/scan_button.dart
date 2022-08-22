import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrsqlite/providers/scan_list_provider.dart';
import 'package:qrsqlite/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);

        if (barcodeScanRes == '-1') return;

        final scanlistProvider =
            Provider.of<ScanlistProvider>(context, listen: false);

        final nuevoScan = await scanlistProvider.nuevoScan(barcodeScanRes);

        launchURL(context, nuevoScan);
      },
    );
  }
}

// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:qrsqlite/providers/db_provider.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final Completer<GoogleMapController> _controller = Completer();

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 15.4746,
    );

// Marcadores

    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
        markerId: const MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordenadas'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(puntoInicial));
              },
              icon: const Icon(Icons.location_disabled))
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (mapType == MapType.normal) {
                mapType = MapType.satellite;
              } else {
                mapType = MapType.normal;
              }
            });
          },
          child: const Icon(Icons.layers)),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final currentPositionProvider =
    StateProvider<LatLng>((ref) => const LatLng(0, 0));

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabiMap'),
      ),
      body: const MapSample(),
    );
  }
}

//riverpod理解できてないけどとりあえずconsumerStatefulwidgetにした
class MapSample extends ConsumerStatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapSampleState();
}

class _MapSampleState extends ConsumerState<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  late LatLng _initialPosition;
  late bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            // markers: _createMarker(),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: false,
            buildingsEnabled: true,
            onTap: (LatLng latLang) {},
          );
  }
}

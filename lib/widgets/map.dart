import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabimap/provider/add_marker_provider.dart';

class Map extends ConsumerStatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapState();
}

class _MapState extends ConsumerState<Map> {
  final Completer<GoogleMapController> _controller = Completer();
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
    ref.watch(userCurrentPositionProvider.state).state =
        LatLng(position.latitude, position.longitude);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(userCurrentPositionProvider.state).state;
    return _loading
        ? const CircularProgressIndicator()
        : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: position,
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            //TODO: マーカー立てる
            // markers: _createMarker(),
            myLocationEnabled: true,
            //TODO: 現在地に戻るボタン作成
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            buildingsEnabled: true,
            onTap: (LatLng latLang) {},
          );
  }
}

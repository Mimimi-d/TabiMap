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

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.3122, 139.4130),
    zoom: 9,
  );

  void _getUserLocation() async {
    // アプリを立ち上げた一回しか現在地を取得できていないっぽい？
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    ref.watch(userCurrentPositionStateProvider.state).state =
        LatLng(position.latitude, position.longitude);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      //TODO: マーカー立てる
      // markers: _createMarker(),
      myLocationEnabled: true,
      //TODO: 現在地に戻るボタン作成
      myLocationButtonEnabled: true,
    );
  }
}

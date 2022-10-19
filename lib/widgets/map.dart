import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabimap/provider/add_marker_provider.dart';

import '../repository/marker_repository.dart';

class Map extends ConsumerStatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapState();
}

class _MapState extends ConsumerState<Map> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markerList = {};

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
    final markerAsyncValue = ref.watch(markerStreamProvider);
    return markerAsyncValue.when(
      data: (markerData) {
        final markerDocs = markerData.docs;
        for (var mapMarker in markerDocs) {
          final geoPoint = mapMarker['position'] as GeoPoint;
          final marker = Marker(
            markerId: MarkerId(mapMarker['reference'].id),
            position: LatLng(geoPoint.latitude, geoPoint.longitude),
          );
          markerList.add(marker);
        }
        // print(markerList);
        return GoogleMap(
          initialCameraPosition: _initialPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          //TODO: マーカー立てる
          markers: markerList,
          myLocationEnabled: true,
          //TODO: 現在地に戻るボタン作成
          myLocationButtonEnabled: true,
          onTap: (LatLng latLang) {},
          padding: const EdgeInsets.only(
            bottom: 80.0,
            right: 8.0,
          ),
        );
      },
      error: ((error, stackTrace) => Text('Error: $error')),
      loading: () => Stack(
        children: const [Center(child: CircularProgressIndicator())],
      ),
    );
  }
}
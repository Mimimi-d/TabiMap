import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabimap/provider/add_marker_provider.dart';

import '../provider/card_provider.dart';
import '../repository/marker_repository.dart';

class Map extends ConsumerStatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapState();
}

class _MapState extends ConsumerState<Map> {
  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> markerList = [];
  late StreamSubscription<Position> positionStream;
  @override
  void initState() {
    super.initState();

    //現在位置を更新し続ける

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      ref.read(userCurrentPositionStateProvider.state).state =
          LatLng(position!.latitude, position.longitude);
      // print(ref.read(userCurrentPositionStateProvider.state).state);
    });
  }

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.3122, 139.4130),
    zoom: 9,
  );

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 100,
  );

  @override
  Widget build(BuildContext context) {
    final markerAsyncValue = ref.watch(markerStreamProvider);
    final pageController = ref.watch(pageControllerProvider.state).state;
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
            ref.watch(mapControllerProvider.state).state = controller;
          },
          //TODO: マーカー立てる
          markers: markerList.map((selectedMarker) {
            return Marker(
              markerId: MarkerId(selectedMarker.markerId.toString()),
              position: LatLng(selectedMarker.position.latitude,
                  selectedMarker.position.longitude),
              onTap: () async {
                ref.watch(indexProvider.state).state =
                    markerList.indexWhere((marker) => marker == selectedMarker);
                pageController.jumpToPage(ref.watch(indexProvider.state).state);
              },
            );
          }).toSet(),
          myLocationEnabled: true,
          //TODO: 現在地に戻るボタン作成
          myLocationButtonEnabled: true,
          onTap: (LatLng latLang) {},
          padding: const EdgeInsets.only(
            bottom: 80,
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

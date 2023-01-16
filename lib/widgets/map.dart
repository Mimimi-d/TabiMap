import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabimap/provider/add_marker_provider.dart';

import '../domain/mapmarker.dart';
import '../provider/card_provider.dart';
import '../repository/marker_repository.dart';

class Map extends ConsumerStatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapState();
}

class _MapState extends ConsumerState<Map> {
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
    final List<Marker> markerList = markerAsyncValue.when(
      data: ((markerData) {
        final mapMarkerList = markerData.docs
            .map((doc) => MapMarker.fromDocumentSnapshot(doc))
            .toList();
        final markerList = mapMarkerList.map((mapMarker) {
          final geoPoint = mapMarker.position as GeoPoint;
          final marker = Marker(
            markerId: MarkerId(mapMarker.reference!.id),
            position: LatLng(geoPoint.latitude, geoPoint.longitude),
          );
          return marker;
        }).toList();

        return markerList;
      }),
      error: ((error, stackTrace) => []),
      loading: (() => []),
    );

    return GoogleMap(
      initialCameraPosition: _initialPosition,
      onMapCreated: (GoogleMapController controller) {
        ref.watch(mapControllerProvider.state).state = controller;
      },
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
      myLocationButtonEnabled: true,
      onTap: (LatLng latLang) {},
      padding: const EdgeInsets.only(
        bottom: 120,
        right: 6.0,
      ),
    );
  }
}

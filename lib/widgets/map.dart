import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/mapmarker.dart';
import '../provider/card_provider.dart';
import '../provider/map_marker_provider.dart';

class Map extends ConsumerStatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapState();
}

class _MapState extends ConsumerState<Map> {
  List<Marker> markerList = [];
  late GoogleMapController mapController;
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
    //現在位置を更新し続ける
  }

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 100,
  );

  Future<void> selected(MapMarker selectedMapMarker) async {
    final zoomLevel = await mapController.getZoomLevel();
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(selectedMapMarker.position!.geopoint!.latitude,
              selectedMapMarker.position!.geopoint!.longitude),
          zoom: zoomLevel,
        ),
      ),
    );
    //pageViewで移動させてる時はなるべくgetさせないための2秒
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        debugPrint('==============================================');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapMarkerList = ref.watch(mapMarkersListProvider);
    final pageController = ref.watch(pageControllerProvider.state).state;

    return GoogleMap(
      onMapCreated: (googleMapController) => ref
          .read(googleMapControllerProvider.notifier)
          .update((state) => googleMapController),
      initialCameraPosition: CameraPosition(
        target: ref.watch(centerLatLngProvider),
        zoom: ref.watch(zoomProvider),
      ),
      markers: mapMarkerList.map((selectedMapMarker) {
        return Marker(
          markerId: MarkerId(selectedMapMarker.reference!.id),
          position: LatLng(selectedMapMarker.position!.geopoint!.latitude,
              selectedMapMarker.position!.geopoint!.longitude),
          onTap: () async {
            selected(selectedMapMarker);
            ref.watch(indexProvider.state).state = mapMarkerList
                .indexWhere((marker) => marker == selectedMapMarker);
            pageController.jumpToPage(ref.watch(indexProvider.state).state);
          },
        );
      }).toSet(),
      // カメラの移動が終了した時に呼び出される
      onCameraIdle: () {
        // マップのドラッグ操作による移動およびズームの変更のときのみ。
        // 検出範囲をリセットする。
        if (ref.read(willResetDetectionRangeProvider)) {
          ref.read(resetDetectionRangeProvider)();
        } else {
          // マーカーのタップによるカメラ移動と
          // PageView のスワイプによるカメラ移動ではここが動作する。
          // 次のマップのドラッグ操作・ズーム変更に備えて true に更新する。
          ref
              .read(willResetDetectionRangeProvider.notifier)
              .update((state) => true);
        }
      },
      // カメラの位置が移動するたびに呼び出される
      onCameraMove: (CameraPosition cameraPosition) {
        ref
            .read(cameraPositionProvider.notifier)
            .update((state) => cameraPosition);
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onTap: (LatLng latLang) {},
      padding: const EdgeInsets.only(
        bottom: 80,
        right: 6.0,
      ),
    );
  }
}

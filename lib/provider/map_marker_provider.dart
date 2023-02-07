import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/mapmarker.dart';

/// Zoom Level (5.0 <= x <= 17.0) から半径 km を取得する
double getRadiusFromZoom(double zoom) {
  if (zoom <= 6) {
    return 0;
  }
  if (zoom <= 7) {
    return 200;
  }
  if (zoom <= 8) {
    return 150;
  }
  if (zoom <= 9) {
    return 80;
  }
  if (zoom <= 10) {
    return 30;
  }
  if (zoom <= 11) {
    return 25;
  }
  if (zoom <= 12) {
    return 25;
  }
  if (zoom <= 13) {
    return 20;
  }
  if (zoom <= 14) {
    return 20;
  }
  if (zoom <= 15) {
    return 20;
  }
  if (zoom <= 16) {
    return 20;
  }
  return 20;
}

// マップのデフォルトの検出半径。
const double _defaultRadius = 30;

/// マップのデフォルトのズームレベル。
const double _defaultZoom = 7;
//マップのデフォルトの中心
const _defaultLatLng = LatLng(35.3122, 139.4130);

/// GoogleMap ウィジェットを作成する際に値を更新して使用する。
final googleMapControllerProvider =
    StateProvider<GoogleMapController?>((_) => null);

/// マップのズームレベルを管理する StateProvider。
final zoomProvider = StateProvider.autoDispose<double>((_) => _defaultZoom);

/// マップのカメラ位置を管理する StateProvider。
final cameraPositionProvider = StateProvider(
  (_) => const CameraPosition(target: _defaultLatLng, zoom: _defaultZoom),
);

// マップの初期中心位置を提供する Provider。
final initialCenterLatLngProvider = Provider<LatLng>((_) => _defaultLatLng);

/// マップの中心位置を管理する StateProvider。
final centerLatLngProvider =
    StateProvider.autoDispose((ref) => ref.watch(initialCenterLatLngProvider));

// GeoFlutterFire のインスタンスを提供する Provider。
final geoProvider = Provider.autoDispose((_) => Geoflutterfire());

// マップの検出半径を管理する StateProvider。
final radiusProvider = StateProvider.autoDispose<double>((_) => _defaultRadius);

/// マップの検出範囲をリセットするかどうかを管理する StateProvider。
final willResetDetectionRangeProvider = StateProvider((_) => false);

// マップの現在の検出範囲内に入っている mapmarker の DocumentSnapshot 一覧を取得する
final mapmarkerStreamProvider = StreamProvider.autoDispose((ref) {
  final geo = ref.watch(geoProvider);
  final center = ref.watch(centerLatLngProvider);
  final radius = ref.watch(radiusProvider);
  final collectionReference = FirebaseFirestore.instance.collection('markers');
  final stream = geo.collection(collectionRef: collectionReference).within(
        center: GeoFirePoint(
          center.latitude,
          center.longitude,
        ),
        radius: radius,
        field: 'position',
        strictMode: true,
      );
  return stream;
});

/// マップ上に検出された mapmarker のリストを提供する Provider。
final mapMarkersListProvider = Provider.autoDispose((ref) {
  final mapmarkerStream = ref.watch(mapmarkerStreamProvider).value;
  if (mapmarkerStream != null) {
    final mapMarkerList = mapmarkerStream
        .map((doc) => MapMarker.fromDocumentSnapshot(doc))
        .toList();
    return mapMarkerList;
  } else {
    return <MapMarker>[];
  }
});

/// マップの検出範囲をリセットするメソッドを提供する Provider。
final resetDetectionRangeProvider = Provider.autoDispose(
  (ref) => () {
    final latLng = ref.watch(cameraPositionProvider).target;
    final zoom = ref.watch(cameraPositionProvider).zoom;
    ref.read(centerLatLngProvider.notifier).update((state) => latLng);
    ref.read(zoomProvider.notifier).update((state) => zoom);
    ref
        .read(radiusProvider.notifier)
        .update((state) => getRadiusFromZoom(zoom));
  },
);

/// 選択されている mapMarker を管理する StateProvider。
final selectedMapMarkerProvider = StateProvider<MapMarker?>((_) => null);

/// PageView ウィジェトの onPageChanged プロパティに指定するメソッドを提供する Provider。
final onPageChangedProvider = Provider.autoDispose<Future<void> Function(int)>(
  (ref) => (index) async {
    ref.read(willResetDetectionRangeProvider.notifier).update((state) => false);
    final mapMarker = ref.read(mapMarkersListProvider).elementAt(index);
    final lat = mapMarker.position!.geopoint!.latitude;
    final log = mapMarker.position!.geopoint!.longitude;
    final googleMapController = ref.watch(googleMapControllerProvider);
    final zoomLevel = await googleMapController!.getZoomLevel();
    ref.watch(zoomProvider.notifier).update((state) => zoomLevel);
    await googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, log),
          zoom: ref.read(zoomProvider),
        ),
      ),
    );
    ref.read(selectedMapMarkerProvider.notifier).update((state) => mapMarker);
  },
);

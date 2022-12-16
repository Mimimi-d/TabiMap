import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/mapmarker.dart';
import '../provider/add_marker_provider.dart';

/// FireStoreインスタンスをプロバイドする Provider
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// deviceIdのプロバイダー
final deviceIdProvider = FutureProvider((ref) async {
  WidgetsFlutterBinding.ensureInitialized();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  late String deviceId;

  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor!;
  } else if (Platform.isAndroid) {
    //TODO:Androidの場合のデバイスID
    deviceId = 'null';
  } else {
    deviceId = 'null';
  }
  return deviceId;
});

/// markersコレクションのSnapShotを提供する StreamProvider
final markerStreamProvider =
    StreamProvider.autoDispose<QuerySnapshot<MapMarker>>((ref) {
  return ref
      .read(firestoreProvider)
      .collection('markers')
      .withConverter<MapMarker>(
          fromFirestore: (ds, _) => MapMarker.fromDocumentSnapshot(ds),
          toFirestore: (marker, _) => marker.toJson())
      .snapshots();
});

/// Marker
class MarkerRepository {
  MarkerRepository(this._read);
  final Reader _read;

  late final firestore = _read(firestoreProvider);

  late final titleController = _read(titleControllerStateProvider);
  late final titleDescriptionController =
      _read(titleDescriptionControllerStateProvider);

  // MapMarkerに関する変数
  late final markersRef = firestore.collection('markers');
  late final markersConverter = markersRef.withConverter<MapMarker>(
      fromFirestore: (ds, _) => MapMarker.fromDocumentSnapshot(ds),
      toFirestore: (marker, _) => marker.toJson());

  // TODO:MapMarker情報を更新する

  // TODO:MapMarker情報を削除する

  // MarkerDataを[marker]コレクションに格納する関数
  Future<void> storeMarkerCorrection() async {
    late String deviceId;
    final title = titleController.text;
    final titleDescription = titleDescriptionController.text;
    final rate = _read(rateStateProvider);
    final position = _read(userCurrentPositionStateProvider);
    final markerCollectionRef = markersConverter;
    final docRef = markerCollectionRef.doc();

    _read(deviceIdProvider).when(
      data: (data) {
        deviceId = data;
      },
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );

    final marker = MapMarker(
      title: title,
      description: titleDescription,
      starRating: rate,
      position: GeoPoint(position.latitude, position.longitude),
      createat: DateTime.now(),
      reference: docRef,
      deviceId: deviceId,
    );

    await docRef.set(marker);
  }

  void initializeController() {
    titleController.clear();
    titleDescriptionController.clear();
  }

  Future<void> deleteMarkerCorrection(MapMarker mapMarker) async {
    await markersConverter.doc(mapMarker.reference!.id).delete();
  }
}

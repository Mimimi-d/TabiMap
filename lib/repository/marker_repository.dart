import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tabimap/domain/mygeo.dart';

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
    StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
  late final String deviceId = ref.watch(deviceIdProvider).when(
        data: (data) {
          return data;
        },
        loading: () => '',
        error: (err, stack) => 'Error: $err',
      );
  return ref
      .read(firestoreProvider)
      .collection('markers')
      .where('deviceId', isEqualTo: deviceId)
      .snapshots();
});
final starListSteamProvider =
    StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
  late final String deviceId = ref.watch(deviceIdProvider).when(
        data: (data) {
          return data;
        },
        loading: () => '',
        error: (err, stack) => 'Error: $err',
      );
  return ref
      .read(firestoreProvider)
      .collection('markers')
      .where('deviceId', isEqualTo: deviceId)
      .orderBy('starRating', descending: true)
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

  late final String deviceId = _read(deviceIdProvider).when(
    data: (data) {
      return data;
    },
    loading: () => '',
    error: (err, stack) => 'Error: $err',
  );

  // TODO:MapMarker情報を更新する

  // MarkerDataを[marker]コレクションに格納する関数
  Future<void> storeMarkerCorrection() async {
    final geo = Geoflutterfire();
    final title = titleController.text;
    final titleDescription = titleDescriptionController.text;
    final rate = _read(rateStateProvider);
    final currentPosition = await Geolocator.getCurrentPosition();
    final markerCollectionRef = markersConverter;
    final docRef = markerCollectionRef.doc();
    final point = geo.point(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude);
    final geopoint = GeoPoint(point.latitude, point.longitude);
    final geohash = point.hash;

    final marker = MapMarker(
      title: title,
      description: titleDescription,
      starRating: rate,
      position: MyGeo(geohash: geohash, geopoint: geopoint),
      createat: DateTime.now(),
      reference: docRef,
      deviceId: deviceId,
    );

    await docRef.set(marker);
    FirebaseCrashlytics.instance.log("storeMarkerCorrection done");
  }

  void initializeController() {
    titleController.clear();
    titleDescriptionController.clear();
    FirebaseCrashlytics.instance.log("initializeController done");
  }

  Future<void> deleteMarkerCorrection(MapMarker mapMarker) async {
    await markersConverter.doc(mapMarker.reference!.id).delete();
    initializeController();
    FirebaseCrashlytics.instance.log("deleteMarkerCorrection");
  }

  Future<void> updateMarkerCorrection(MapMarker mapMarker) async {
    final title = titleController.text;
    final titleDescription = titleDescriptionController.text;
    final rate = _read(rateStateProvider);

    await markersConverter.doc(mapMarker.reference!.id).update({
      "title": title,
      "description": titleDescription,
      "starRating": rate,
      "createat": DateTime.now(),
    });
    initializeController();
    FirebaseCrashlytics.instance.log("updateMarkerCorrection done");
  }
}

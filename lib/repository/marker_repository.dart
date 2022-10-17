import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/mapmarker.dart';
import '../provider/add_marker_provider.dart';

/// FireStoreインスタンスをプロバイドする Provider
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

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
    final title = titleController.text;
    final titleDescription = titleDescriptionController.text;
    final rate = _read(rateStateProvider);
    final position = _read(userCurrentPositionStateProvider);
    final markerCollectionRef = markersConverter;
    final docRef = markerCollectionRef.doc();

    final marker = MapMarker(
      title: title,
      description: titleDescription,
      starRating: rate,
      position: GeoPoint(position.latitude, position.longitude),
      createat: DateTime.now(),
      reference: docRef,
    );
    print(docRef);
    await docRef.set(marker);
    initializeController();
  }

  void initializeController() {
    titleController.clear();
    titleDescriptionController.clear();
  }
}

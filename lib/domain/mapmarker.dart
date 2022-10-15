import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'mapmarker.freezed.dart';
part 'mapmarker.g.dart';

@freezed
class MapMarker with _$MapMarker {
  factory MapMarker({
    String? markerId,
    // LatLng? latLng,
    String? title,
    String? description,
    double? starRating,
    DateTime? createat,
  }) = _MapMarker;

  factory MapMarker.fromJson(Map<String, dynamic> json) =>
      _$MapMarkerFromJson(json);

  factory MapMarker.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = Map<String, dynamic>.from(ds.data()! as Map);
    return MapMarker.fromJson(data);
  }

  factory MapMarker.fromCollectionSnapshot(CollectionReference cr) {
    final data = cr.doc() as Map<String, dynamic>;
    return MapMarker.fromJson(data);
  }
}

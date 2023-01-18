// 参考
// https://github.com/mono0926/flutter_firestore_ref

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:json_annotation/json_annotation.dart';

class GeoPointConverter implements JsonConverter<GeoPoint, GeoPoint> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(GeoPoint geopoint) => geopoint;

  @override
  GeoPoint toJson(GeoPoint geopoint) => geopoint;
}

//FirestoreのTimestamp型をDateTimeに変換する処理
class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? date) =>
      date == null ? null : Timestamp.fromDate(date);
}

class DocumentReferenceConverter
    implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentReferenceConverter();

  @override
  DocumentReference fromJson(DocumentReference reference) => reference;

  @override
  DocumentReference toJson(DocumentReference reference) => reference;
}

class GeoFirePointConverter
    implements JsonConverter<GeoFirePoint, Map<String, Object>> {
  const GeoFirePointConverter();

  @override
  GeoFirePoint fromJson(Map<String, Object> json) {
    final geoPoint = json['geopoint'] as GeoPoint;
    final geoFire = Geoflutterfire();

    final GeoFirePoint geoFirePoint = geoFire.point(
        latitude: geoPoint.latitude, longitude: geoPoint.longitude);
    return geoFirePoint;
  }

  @override
  Map<String, Object> toJson(GeoFirePoint geofirepoint) {
    final geoPoint = geofirepoint.geoPoint;
    return {
      'geohash': geofirepoint.hash,
      'geopoint': geoPoint,
    };
  }
}

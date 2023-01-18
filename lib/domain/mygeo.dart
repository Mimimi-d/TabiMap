import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabimap/json_converter.dart';

part 'mygeo.freezed.dart';
part 'mygeo.g.dart';

@freezed
class MyGeo with _$MyGeo {
  @JsonSerializable(explicitToJson: true)
  factory MyGeo({
    String? geohash,
    @GeoPointConverter() GeoPoint? geopoint,
  }) = _MyGeo;

  factory MyGeo.fromJson(Map<String, dynamic> json) => _$MyGeoFromJson(json);
}

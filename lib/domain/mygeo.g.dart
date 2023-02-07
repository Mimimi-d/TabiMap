// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mygeo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyGeo _$$_MyGeoFromJson(Map<String, dynamic> json) => _$_MyGeo(
      geohash: json['geohash'] as String?,
      geopoint: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['geopoint'], const GeoPointConverter().fromJson),
    );

Map<String, dynamic> _$$_MyGeoToJson(_$_MyGeo instance) => <String, dynamic>{
      'geohash': instance.geohash,
      'geopoint': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.geopoint, const GeoPointConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

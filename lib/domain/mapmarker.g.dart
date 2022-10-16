// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapmarker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MapMarker _$$_MapMarkerFromJson(Map<String, dynamic> json) => _$_MapMarker(
      markerId: json['markerId'] as String?,
      position: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['position'], const GeoPointConverter().fromJson),
      title: json['title'] as String?,
      description: json['description'] as String?,
      starRating: (json['starRating'] as num?)?.toDouble(),
      createat: json['createat'] == null
          ? null
          : DateTime.parse(json['createat'] as String),
    );

Map<String, dynamic> _$$_MapMarkerToJson(_$_MapMarker instance) =>
    <String, dynamic>{
      'markerId': instance.markerId,
      'position': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.position, const GeoPointConverter().toJson),
      'title': instance.title,
      'description': instance.description,
      'starRating': instance.starRating,
      'createat': instance.createat?.toIso8601String(),
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapmarker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MapMarker _$$_MapMarkerFromJson(Map<String, dynamic> json) => _$_MapMarker(
      position: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['position'], const GeoPointConverter().fromJson),
      title: json['title'] as String?,
      description: json['description'] as String?,
      starRating: (json['starRating'] as num?)?.toDouble(),
      deviceId: json['deviceId'] as String?,
      createat:
          const TimestampConverter().fromJson(json['createat'] as Timestamp?),
      reference: _$JsonConverterFromJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          json['reference'], const DocumentReferenceConverter().fromJson),
    );

Map<String, dynamic> _$$_MapMarkerToJson(_$_MapMarker instance) =>
    <String, dynamic>{
      'position': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.position, const GeoPointConverter().toJson),
      'title': instance.title,
      'description': instance.description,
      'starRating': instance.starRating,
      'deviceId': instance.deviceId,
      'createat': const TimestampConverter().toJson(instance.createat),
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceConverter().toJson),
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

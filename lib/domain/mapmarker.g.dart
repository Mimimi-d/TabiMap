// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapmarker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MapMarker _$$_MapMarkerFromJson(Map<String, dynamic> json) => _$_MapMarker(
      markerId: json['markerId'] as String?,
      latLng: json['latLng'],
      title: json['title'] as String?,
      description: json['description'] as String?,
      starRating: json['starRating'] as int?,
      createat: json['createat'] == null
          ? null
          : DateTime.parse(json['createat'] as String),
    );

Map<String, dynamic> _$$_MapMarkerToJson(_$_MapMarker instance) =>
    <String, dynamic>{
      'markerId': instance.markerId,
      'latLng': instance.latLng,
      'title': instance.title,
      'description': instance.description,
      'starRating': instance.starRating,
      'createat': instance.createat?.toIso8601String(),
    };

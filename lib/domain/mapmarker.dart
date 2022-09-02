import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'mapmarker.freezed.dart';
part 'mapmarker.g.dart';

@freezed
class MapMarker with _$MapMarker {
  factory MapMarker({
    String? markerId,
    LatLng? latLng,
    String? title,
    String? description,
    int? starRating,
    DateTime? createat,
  }) = _MapMarker;

  factory MapMarker.fromJson(Map<String, dynamic> json) =>
      _$MapMarkerFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.freezed.dart';

@freezed
class Place with _$Place {
  factory Place(
    String? name,
    String? photoReference,
    String? placeId,
  ) = _Place;
}

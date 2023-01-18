// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mapmarker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MapMarker _$MapMarkerFromJson(Map<String, dynamic> json) {
  return _MapMarker.fromJson(json);
}

/// @nodoc
mixin _$MapMarker {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get starRating => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createat => throw _privateConstructorUsedError;
  MyGeo? get position => throw _privateConstructorUsedError;
  @DocumentReferenceConverter()
  DocumentReference<Object?>? get reference =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapMarkerCopyWith<MapMarker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapMarkerCopyWith<$Res> {
  factory $MapMarkerCopyWith(MapMarker value, $Res Function(MapMarker) then) =
      _$MapMarkerCopyWithImpl<$Res, MapMarker>;
  @useResult
  $Res call(
      {String? title,
      String? description,
      double? starRating,
      String? deviceId,
      @TimestampConverter() DateTime? createat,
      MyGeo? position,
      @DocumentReferenceConverter() DocumentReference<Object?>? reference});

  $MyGeoCopyWith<$Res>? get position;
}

/// @nodoc
class _$MapMarkerCopyWithImpl<$Res, $Val extends MapMarker>
    implements $MapMarkerCopyWith<$Res> {
  _$MapMarkerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? starRating = freezed,
    Object? deviceId = freezed,
    Object? createat = freezed,
    Object? position = freezed,
    Object? reference = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      starRating: freezed == starRating
          ? _value.starRating
          : starRating // ignore: cast_nullable_to_non_nullable
              as double?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      createat: freezed == createat
          ? _value.createat
          : createat // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as MyGeo?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MyGeoCopyWith<$Res>? get position {
    if (_value.position == null) {
      return null;
    }

    return $MyGeoCopyWith<$Res>(_value.position!, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MapMarkerCopyWith<$Res> implements $MapMarkerCopyWith<$Res> {
  factory _$$_MapMarkerCopyWith(
          _$_MapMarker value, $Res Function(_$_MapMarker) then) =
      __$$_MapMarkerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? description,
      double? starRating,
      String? deviceId,
      @TimestampConverter() DateTime? createat,
      MyGeo? position,
      @DocumentReferenceConverter() DocumentReference<Object?>? reference});

  @override
  $MyGeoCopyWith<$Res>? get position;
}

/// @nodoc
class __$$_MapMarkerCopyWithImpl<$Res>
    extends _$MapMarkerCopyWithImpl<$Res, _$_MapMarker>
    implements _$$_MapMarkerCopyWith<$Res> {
  __$$_MapMarkerCopyWithImpl(
      _$_MapMarker _value, $Res Function(_$_MapMarker) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? starRating = freezed,
    Object? deviceId = freezed,
    Object? createat = freezed,
    Object? position = freezed,
    Object? reference = freezed,
  }) {
    return _then(_$_MapMarker(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      starRating: freezed == starRating
          ? _value.starRating
          : starRating // ignore: cast_nullable_to_non_nullable
              as double?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      createat: freezed == createat
          ? _value.createat
          : createat // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as MyGeo?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MapMarker implements _MapMarker {
  _$_MapMarker(
      {this.title,
      this.description,
      this.starRating,
      this.deviceId,
      @TimestampConverter() this.createat,
      this.position,
      @DocumentReferenceConverter() this.reference});

  factory _$_MapMarker.fromJson(Map<String, dynamic> json) =>
      _$$_MapMarkerFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final double? starRating;
  @override
  final String? deviceId;
  @override
  @TimestampConverter()
  final DateTime? createat;
  @override
  final MyGeo? position;
  @override
  @DocumentReferenceConverter()
  final DocumentReference<Object?>? reference;

  @override
  String toString() {
    return 'MapMarker(title: $title, description: $description, starRating: $starRating, deviceId: $deviceId, createat: $createat, position: $position, reference: $reference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MapMarker &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.starRating, starRating) ||
                other.starRating == starRating) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.createat, createat) ||
                other.createat == createat) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, starRating,
      deviceId, createat, position, reference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MapMarkerCopyWith<_$_MapMarker> get copyWith =>
      __$$_MapMarkerCopyWithImpl<_$_MapMarker>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MapMarkerToJson(
      this,
    );
  }
}

abstract class _MapMarker implements MapMarker {
  factory _MapMarker(
      {final String? title,
      final String? description,
      final double? starRating,
      final String? deviceId,
      @TimestampConverter()
          final DateTime? createat,
      final MyGeo? position,
      @DocumentReferenceConverter()
          final DocumentReference<Object?>? reference}) = _$_MapMarker;

  factory _MapMarker.fromJson(Map<String, dynamic> json) =
      _$_MapMarker.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  double? get starRating;
  @override
  String? get deviceId;
  @override
  @TimestampConverter()
  DateTime? get createat;
  @override
  MyGeo? get position;
  @override
  @DocumentReferenceConverter()
  DocumentReference<Object?>? get reference;
  @override
  @JsonKey(ignore: true)
  _$$_MapMarkerCopyWith<_$_MapMarker> get copyWith =>
      throw _privateConstructorUsedError;
}

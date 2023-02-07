// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mygeo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyGeo _$MyGeoFromJson(Map<String, dynamic> json) {
  return _MyGeo.fromJson(json);
}

/// @nodoc
mixin _$MyGeo {
  String? get geohash => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint? get geopoint => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyGeoCopyWith<MyGeo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyGeoCopyWith<$Res> {
  factory $MyGeoCopyWith(MyGeo value, $Res Function(MyGeo) then) =
      _$MyGeoCopyWithImpl<$Res, MyGeo>;
  @useResult
  $Res call({String? geohash, @GeoPointConverter() GeoPoint? geopoint});
}

/// @nodoc
class _$MyGeoCopyWithImpl<$Res, $Val extends MyGeo>
    implements $MyGeoCopyWith<$Res> {
  _$MyGeoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geohash = freezed,
    Object? geopoint = freezed,
  }) {
    return _then(_value.copyWith(
      geohash: freezed == geohash
          ? _value.geohash
          : geohash // ignore: cast_nullable_to_non_nullable
              as String?,
      geopoint: freezed == geopoint
          ? _value.geopoint
          : geopoint // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyGeoCopyWith<$Res> implements $MyGeoCopyWith<$Res> {
  factory _$$_MyGeoCopyWith(_$_MyGeo value, $Res Function(_$_MyGeo) then) =
      __$$_MyGeoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? geohash, @GeoPointConverter() GeoPoint? geopoint});
}

/// @nodoc
class __$$_MyGeoCopyWithImpl<$Res> extends _$MyGeoCopyWithImpl<$Res, _$_MyGeo>
    implements _$$_MyGeoCopyWith<$Res> {
  __$$_MyGeoCopyWithImpl(_$_MyGeo _value, $Res Function(_$_MyGeo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geohash = freezed,
    Object? geopoint = freezed,
  }) {
    return _then(_$_MyGeo(
      geohash: freezed == geohash
          ? _value.geohash
          : geohash // ignore: cast_nullable_to_non_nullable
              as String?,
      geopoint: freezed == geopoint
          ? _value.geopoint
          : geopoint // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MyGeo implements _MyGeo {
  _$_MyGeo({this.geohash, @GeoPointConverter() this.geopoint});

  factory _$_MyGeo.fromJson(Map<String, dynamic> json) =>
      _$$_MyGeoFromJson(json);

  @override
  final String? geohash;
  @override
  @GeoPointConverter()
  final GeoPoint? geopoint;

  @override
  String toString() {
    return 'MyGeo(geohash: $geohash, geopoint: $geopoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyGeo &&
            (identical(other.geohash, geohash) || other.geohash == geohash) &&
            (identical(other.geopoint, geopoint) ||
                other.geopoint == geopoint));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, geohash, geopoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyGeoCopyWith<_$_MyGeo> get copyWith =>
      __$$_MyGeoCopyWithImpl<_$_MyGeo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyGeoToJson(
      this,
    );
  }
}

abstract class _MyGeo implements MyGeo {
  factory _MyGeo(
      {final String? geohash,
      @GeoPointConverter() final GeoPoint? geopoint}) = _$_MyGeo;

  factory _MyGeo.fromJson(Map<String, dynamic> json) = _$_MyGeo.fromJson;

  @override
  String? get geohash;
  @override
  @GeoPointConverter()
  GeoPoint? get geopoint;
  @override
  @JsonKey(ignore: true)
  _$$_MyGeoCopyWith<_$_MyGeo> get copyWith =>
      throw _privateConstructorUsedError;
}

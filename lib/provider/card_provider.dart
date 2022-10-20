//titleのcontrollerをStateProviderで定義する
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final indexProvider = StateProvider<int>((ref) {
  return 0;
});

final mapControllerProvider = StateProvider<GoogleMapController?>((ref) {
  return null;
});

final pageControllerProvider = StateProvider<PageController>((ref) {
  return PageController(
    viewportFraction: 0.85, //0.85くらいで端っこに別のカードが見えてる感じになる
  );
});

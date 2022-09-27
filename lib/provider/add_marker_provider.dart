//titleのcontrollerをStateProviderで定義する
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

final titleControllerStateProvider = StateProvider.autoDispose(
  (ref) {
    return TextEditingController(text: '');
  },
);

//感想のcontrollerをStateProviderで定義する
final titleDescriptionControllerStateProvider = StateProvider.autoDispose(
  (ref) {
    return TextEditingController(text: '');
  },
);

//rateのStateProviderを定義
final rateProvider = StateProvider((ref) => 0.0);

// ignore: prefer_const_constructors
final userCurrentPositionProvider = StateProvider((ref) => LatLng(0, 0));

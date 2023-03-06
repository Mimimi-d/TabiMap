//titleのcontrollerをStateProviderで定義する
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabimap/repository/marker_repository.dart';

final titleControllerStateProvider = StateProvider(
  (ref) {
    return TextEditingController(text: '');
  },
);

//感想のcontrollerをStateProviderで定義する
final titleDescriptionControllerStateProvider = StateProvider(
  (ref) {
    return TextEditingController(text: '');
  },
);

//rateのStateProviderを定義
final rateStateProvider = StateProvider((ref) => 0.0);

final markersRepositoryProvider = Provider((ref) {
  return MarkerRepository(ref.read);
});

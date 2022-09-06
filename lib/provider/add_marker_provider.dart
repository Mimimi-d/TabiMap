//titleのcontrollerをStateProviderで定義する
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router.dart';

final selectedIndex = StateProvider((ref) => 0);
void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //定義したGoRouterを取得
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      title: 'TabiMap',
    );
  }
}

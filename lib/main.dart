import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  //画面の情報を定義する
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'Home', // context.goName('Home');
        path: '/', // context.go('/')で移動
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MyHomePage(),
        ),
      ),
    ],

    //遷移ページがないなどのエラーが発生した時に、このページに行く
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      title: 'TabiMap',
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabiMap'),
      ),
    );
  }
}

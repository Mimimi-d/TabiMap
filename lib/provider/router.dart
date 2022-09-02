// GoRouterクラスはRiverpodで依存注入
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/bottom_nav.dart';
import '../presentation/home_page.dart';
import '../presentation/home_page1.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'Home', // context.goName('Home');
        path: '/', // context.go('/')で移動
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        name: 'Home1', // context.goName('Home');
        path: '/home1', // context.go('/')で移動
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage1(),
        ),
      ),
    ],
    //navigationbar
    navigatorBuilder: (context, state, child) {
      return Navigator(
        onPopPage: ((route, result) => false),
        pages: [
          MaterialPage(
            child: BottomNav(
              child: child,
            ),
          )
        ],
      );
    },

    //遷移ページがないなどのエラーが発生した時に、このページに行く
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  ),
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/bottom_nav_index_provider.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: ref.watch(bottomNavIndexProvider),
        onTap: (i) {
          ref.read(bottomNavIndexProvider.notifier).update((state) => i);

          // indexに応じてGoRouterのページに遷移
          switch (i) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/home1');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: Colors.grey,
              ),
              label: 'Map'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
                color: Colors.grey,
              ),
              label: 'MyPage'),
        ],
      ),
    );
  }
}

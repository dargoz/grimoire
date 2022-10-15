import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/features/wiki/presentation/pages/explorer_page.dart';
import 'package:grimoire/features/wiki/presentation/pages/grimoire_home_page.dart';

final GoRouter appRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return GrimoireHomePage();
      },
      routes: <GoRoute>[
        GoRoute(
          path: 'grimoire/explorer',
          builder: (BuildContext context, GoRouterState state) {
            return const ExplorerPage();
          },
        ),
      ]
    ),
  ],
);

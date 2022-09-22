import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/features/wiki/presentation/pages/grimoire_home_page.dart';

final GoRouter appRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return GrimoireHomePage();
      },

    ),
  ],
);

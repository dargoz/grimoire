import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/features/wiki/presentation/pages/explorer_page.dart';
import 'package:grimoire/features/wiki/presentation/pages/grimoire_home_page.dart';
import 'package:grimoire/routes/app_route_guard.dart';

import '../features/wiki/presentation/pages/document_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: AppRouteGuard().redirect,
    routes: [
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const GrimoireHomePage();
          },
          routes: [
            ShellRoute(
                navigatorKey: _shellNavigatorKey,
                builder: (context, state, child) {
                  print('location');
                  return ExplorerPage(
                    child: child,
                  );
                },
                routes: [
                  GoRoute(
                      parentNavigatorKey: _shellNavigatorKey,
                      path: 'document/:filePath',
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                            child: DocumentPage(
                          filePath: state.pathParameters['filePath']!,
                        ));
                      })
                ])
          ]),
    ]);

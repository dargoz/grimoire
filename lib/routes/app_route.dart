import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/features/wiki/presentation/pages/explorer_page.dart';
import 'package:grimoire/features/wiki/presentation/pages/grimoire_home_page.dart';
import 'package:grimoire/routes/app_route_guard.dart';

import '../features/auth/presentation/pages/login_page.dart';
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
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
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

                  String ref;
                  if (state.pathParameters['ref']?.isNotEmpty ?? false) {
                    ref = state.pathParameters['ref']!;
                  } else if (state.pathParameters['branch']?.isNotEmpty ??
                      false) {
                    ref = state.pathParameters['branch']!;
                  } else {
                    ref = 'main';
                  }
                  
                  return ExplorerPage(
                    child: child,
                    projectId: state.pathParameters['projectId']!,
                    ref: ref,
                  );
                },
                routes: [
                  GoRoute(
                      parentNavigatorKey: _shellNavigatorKey,
                      path: 'document/:projectId/:filePath',
                      pageBuilder: (context, state) {
                        String filePath = state.pathParameters['filePath']!;
                        String fragment = state.uri.fragment;

                        if (filePath.contains('#')) {
                          List<String> splitPath =
                              state.pathParameters['filePath']!.split('#');
                          filePath = splitPath[0];
                          fragment = splitPath[1];
                        }

                        return NoTransitionPage(
                            child: DocumentPage(
                          filePath: filePath,
                          fragment: fragment,
                        ));
                      }),
                  GoRoute(
                      parentNavigatorKey: _shellNavigatorKey,
                      path: 'document/:projectId/:ref/:filePath',
                      pageBuilder: (context, state) {
                        String filePath = state.pathParameters['filePath']!;
                        String fragment = state.uri.fragment;

                        if (filePath.contains('#')) {
                          List<String> splitPath =
                              state.pathParameters['filePath']!.split('#');
                          filePath = splitPath[0];
                          fragment = splitPath[1];
                        }

                        return NoTransitionPage(
                            child: DocumentPage(
                          filePath: filePath,
                          fragment: fragment,
                        ));
                      })
                ])
          ]),
    ]);

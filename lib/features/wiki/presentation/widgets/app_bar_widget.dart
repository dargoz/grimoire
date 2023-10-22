import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/core/usecases/no_params.dart';
import 'package:grimoire/features/auth/domain/usecases/remove_access_token_use_case.dart';
import 'package:grimoire/injection.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({super.key});

  final RemoveAccessTokenUseCase _removeAccessTokenUseCase =
      getIt<RemoveAccessTokenUseCase>();

  @override
  Widget? get leading => Image.asset(
        'assets/icons/grimoire_logo_bw.png',
        package: 'grimoire',
        scale: 15,
      );

  @override
  double? get titleSpacing => 0;

  @override
  Widget? get title => const Text(
        'Grimoire',
        style: TextStyle(color: Color(0xFF1c1e21), fontWeight: FontWeight.bold),
      );

  @override
  double? get toolbarHeight => 48;

  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  double? get elevation => 0;

  @override
  IconThemeData? get iconTheme => const IconThemeData(color: Color(0xFF1c1e21));

  @override
  List<Widget>? get actions => [
        PopupMenuButton(
          iconSize: 60.0,
          padding: EdgeInsets.zero,
          offset: const Offset(0, 48),
          icon: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://secure.gravatar.com/avatar/018afd3eb4d4dcb676df54b56db7c80e?s=64&d=identicon',
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {
                  _removeAccessTokenUseCase.executeUseCase(NoParams());
                  context.go('/login');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Logout'),
                  ],
                ),
              ),
            ];
          },
        )
      ];
}

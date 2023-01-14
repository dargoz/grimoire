import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({super.key});

  @override
  Widget? get title => const Text(
        'Grimoire',
        style: TextStyle(color: Color(0xFF1c1e21)),
      );

  @override
  double? get toolbarHeight => 48;

  @override
  Color? get backgroundColor => const Color(0xFFfafafa);

  @override
  IconThemeData? get iconTheme => const IconThemeData(color: Color(0xFF1c1e21));

  @override
  List<Widget>? get actions => [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://secure.gravatar.com/avatar/018afd3eb4d4dcb676df54b56db7c80e?s=64&d=identicon',
            ),
          ),
        ),
      ];
}

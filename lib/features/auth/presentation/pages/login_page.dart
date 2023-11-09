import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/features/auth/presentation/controllers/login_controller.dart';
import 'package:grimoire/features/wiki/presentation/controllers/service_controller.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/designs/widgets/response_error_widget.dart';
import '../../../../core/models/resource.dart';
import '../../../../translation/app_translation.dart';
import '../../../wiki/presentation/widgets/loading_widget.dart';

import '../widgets/login_form_widget.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  final String title = 'MB Back Office';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Resource<dynamic>>(serviceStateNotifierProvider, (previous, next) {
      if (next.status == Status.completed) {
        context.go('/');
      }
    });
    return Scaffold(
      appBar: null,
      body: Consumer(builder: (context, ref, child) {
        var state = ref.watch(loginStateNotifierProvider);
        switch (state.status) {
          case Status.initial:
            return _initialPage(context, ref, state);
          case Status.loading:
            return const LoadingWidget();
          case Status.error:
            if (state.errorCode != "503" &&
                state.errorCode != "403") {
              return ResponseErrorWidget(
                userAction: _handleUserAction,
                errorCode: state.errorCode,
                errorMessage: state.message,
                buttonLabel: "back",
              );
            } else {
              return _initialPage(context, ref, state);
            }
          case Status.completed:
            return const Center();
        }
      }),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget _initialPage(BuildContext context, WidgetRef ref, Resource<String> state) {
    var loginController = ref.read(loginStateNotifierProvider.notifier);
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          const Spacer(flex: 1),
          LoginForm(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onPasswordChanged: loginController.onPasswordChanged,
            onUserDomainChanged: loginController.onUserDomainChanged,
            onLoginButtonPressed: loginController.loginButtonPressed,
            failedMessage: state.status == Status.error ? state.message : null,
            onEditingComplete: loginController.loginButtonPressed,
          ),
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(AppTranslation.about.tr),
                  onPressed: () {
                    _onAboutButtonPressed(context);
                  },
                ),
                /*TextButton(
                  child: Text(AppTranslation.feedback.tr),
                  onPressed: () {
                    _onFeedbackButtonPressed(context);
                  },
                ),*/
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
            child: Text(
                "copyright 2023 © Personal Banking Solution, All Rights Reserved."),
          ),
        ],
      ),
    );
  }

  void _onAboutButtonPressed(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    showAboutDialog(
        context: context,
        applicationVersion: '${packageInfo.version}+${packageInfo.buildNumber}',
        applicationIcon: const Text(
          '🌃',
          style: TextStyle(fontSize: 34),
        ),
        applicationLegalese: 'Knowledge of Your Everyday Office Work\n'
            'Created with ♥ and ☕ by DRG');
  }

  void _onFeedbackButtonPressed(BuildContext context) {
    context.go('/feedback');
  }

  void _handleUserAction(
      BuildContext context, String? errorCode, String? errorMessage) {
    /*BlocProvider.of<AuthBloc>(context)
        .add(AuthEvent.onFailure(errorCode, errorMessage));*/
  }
}

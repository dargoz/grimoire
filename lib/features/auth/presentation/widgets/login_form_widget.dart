import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grimoire/core/designs/colors/color_schemes.dart';

import '../../../../core/errors/catcher.dart';
import '../../../../translation/app_translation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(
      {Key? key,
      required this.autovalidateMode,
      this.onEditingComplete,
      this.onPasswordChanged,
      this.onUserDomainChanged,
      this.onLoginButtonPressed,
      this.failedMessage})
      : super(key: key);

  final AutovalidateMode? autovalidateMode;
  final void Function()? onEditingComplete;
  final void Function(String)? onPasswordChanged;
  final void Function(String)? onUserDomainChanged;
  final void Function()? onLoginButtonPressed;
  final String? failedMessage;

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool obscureText = true;

  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Catcher.captureMessage("open LoginForm");
    return Container(
      width: 500,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 2)
          ]),
      child: Form(
        key: widget.key,
        autovalidateMode: widget.autovalidateMode,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 18, 32, 0),
              child: Text(AppTranslation.loginFormDescription.tr),
            ),
            if (widget.failedMessage != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 18, 32, 0),
                child: Text(
                  widget.failedMessage!,
                  style: const TextStyle(color: ColorSchemes.dangerBase),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 18, 32, 8),
              child: TextFormField(
                autocorrect: false,
                onEditingComplete: () {
                  passwordFocus.requestFocus();
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppTranslation.userDomain.tr,
                  prefixIcon: const Icon(Icons.account_box),
                ),
                onChanged: widget.onUserDomainChanged,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return AppTranslation.errorEmptyUserDomain.tr;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 18, 32, 8),
              child: TextFormField(
                focusNode: passwordFocus,
                obscureText: obscureText,
                autocorrect: false,
                onEditingComplete: widget.onEditingComplete,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppTranslation.password.tr,
                    prefixIcon: const Icon(Icons.security),
                    suffixIcon: InkWell(
                      onTap: () => setState(() {
                        obscureText = !obscureText;
                      }),
                      child: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        size: 24.0,
                        color: Colors.black,
                      ),
                    )),
                onChanged: widget.onPasswordChanged,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return AppTranslation.errorEmptyPassword.tr;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorSchemes.bluePrimary,
                  minimumSize: const Size(512, 64),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                ),
                onPressed: widget.onLoginButtonPressed,
                child: const Text("LOGIN"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

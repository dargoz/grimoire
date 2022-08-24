import 'package:flutter/material.dart';

class ResourceErrorWidget extends StatelessWidget {
  const ResourceErrorWidget(
      {Key? key,
      this.userAction,
      this.errorCode,
      this.errorMessage,
      this.buttonLabel})
      : super(key: key);

  final dynamic userAction;

  final String? errorCode;
  final String? errorMessage;
  final String? buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage ?? "null"),
          if (buttonLabel != null)
            ElevatedButton(
                onPressed: () {
                  userAction(context, errorCode, errorMessage);
                },
                child: Text(buttonLabel!))
        ],
      ),
    );
  }
}

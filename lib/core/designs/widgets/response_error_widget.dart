import 'package:flutter/material.dart';

class ResponseErrorWidget extends StatelessWidget {
  const ResponseErrorWidget({super.key, this.errorMessage = 'General Error'});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage),
    );
  }
}

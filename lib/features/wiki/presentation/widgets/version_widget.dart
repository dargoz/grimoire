import 'package:flutter/material.dart';
import 'package:grimoire/features/wiki/presentation/utils/date_util.dart';


class VersionWidget extends StatelessWidget {
  const VersionWidget({super.key, required this.author, required this.lastModifiedDate});

  final String author;
  final String lastModifiedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  const TextSpan(text: 'Last updated on ', style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(text: DateUtil.formatDate(lastModifiedDate), style: const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                  const TextSpan(text: ' by ',  style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(text: author, style: const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic))
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}

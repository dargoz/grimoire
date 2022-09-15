import 'package:flutter/material.dart';
import 'package:grimoire/features/wiki/presentation/models/section.dart';
import 'package:grimoire/features/wiki/presentation/widgets/section_item_widget.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key, required this.sections, required this.onTap});

  final List<Section> sections;
  final void Function(String sectionKey) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      padding: const EdgeInsets.fromLTRB(8, 24, 8, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.list,
                color: Colors.grey,
              ),
              Text(
                'Table of Content',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          for (var index = 0; index < sections.length; index++)
            SectionItemWidget(
              section: sections[index],
              onTap: onTap,
            )
        ],
      ),
    );
  }
}

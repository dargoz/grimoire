import 'package:flutter/material.dart';
import 'package:grimoire/features/wiki/presentation/widgets/custom_expansion_tile.dart';
import 'package:grimoire/features/wiki/presentation/widgets/section_item_widget.dart';

import '../models/section.dart';

class SectionWidgetV2 extends StatelessWidget {
  const SectionWidgetV2(
      {super.key, required this.sections, required this.onTap});

  final List<Section> sections;
  final void Function(String sectionKey) onTap;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: CustomExpansionTile(
        title: const Text(
          'Table of Content',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: const Color(0xFFeeeeee),
        children: [
          for (var section in sections)
            SectionItemWidget(
              section: section,
              onTap: onTap,
            )
        ],
      ),
    );
  }
}

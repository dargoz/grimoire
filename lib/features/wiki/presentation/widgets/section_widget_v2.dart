import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/presentation/controllers/section_controller.dart';
import 'package:grimoire/features/wiki/presentation/controllers/sub_document_controller.dart';
import 'package:grimoire/features/wiki/presentation/widgets/custom_expansion_tile.dart';
import 'package:grimoire/features/wiki/presentation/widgets/section_item_widget.dart';

import '../models/section.dart';

class SectionWidgetV2 extends ConsumerWidget {
  const SectionWidgetV2(
      {super.key, required this.sections, required this.onTap});

  final List<Section> sections;
  final void Function(String sectionKey) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var section = ref.watch(subDocumentStateNotifierProvider);
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
          for (var index = 0;
              index < (section?.value?.data?.sections.length ?? 0);
              index++)
            SectionItemWidget(
              section: section!.value!.data!.sections[index],
              onTap: onTap,
              isActive: ref.watch(sectionStateNotifierProvider) == index,
            )
        ],
      ),
    );
  }
}

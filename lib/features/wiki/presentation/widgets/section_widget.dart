import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/presentation/controllers/section_controller.dart';
import 'package:grimoire/features/wiki/presentation/controllers/sub_document_controller.dart';
import 'package:grimoire/features/wiki/presentation/models/section.dart';
import 'package:grimoire/features/wiki/presentation/widgets/section_item_widget.dart';

class SectionWidget extends ConsumerWidget {
  const SectionWidget({super.key, required this.sections, required this.onTap});

  final List<Section> sections;
  final void Function(String sectionKey) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var section = ref.watch(subDocumentStateNotifierProvider);
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.2,
        padding: const EdgeInsets.fromLTRB(8, 24, 8, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
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
      ),
    );
  }
}

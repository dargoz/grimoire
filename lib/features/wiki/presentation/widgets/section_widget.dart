import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grimoire/features/wiki/presentation/models/section.dart';

import '../controllers/document_controller.dart';

class SectionWidget extends StatelessWidget {
  SectionWidget({super.key, required this.sections, required this.onTap});

  final DocumentController _controller = Get.find();

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
            _sectionItem(sections[index], index)
        ],
      ),
    );
  }

  Widget _sectionItem(Section section, int position) {
    double tabSize = int.parse(section.attr) * 8 - 8;
    return GestureDetector(
      onTap: () => onTap(section.id),
      child: MouseRegion(
        onEnter: (pointerEvent) {
          _controller.onSectionItemHover(position, true);
        },
        onExit: (pointerEvent) {
          _controller.onSectionItemHover(position, false);
        },
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
          padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
          decoration: const BoxDecoration(
              border:
                  Border(left: BorderSide(color: Color(0xffd9d9d9), width: 4))),
          child: Padding(
            padding: EdgeInsets.fromLTRB(tabSize, 0, 0, 4),
            child: Obx(
              () => Text(
                section.label,
                style: TextStyle(
                  color: _controller.sectionHovers[position]
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

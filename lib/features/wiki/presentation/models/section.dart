import 'package:flutter/material.dart';

class Section {
  Section({required this.id, required this.label, required this.sectionKey});

  String id;
  String label;
  GlobalKey sectionKey;

  @override
  String toString() {
    return 'Section{id: $id, label: $label, sectionKey: $sectionKey}';
  }
}

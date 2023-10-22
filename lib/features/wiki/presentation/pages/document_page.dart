import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/presentation/models/project_model.dart';
import 'package:grimoire/features/wiki/presentation/widgets/document_widget.dart';

import '../../../../core/models/resource.dart';
import '../controllers/document_controller.dart';
import '../controllers/file_tree_controller.dart';

class DocumentPage extends ConsumerStatefulWidget {
  const DocumentPage({super.key, required this.filePath, this.fragment});

  final String filePath;
  final String? fragment;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DocumentPageState();
}

class DocumentPageState extends ConsumerState<DocumentPage> {
  late final DocumentController documentController;
  String? tab;

  @override
  void initState() {
    super.initState();
    documentController = ref.read(documentStateNotifierProvider.notifier);
  }

  @override
  void didUpdateWidget(covariant DocumentPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    var data = ref.read(documentStateNotifierProvider);
    print(
        '-- update document : ${data.value?.data?.filePath} :: ${widget.filePath}');
    if (data.value?.data?.filePath != widget.filePath) {
      var path = preProcessPath(widget.filePath);
      documentController.getDocumentFromPath(path);
      documentController.section = widget.fragment;
    }
  }

  @override
  Widget build(BuildContext context) {
    var path = preProcessPath(widget.filePath);
    ref.listen<AsyncValue<Resource<ProjectModel>>>(
        fileTreeStateNotifierProvider, (previous, next) {
      if (next.value?.status == Status.completed) {
        log('called with listener file');
        documentController.getDocumentFromPath(path);
        documentController.section = widget.fragment;
      }
    });

    return DocumentWidget(tab: tab);
  }

  String preProcessPath(String filePath) {
    var path = filePath.replaceAll('%2F', '/');
    var splitPath = path.split('.');
    if (splitPath.length > 2) {
      tab = splitPath.removeAt(1);
    } else {
      tab = null;
    }
    return splitPath.join(".");
  }
}

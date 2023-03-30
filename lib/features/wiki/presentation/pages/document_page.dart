import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grimoire/features/wiki/presentation/models/project_model.dart';
import 'package:grimoire/features/wiki/presentation/widgets/document_widget.dart';

import '../../../../core/models/resource.dart';
import '../controllers/document_controller.dart';
import '../controllers/file_tree_controller.dart';


class DocumentPage extends ConsumerStatefulWidget {
  const DocumentPage({super.key, required this.filePath});

  final String filePath;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DocumentPageState();
}

class DocumentPageState extends ConsumerState<DocumentPage> {
  late final DocumentController documentController;

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
      var path = widget.filePath.replaceAll('%2F', '/');
      documentController.getDocumentFromPath(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<Resource<ProjectModel>>>(
        fileTreeStateNotifierProvider, (previous, next) {
      if (next.value?.status == Status.completed) {
        var path = widget.filePath.replaceAll('%2F', '/');
        log('called with listener file');
        documentController.getDocumentFromPath(path);
      }
    });
    return const DocumentWidget();
  }
}

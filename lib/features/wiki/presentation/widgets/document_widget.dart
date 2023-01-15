import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/resource.dart';
import '../controllers/document_controller.dart';
import '../controllers/file_tree_controller.dart';
import '../models/file_tree_model.dart';
import 'loading_widget.dart';

import '../models/section.dart';
import '../widgets/breadcrumb_widget.dart';
import '../widgets/markdown_widget.dart';
import '../widgets/resource_error_widget.dart';
import '../widgets/section_widget.dart';
import '../widgets/section_widget_v2.dart';
import '../widgets/version_widget.dart';

class DocumentWidget extends ConsumerWidget {
  const DocumentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var documentController = ref.read(documentStateNotifierProvider.notifier);
    var fileTreeState = ref.read(fileTreeStateNotifierProvider);
    var fileTreeController = ref.read(fileTreeStateNotifierProvider.notifier);
    return ref.watch(documentStateNotifierProvider).when(
        data: (model) {
          documentController.clear();
          print('called with model ${model.status}');
          switch (model.status) {
            case Status.loading:
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const LoadingWidget(),
              );
            case Status.initial:
            case Status.completed:
              final isPortrait =
                  MediaQuery.of(context).orientation == Orientation.portrait;
              return Row(
                children: [
                  Flexible(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      controller: documentController.scrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                            child: BreadcrumbWidget(
                              path: model.data?.filePath ?? "",
                              onPressed: (String label) {
                                var model = FileTreeModel(
                                    id: '',
                                    name: '',
                                    type: 'tree',
                                    path: label);
                                documentController.getDocument(
                                    fileTreeController.findReference(model) ??
                                        model);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: VersionWidget(
                              author:
                                  model.data?.versionModel?.authorName ?? '',
                              lastModifiedDate:
                                  model.data?.versionModel?.committedDate ?? '',
                            ),
                          ),
                          if (isPortrait)
                            SectionWidgetV2(
                              sections: model.data?.sections ?? [],
                              onTap: documentController.onSectionClick,
                            ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: markdownWidget(
                                context: context,
                                controller: documentController.scrollController,
                                htmlContent: model.data?.content,
                                onSectionRender: (label, key, attr) =>
                                    documentController.documentWidgetSections
                                        .add(Section(
                                            id: '${label.hashCode}',
                                            attr: attr,
                                            label: label,
                                            sectionKey: key)),
                                onReferenceTap: (content) {
                                  documentController.getDocument(
                                      content.id.isEmpty
                                          ? fileTreeController
                                                  .findReference(content) ??
                                              content
                                          : content);
                                },
                                onAnchorTap:
                                    (text, renderContext, map, element) {
                                  print('anchor tap : $text');
                                  documentController.redirect(text ?? '',
                                      map['href'], fileTreeState.value!.data!);
                                },
                                imageProvider: (imageSource) {
                                  print('imageSource : $imageSource');
                                  return documentController.getImage(
                                      model.data?.filePath ?? '',
                                      imageSource ?? '');
                                }),
                          ),
                        ],
                      ),
                    ),
                  )),
                  if (!isPortrait)
                    SectionWidget(
                      onTap: documentController.onSectionClick,
                      sections: model.data?.sections ?? [],
                    )
                ],
              );
            case Status.error:
              print('response : error :');
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ResourceErrorWidget(
                    errorCode: model.errorCode, errorMessage: model.message),
              );
          }
        },
        error: (object, stackTrace) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const ResourceErrorWidget(),
          );
        },
        loading: () => SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const LoadingWidget(),
            ));
  }
}

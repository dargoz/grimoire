import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:grimoire/features/wiki/presentation/controllers/document_controller.dart';
import 'package:grimoire/features/wiki/presentation/controllers/search_controller.dart';
import 'package:grimoire/features/wiki/presentation/models/document_model.dart';
import 'package:grimoire/features/wiki/presentation/models/file_tree_model.dart';
import 'package:grimoire/features/wiki/presentation/models/search_model.dart';
import 'package:grimoire/features/wiki/presentation/widgets/loading_widget.dart';
import 'package:grimoire/features/wiki/presentation/widgets/resource_error_widget.dart';

import '../controllers/file_tree_controller.dart';

final fileTreeStateNotifierProvider =
    StateNotifierProvider<FileTreeController, Resource<List<FileTreeModel>>>(
        (ref) => FileTreeController(ref));

final documentStateNotifierProvider =
    StateNotifierProvider<DocumentController, Resource<DocumentModel>>(
        (ref) => DocumentController(ref));

final searchStateNotifierProvider =
    StateNotifierProvider<SearchController, Resource<List<SearchModel>>>(
        (ref) => SearchController(ref));

class GrimoireHomePage extends ConsumerWidget {
  const GrimoireHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BuildContext? mDialogContext;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset(
                'assets/images/grimoire_bg.jpg',
                package: 'grimoire',
              ).image,
              fit: BoxFit.cover),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          width: isPortrait ? 500 : 640,
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Image.asset(
                'assets/icons/grimoire_logo_bw.png',
                package: 'grimoire',
                scale: 2.5,
              ),
              const Spacer(
                flex: 1,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      labelText: 'What do you seek ?'),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Consumer(builder: (mContext, ref, child) {
                var state = ref.watch(fileTreeStateNotifierProvider);
                switch (state.status) {
                  case Status.initial:
                  case Status.loading:
                    break;
                  case Status.completed:
                    _hideLoadingDialog(mDialogContext);
                    break;
                  case Status.error:
                    return ResourceErrorWidget(
                      errorMessage: state.message,
                      errorCode: state.errorCode,
                    );
                }
                return Row(
                  children: [
                    appsContainer('assets/icons/grimoire_logo_bw.png',
                        onTap: () {
                      _showLoadingDialog(context, mDialogContext);
                      ref
                          .read(fileTreeStateNotifierProvider.notifier)
                          .getFileTree('39138680');
                    }),
                    const Spacer(),
                    appsContainer('assets/icons/grimoire_logo_bw.png',
                        onTap: () {
                          _showLoadingDialog(context, mDialogContext);
                      ref
                          .read(fileTreeStateNotifierProvider.notifier)
                          .getFileTree('27745171');
                    }),
                    const Spacer(),
                    appsContainer('assets/icons/grimoire_logo_bw.png',
                        onTap: () {}),
                  ],
                );
              }),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appsContainer(String assetPath, {void Function()? onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 128,
          height: 128,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 111, 86, 120),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Image.asset(
            assetPath,
            package: 'grimoire',
            scale: 10,
          ),
        ),
      ),
    );
  }

  void _hideLoadingDialog(BuildContext? dialogContext) {
    if (dialogContext != null) {
      Navigator.pop(dialogContext);
    }
  }

  Future<void> _showLoadingDialog(
      BuildContext context, BuildContext? dialogContext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext mContext) {
        dialogContext = mContext;
        return const LoadingWidget();
      },
    );
  }
}

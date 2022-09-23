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

BuildContext? _mDialogContext;

class GrimoireHomePage extends ConsumerWidget {
  const GrimoireHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('----- build called...');
    var state = ref.read(fileTreeStateNotifierProvider.notifier);

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    ref.listen<Resource<List<FileTreeModel>>>(fileTreeStateNotifierProvider,
        (previous, next) async {
      print('previous : ${previous?.status}');
      print('next : ${next.status}');
      if (previous?.status == Status.completed) return;
      if (next.status != Status.loading) {
        _hideLoadingDialog(_mDialogContext);
        if (next.status == Status.completed) {
          state.success();
          context.go('/grimoire/explorer');
        }
      }
    });
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
              Row(
                children: [
                  appsContainer('assets/icons/grimoire_logo_bw.png', onTap: () {
                    _showLoadingDialog(context);
                    ref
                        .read(fileTreeStateNotifierProvider.notifier)
                        .getFileTree('39138680');
                  }),
                  const Spacer(),
                  appsContainer('assets/icons/grimoire_logo_bw.png', onTap: () {
                    _showLoadingDialog(context);
                    ref
                        .read(fileTreeStateNotifierProvider.notifier)
                        .getFileTree('27745171');
                  }),
                  const Spacer(),
                  appsContainer('assets/icons/grimoire_logo_bw.png',
                      onTap: () {}),
                ],
              ),
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
    print('hide loading : $dialogContext');
    if (dialogContext != null) {
      Navigator.pop(dialogContext);
    }
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext mContext) {
        _mDialogContext = mContext;
        return const LoadingWidget();
      },
    );
  }
}

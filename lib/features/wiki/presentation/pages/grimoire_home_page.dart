import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:grimoire/features/wiki/presentation/widgets/loading_widget.dart';
import 'package:grimoire/features/wiki/presentation/widgets/resource_error_widget.dart';

import '../controllers/document_controller.dart';
import '../controllers/file_tree_controller.dart';

class GrimoireHomePage extends StatelessWidget {
  GrimoireHomePage({Key? key}) : super(key: key);

  final documentController = Get.put(DocumentController());
  final _fileTreeController = Get.put(FileTreeController());

  @override
  Widget build(BuildContext context) {
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
              Obx(() {
                switch (_fileTreeController.state.value.status) {
                  case Status.initial:
                  case Status.loading:
                    break;
                  case Status.completed:
                    _hideLoadingDialog();
                    context.go('/grimoire/explorer');
                    break;
                  case Status.error:
                    _hideLoadingDialog();
                    return ResourceErrorWidget(
                      errorMessage: _fileTreeController.state.value.message,
                      errorCode: _fileTreeController.state.value.errorCode,
                    );
                }
                return Row(
                  children: [
                    appsContainer('assets/icons/grimoire_logo_bw.png',
                        onTap: () {
                      _showLoadingDialog(context);
                      _fileTreeController.getFileTree('39138680');
                    }),
                    const Spacer(),
                    appsContainer('assets/icons/grimoire_logo_bw.png',
                        onTap: () {
                      _showLoadingDialog(context);
                      _fileTreeController.getFileTree('2033');
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

  void _hideLoadingDialog() {
    if (documentController.dialogContext != null) {
      Navigator.pop(documentController.dialogContext!);
    }
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext mContext) {
        documentController.dialogContext = mContext;
        return const LoadingWidget();
      },
    );
  }
}

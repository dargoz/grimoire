import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/core/models/resource.dart';
import 'package:grimoire/features/wiki/presentation/widgets/loading_widget.dart';

import '../controllers/document_controller.dart';
import '../controllers/file_tree_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

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
                'resources/images/grimoire_bg.jpg',
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
                'resources/icons/grimoire_logo_bw.png',
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
                    context.go('/explorer');
                    break;
                  case Status.error:
                    _showErrorDialog(context,
                        errorMessage: _fileTreeController.state.value.message);
                    break;
                }
                return Row(
                  children: [
                    appsContainer('resources/icons/grimoire_logo_bw.png',
                        onTap: () {
                          _showLoadingDialog(context);
                          _fileTreeController.getFileTree('39138680');
                        }),
                    const Spacer(),
                    appsContainer('resources/icons/grimoire_logo_bw.png',
                        onTap: () {
                      _showLoadingDialog(context);
                      _fileTreeController.getFileTree('');
                    }),
                    const Spacer(),
                    appsContainer('resources/icons/grimoire_logo_bw.png',
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
            scale: 10,
          ),
        ),
      ),
    );
  }

  Future<void> _showErrorDialog(BuildContext context,
      {String? errorMessage}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oops..'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorMessage ?? 'unknown error'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const LoadingWidget();
      },
    );
  }
}

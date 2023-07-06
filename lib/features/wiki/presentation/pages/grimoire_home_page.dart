import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/resource.dart';
import '../controllers/service_controller.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/loading_widget.dart';

class GrimoireHomePage extends ConsumerStatefulWidget {
  const GrimoireHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GrimoireHomePageState();
}

class GrimoireHomePageState extends ConsumerState<GrimoireHomePage> {
  bool _dialogVisible = false;

  @override
  Widget build(BuildContext context) {
    var state = ref.read(serviceStateNotifierProvider.notifier);
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;
    ref.listen<Resource<dynamic>>(serviceStateNotifierProvider,
        (previous, next) async {
      // if (previous?.status == Status.completed) return;
      log('----- build called... ${next.status}');
      if (_dialogVisible && context.canPop()) {
        _hideLoadingDialog(context);
      }
      if (next.status == Status.loading) {
        _showLoadingDialog(context);
      }
      if (next.status == Status.completed) {
        state.reset();
      } else if (next.status == Status.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? 'Unknown Error'),
          ),
        );
      }
    });
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBarWidget(),
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
                /*const Spacer(
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
              ),*/
                const Spacer(
                  flex: 1,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 32,
                  runSpacing: 32,
                  children: [
                    appsContainer('assets/icons/grimoire_logo_bw.png',
                        onTap: () {
                      _openProject('39138680');
                    }),
                    appsContainer('assets/icons/grimoire_logo_bw.png',
                        onTap: () {
                      _openProject('27745171');
                    }),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openProject(String projectId) {
    ref.read(serviceStateNotifierProvider.notifier).repository.projectId =
        projectId;
    context.go('/document/README.md');
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
    _dialogVisible = false;
    print('hide loading : $dialogContext');
    if (dialogContext != null) {
      Navigator.pop(dialogContext);
    }
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    _dialogVisible = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext mContext) {
        return const LoadingWidget();
      },
    );
  }
}

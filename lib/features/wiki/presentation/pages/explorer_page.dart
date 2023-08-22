import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/core/designs/colors/color_schemes.dart';
import 'package:grimoire/features/wiki/presentation/controllers/search_controller.dart' as sc;
import 'package:grimoire/features/wiki/presentation/controllers/service_controller.dart';
import 'package:grimoire/features/wiki/presentation/widgets/file_tree_widget.dart';
import 'package:grimoire/features/wiki/presentation/widgets/search_item_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/designs/widgets/response_error_widget.dart';
import '../../../../core/models/resource.dart';
import '../controllers/file_tree_controller.dart';
import '../controllers/keyboard_controller.dart';
import '../widgets/app_search_widget.dart';
import '../widgets/file_tree_loading_widget.dart';
import '../widgets/search_bar_widget_v2.dart';

class ExplorerPage extends ConsumerStatefulWidget {
  const ExplorerPage({
    Key? key,
    required this.child,
    required this.projectId,
  }) : super(key: key);

  final Widget child;
  final String projectId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends ConsumerState<ExplorerPage> {
  late final KeyboardController _keyboardController;
  late final sc.SearchController _searchController;
  late final FileTreeController _fileController;

  @override
  void initState() {
    print('init state explorer');
    ref.read(serviceStateNotifierProvider.notifier).repository.projectId =
        widget.projectId;
    _keyboardController = ref.read(keyboardStateNotifierProvider.notifier);
    _searchController = ref.read(sc.searchStateNotifierProvider.notifier);
    _fileController = ref.read(fileTreeStateNotifierProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: RawKeyboardListener(
          autofocus: true,
          focusNode: _keyboardController.focusNode,
          onKey: _keyboardController.onKeyEvent,
          child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    const Text(
                      'Grimoire',
                      style: TextStyle(color: Color(0xFF1c1e21)),
                    ),
                    IconButton(
                        onPressed: () {
                          _fileController.refresh();
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
                toolbarHeight: 48,
                backgroundColor: const Color(0xFFfafafa),
                iconTheme: const IconThemeData(color: Color(0xFF1c1e21)),
                actions: [
                  SizedBox(
                    width: 120,
                    child: DropdownSearch<String>(
                      selectedItem: 'Master',
                      asyncItems: _fileController.getBranchList,
                      popupProps: const PopupProps.menu(
                        fit: FlexFit.loose,
                      ),
                      dropdownBuilder: (context, value) {
                        return Text(
                          value ?? '',
                          style: const TextStyle(
                              color: Colors.black),
                        );
                      },
                      dropdownButtonProps: const DropdownButtonProps(
                          padding: EdgeInsets.all(0),
                          isVisible: true),
                      dropdownDecoratorProps:
                      const DropDownDecoratorProps(
                          textAlign: TextAlign.start,
                          dropdownSearchDecoration:
                          InputDecoration(
                              filled: false,
                              floatingLabelAlignment:
                              FloatingLabelAlignment
                                  .center,
                              border: OutlineInputBorder(
                                  gapPadding: 0,
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(16)),
                                  borderSide:
                                  BorderSide.none))),
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(serviceStateNotifierProvider.notifier)
                              .repository
                              .ref = value;
                          _fileController.refresh();
                        }
                      },
                    ),
                  ),
                  AppBarSearchWidget(
                    onTap: () => _keyboardController.showSearchBar(),
                  ),
                  IconButton(
                    onPressed: () async {
                      PackageInfo packageInfo =
                          await PackageInfo.fromPlatform();
                      showAboutDialog(
                          context: context,
                          applicationVersion:
                              '${packageInfo.version}+${packageInfo.buildNumber}',
                          applicationIcon: const Icon(Icons.book),
                          applicationLegalese:
                              'Git Based Markdown Documentation\n'
                              'Created with ♥ and ☕ by DRG');
                    },
                    icon: const Icon(Icons.help),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://secure.gravatar.com/avatar/018afd3eb4d4dcb676df54b56db7c80e?s=64&d=identicon',
                      ),
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  buildContent(context),
                  Consumer(builder: (context, ref, child) {
                    var searchState = ref.watch(sc.searchStateNotifierProvider);
                    return SearchBarWidgetV2(
                      controller: _keyboardController.searchBarController,
                      onFocusChanged: (isFocus) {
                        if (!isFocus) {
                          _keyboardController.hideSearchBar();
                        }
                      },
                      onQueryChanged: _searchController.onQueryChanged,
                      itemList: <Widget>[
                        if (searchState.status == Status.completed)
                          for (int index = 0;
                              index < searchState.data!.length;
                              index++)
                            SearchItemWidget(
                                searchModel: searchState.data![index],
                                onTap: () {
                                  _keyboardController.hideSearchBar();
                                  context.go('/document/${widget.projectId}/${_searchController.getPath(index)}');
                                }),
                      ],
                    );
                  })
                ],
              ))),
    );
  }

  Widget buildContent(BuildContext context) {
    final isPortrait =
        MediaQuery.orientationOf(context) == Orientation.portrait;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isPortrait)
          panelContainer(context,
              childWidget: Column(
                children: [
                  ref.watch(fileTreeStateNotifierProvider).when(
                      data: (model) {
                        if (model.status == Status.loading) {
                          return const FileTreeLoadingWidget();
                        }
                        return Expanded(
                            child: FileTreeWidget(
                          fileTreeModels: model.data?.fileTree ?? [],
                          onTap: (fileTreeModel) {
                            var path =
                                fileTreeModel.path.replaceAll('/', '%2F');
                            context.go("/document/${widget.projectId}/$path");
                          },
                        ));
                      },
                      error: (object, stackTrace) {
                        return const ResponseErrorWidget();
                      },
                      loading: () => const FileTreeLoadingWidget())
                ],
              )),
        Flexible(
          child: widget.child,
        ),
      ],
    );
  }

  Widget panelContainer(BuildContext context, {required Widget childWidget}) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.2,
      height: MediaQuery.sizeOf(context).height,
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(width: 1.0, color: Colors.grey),
        ),
        color: ColorSchemes.secondaryBlueDarker,
      ),
      constraints: const BoxConstraints(minWidth: 100, minHeight: 100),
      child: childWidget,
    );
  }
}

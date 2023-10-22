import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grimoire/core/db/hive_data_source.dart';
import 'package:grimoire/core/designs/colors/color_schemes.dart';
import 'package:grimoire/core/usecases/no_params.dart';
import 'package:grimoire/features/auth/domain/usecases/remove_access_token_use_case.dart';
import 'package:grimoire/features/wiki/presentation/controllers/search_controller.dart' as sc;
import 'package:grimoire/features/wiki/presentation/controllers/service_controller.dart';
import 'package:grimoire/features/wiki/presentation/widgets/file_tree_widget.dart';
import 'package:grimoire/features/wiki/presentation/widgets/no_data_widget.dart';
import 'package:grimoire/features/wiki/presentation/widgets/search_item_widget.dart';
import 'package:grimoire/injection.dart';
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
    this.ref,
  }) : super(key: key);

  final Widget child;
  final String projectId;
  final String? ref;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends ConsumerState<ExplorerPage> {
  late final KeyboardController _keyboardController;
  late final sc.SearchController _searchController;
  late final FileTreeController _fileController;
  final RemoveAccessTokenUseCase _removeAccessTokenUseCase = getIt<RemoveAccessTokenUseCase>();
  String? prevRef;
  @override
  void initState() {
    print('init state explorer');
    ref.read(serviceStateNotifierProvider.notifier).repository.projectId =
        widget.projectId;
    if (widget.ref != null) {
      prevRef = widget.ref;
      ref.read(serviceStateNotifierProvider.notifier).repository.ref =
          widget.ref!;
    }
    _keyboardController = ref.read(keyboardStateNotifierProvider.notifier);
    _searchController = ref.read(sc.searchStateNotifierProvider.notifier);
    _fileController = ref.read(fileTreeStateNotifierProvider.notifier);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ExplorerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('explorer page did update widget $prevRef :: ${widget.ref}');
    if (prevRef != widget.ref) {
      prevRef = widget.ref;
      ref.read(serviceStateNotifierProvider.notifier).repository.ref =
      widget.ref!;
      _fileController.refresh();
    }
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
                    Image.asset(
                      'assets/icons/grimoire_logo_bw.png',
                      package: 'grimoire',
                      scale: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Grimoire',
                      style: TextStyle(
                        color: Color(0xFF1c1e21),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          _fileController.refresh();
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
                toolbarHeight: 60,
                backgroundColor: const Color(0xFFfafafa),
                iconTheme: const IconThemeData(color: Color(0xFF1c1e21)),
                actions: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    width: 120,
                    child: DropdownSearch<String>(
                      selectedItem: ref
                          .read(serviceStateNotifierProvider.notifier)
                          .repository
                          .ref,
                      asyncItems: _fileController.getBranchList,
                      popupProps: PopupProps.menu(
                        fit: FlexFit.loose,
                        showSelectedItems: true,
                        itemBuilder: (context, item, isSelected) {
                          return Container(
                            color: isSelected
                                ? const Color.fromARGB(15, 0, 0, 0)
                                : null,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        },
                      ),
                      dropdownBuilder: (context, value) {
                        return Text(
                          value ?? '',
                          style: const TextStyle(color: Colors.black),
                        );
                      },
                      dropdownButtonProps: const DropdownButtonProps(
                          padding: EdgeInsets.all(0), isVisible: true),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                          textAlign: TextAlign.start,
                          dropdownSearchDecoration: InputDecoration(
                              filled: false,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              border: OutlineInputBorder(
                                  gapPadding: 0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  borderSide: BorderSide.none))),
                      onChanged: (value) async {
                        if (value != null) {
                          ref
                              .read(serviceStateNotifierProvider.notifier)
                              .repository
                              .ref = value;

                          var encryptedBox =
                              await HiveDataSource().openBox('projectBox');
                          encryptedBox.put('branch', value);

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
                  PopupMenuButton(
                    iconSize: 40.0,
                    padding: const EdgeInsets.all(8),
                    offset: const Offset(0, 48),
                    icon: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://secure.gravatar.com/avatar/018afd3eb4d4dcb676df54b56db7c80e?s=64&d=identicon',
                      ),
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            _removeAccessTokenUseCase.executeUseCase(NoParams());
                            context.go('/login');
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Logout'),
                            ],
                          ),
                        ),
                      ];
                    },
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
                          if ((searchState.data?.length ?? 0) == 0)
                            const NoDataWidget()
                          else
                            for (int index = 0;
                                index < searchState.data!.length;
                                index++)
                              SearchItemWidget(
                                  searchModel: searchState.data![index],
                                  onTap: () {
                                    _keyboardController.hideSearchBar();
                                    context.go(
                                        '/document/${widget.projectId}/${_searchController.getPath(index)}');
                                  }),
                      ],
                      onTextNotFocus: () {
                        _keyboardController.focusNode.requestFocus();
                      },
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
                            context.go('/document/${widget.projectId}/$path');
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

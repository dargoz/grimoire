import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grimoire/features/wiki/presentation/widgets/key_caps_widget.dart';

class SearchBarWidgetV2 extends StatefulWidget {
  const SearchBarWidgetV2(
      {super.key,
      this.onQueryChanged,
      this.onFocusChanged,
      required this.controller,
      required this.itemList});

  final void Function(String query)? onQueryChanged;
  final void Function(bool isFocus)? onFocusChanged;
  final SearchBarController controller;
  final List<Widget> itemList;

  @override
  State<StatefulWidget> createState() => SearchBarWidgetState();
}

class SearchBarController extends ChangeNotifier {
  bool _isVisible = false;

  void show() {
    _isVisible = true;
    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  bool get isOpen => _isVisible == true;

  bool get isHidden => _isVisible == false;
}

class SearchBarWidgetState extends State<SearchBarWidgetV2> {
  bool _isVisible = false;
  bool _isFocus = false;
  FocusNode textFocus = FocusNode();
  void Function()? listener;

  @override
  void initState() {
    listener = () {
      setState(() {
        _isVisible = widget.controller.isOpen;
        if (_isFocus != _isVisible) {
          _isFocus = _isVisible;
          widget.onFocusChanged?.call(_isFocus);
        }
        if (_isVisible) {
          textFocus.requestFocus();
        }
      });
    };
    if (listener != null) widget.controller.addListener(listener!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isVisible,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            onTap: () {
              _isFocus = false;
              widget.onFocusChanged?.call(_isFocus);
            },
            child: Container(
              color: const Color.fromARGB(150, 242, 242, 255),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            width: 500,
            constraints: const BoxConstraints(
              minHeight: 300,
              maxHeight: 500,
            ),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 245, 246, 247),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 2.5, spreadRadius: 2)
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    focusNode: textFocus,
                    onChanged: widget.onQueryChanged,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search the docs',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                ),
                Container(
                    constraints:
                        const BoxConstraints(minHeight: 200, maxHeight: 340),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          children: widget.itemList,
                        ),
                      ),
                    )),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const KeyCapsWidget(text: 'esc'),
                        const Text(
                          ' to close',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF969faf)),
                        ),
                        const Spacer(),
                        const Text(
                          'powered by ',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF969faf)),
                        ),
                        SvgPicture.asset('assets/icons/typesense_logo.svg',
                            package: 'grimoire',
                            height: 14,
                            semanticsLabel: 'Typesense Logo'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (listener != null) widget.controller.removeListener(listener!);
    super.dispose();
  }
}

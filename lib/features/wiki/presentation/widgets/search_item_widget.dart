import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:grimoire/features/wiki/presentation/models/search_model.dart';

class SearchItemWidget extends StatefulWidget {
  const SearchItemWidget({super.key, required this.searchModel, this.onTap});

  final SearchModel searchModel;
  final void Function()? onTap;

  @override
  State<StatefulWidget> createState() => _SearchItemState();


}

class _SearchItemState extends State<SearchItemWidget> {

  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (pointerEvent) {
          setState(() {
            _isHover = true;
          });
        },
        onExit: (pointerEvent) {
          setState(() {
            _isHover = false;
          });
        },
        cursor: SystemMouseCursors.click,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            color: _isHover
                ? const Color.fromARGB(255, 196, 239, 255)
                : Colors.white,
            border: const Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
          child: Builder(builder: (builderContext) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                  color: const Color.fromARGB(255, 171, 194, 206),
                  child: Text(
                      widget.searchModel.document?.fileName ?? 'unknown'),
                ),
                Html(
                  data: widget.searchModel.marker.isEmpty ? '' : widget
                      .searchModel.marker[0].snippet,
                )
              ],
            );
          }),
        ),
      ),
    );
  }

}
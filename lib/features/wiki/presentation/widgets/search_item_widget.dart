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
        child: Column(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
              child: Text(
                  widget.searchModel.document?.fileName ?? 'unknown'),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: const EdgeInsets.fromLTRB(8, 16, 4, 16),
              decoration: BoxDecoration(
                color: _isHover
                    ? const Color.fromARGB(255, 196, 239, 255)
                    : Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(4))
              ),
              child: Builder(builder: (builderContext) {
                return Html(
                  data: widget.searchModel.marker.isEmpty ? '' : widget
                      .searchModel.marker[0].snippet,
                );
              }),
            )
          ],
        ),
      ),
    );
  }

}
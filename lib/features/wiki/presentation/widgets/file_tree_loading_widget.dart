import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FileTreeLoadingWidget extends StatelessWidget {
  const FileTreeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Shimmer.fromColors(
            baseColor: const Color(0xFFD0D0D0),
            highlightColor: const Color(0xFFEAEAEA),
            child: ListView.builder(
              itemBuilder: (_, __) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Container(
                      height: 32,
                      decoration: const BoxDecoration(
                          color: Color(0xFFD0D0D0),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
                    child: Container(
                      height: 32,
                      decoration: const BoxDecoration(
                          color: Color(0xFFD0D0D0),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
                    child: Container(
                      height: 32,
                      decoration: const BoxDecoration(
                          color: Color(0xFFD0D0D0),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  )
                ],
              ),
              itemCount: 12,
            )));
  }
}

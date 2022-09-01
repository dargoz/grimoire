import 'package:json_annotation/json_annotation.dart';

part 'highlight.g.dart';

@JsonSerializable()
class Highlight {
  Highlight(
      {required this.field,
      required this.matchedTokens,
      required this.snippet});

  String field;
  List<String> matchedTokens = [];
  String snippet;

  factory Highlight.fromJson(Map<String, dynamic> json) =>
      _$HighlightFromJson(json);

  Map<String, dynamic> toJson() => _$HighlightToJson(this);
}

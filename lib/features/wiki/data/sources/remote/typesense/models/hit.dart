import 'package:grimoire/features/wiki/data/sources/remote/typesense/models/highlight.dart';
import 'package:grimoire/features/wiki/data/sources/remote/typesense/requests/add_document_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hit.g.dart';

@JsonSerializable()
class Hit {
  Hit(
      {required this.document,
      required this.highlights,
      required this.textMatch});

  AddDocumentRequest document;
  List<Highlight> highlights;
  int textMatch;

  factory Hit.fromJson(Map<String, dynamic> json) => _$HitFromJson(json);

  Map<String, dynamic> toJson() => _$HitToJson(this);
}

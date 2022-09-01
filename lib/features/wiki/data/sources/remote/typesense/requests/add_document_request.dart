import 'package:json_annotation/json_annotation.dart';

part 'add_document_request.g.dart';

@JsonSerializable()
class AddDocumentRequest {
  AddDocumentRequest(
      {required this.fileName,
      required this.filePath,
      required this.size,
      required this.content,
      required this.contentSha256,
      required this.blobId,
      required this.commitId,
      required this.authorName,
      required this.committedDate,
      required this.executeFilemode});

  String fileName;
  String filePath;
  int size;
  String content;
  String contentSha256;
  String blobId;
  String commitId;
  String authorName;
  String committedDate;
  bool executeFilemode;

  factory AddDocumentRequest.fromJson(Map<String, dynamic> json) =>
      _$AddDocumentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddDocumentRequestToJson(this);
}

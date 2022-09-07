import 'package:json_annotation/json_annotation.dart';

part 'file_response.g.dart';

@JsonSerializable()
class FileResponse {
  FileResponse(
      {required this.fileName,
      required this.filePath,
      required this.size,
      required this.encoding,
      required this.content,
      required this.contentSha256,
      required this.ref,
      required this.blobId,
      required this.commitId,
      required this.lastCommitId,
      required this.executeFilemode});

  String fileName;
  String filePath;
  int size;
  String encoding;
  String content;
  String contentSha256;
  String ref;
  String blobId;
  String commitId;
  String lastCommitId;
  bool? executeFilemode;

  factory FileResponse.fromJson(Map<String, dynamic> json) =>
      _$FileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileResponseToJson(this);
}

import 'package:grimoire/features/wiki/data/sources/remote/responses/stats_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commit_response.g.dart';

@JsonSerializable()
class CommitResponse {
  CommitResponse(
      {this.id,
      this.shortId,
      this.createdAt,
      this.parentIds,
      this.title,
      this.message,
      this.authorName,
      this.authorEmail,
      this.authoredDate,
      this.committerName,
      this.committerEmail,
      this.committedDate,
      this.trailers,
      this.webUrl,
      this.stats,
      this.status,
      this.projectId,
      this.lastPipeline});

  String? id;
  String? shortId;
  String? createdAt;
  List<String>? parentIds;
  String? title;
  String? message;
  String? authorName;
  String? authorEmail;
  String? authoredDate;
  String? committerName;
  String? committerEmail;
  String? committedDate;
  dynamic trailers;
  String? webUrl;
  Stats? stats;
  dynamic status;
  num? projectId;
  dynamic lastPipeline;

  factory CommitResponse.fromJson(Map<String, dynamic> json) =>
      _$CommitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommitResponseToJson(this);
}

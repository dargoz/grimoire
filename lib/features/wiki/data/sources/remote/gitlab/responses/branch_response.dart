import 'package:grimoire/features/wiki/data/sources/remote/gitlab/responses/commit_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_response.g.dart';

@JsonSerializable()
class BranchResponse {
  BranchResponse(
      {required this.name,
      required this.merged,
      required this.protected,
      required this.defaultBranch,
      required this.developersCanPush,
      required this.developersCanMerge,
      required this.canPush,
      required this.webUrl,
      required this.commit});

  String name;
  bool merged;
  bool protected;
  @JsonKey(name: 'default')
  bool defaultBranch;
  bool developersCanPush;
  bool developersCanMerge;
  bool canPush;
  String webUrl;
  CommitResponse commit;

  factory BranchResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BranchResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'repository_tree_response.g.dart';

@JsonSerializable()
class RepositoryTreeResponse {
  RepositoryTreeResponse(this.id, this.name, this.type, this.path, this.mode);

  String id;
  String name;
  String type;
  String path;
  String mode;

  factory RepositoryTreeResponse.fromJson(Map<String, dynamic> json) =>
      _$RepositoryTreeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryTreeResponseToJson(this);
}

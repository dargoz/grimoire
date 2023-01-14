import 'package:json_annotation/json_annotation.dart';

part 'file_tree_model.g.dart';

@JsonSerializable()
class FileTreeModel {
  FileTreeModel(
      {required this.id,
      required this.name,
      required this.type,
      this.children = const [],
      required this.path});

  String id;
  String name;
  String type;
  List<FileTreeModel> children;
  String path;

  @override
  String toString() {
    return 'FileTreeModel{id: $id, name: $name, type: $type, children: $children, path: $path}';
  }

  factory FileTreeModel.fromJson(Map<String, dynamic> json) =>
      _$FileTreeModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileTreeModelToJson(this);
}

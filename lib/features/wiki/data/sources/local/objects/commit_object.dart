import 'package:hive/hive.dart';

part 'commit_object.g.dart';

@HiveType(typeId: 1)
class CommitObject extends HiveObject {
  CommitObject(
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
      this.committedDate});

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? shortId;
  @HiveField(2)
  String? createdAt;
  @HiveField(3)
  List<String>? parentIds;
  @HiveField(4)
  String? title;
  @HiveField(5)
  String? message;
  @HiveField(6)
  String? authorName;
  @HiveField(7)
  String? authorEmail;
  @HiveField(8)
  String? authoredDate;
  @HiveField(9)
  String? committerName;
  @HiveField(10)
  String? committerEmail;
  @HiveField(11)
  String? committedDate;

  @override
  String toString() {
    return 'CommitObject{id: $id, shortId: $shortId, createdAt: $createdAt, parentIds: $parentIds, title: $title, message: $message, authorName: $authorName, authorEmail: $authorEmail, authoredDate: $authoredDate, committerName: $committerName, committerEmail: $committerEmail, committedDate: $committedDate}';
  }
}

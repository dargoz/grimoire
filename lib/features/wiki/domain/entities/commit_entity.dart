class CommitEntity {
  CommitEntity(
      {required this.title,
      required this.message,
      required this.authorName,
      required this.authorEmail,
      required this.authoredDate,
      required this.committerName,
      required this.committerEmail,
      required this.committedDate,
      required this.trailers,
      required this.webUrl});

  String title;
  String? message;
  String authorName;
  String authorEmail;
  String authoredDate;
  String committerName;
  String committerEmail;
  String committedDate;
  dynamic trailers;
  String webUrl;
}

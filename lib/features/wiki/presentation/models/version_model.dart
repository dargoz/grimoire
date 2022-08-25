class VersionModel {
  VersionModel(
      {required this.title,
      required this.message,
      required this.authorName,
      required this.authorEmail,
      required this.authoredDate,
      required this.committerName,
      required this.committerEmail,
      required this.committedDate});

  String title;
  String? message;
  String authorName;
  String authorEmail;
  String authoredDate;
  String committerName;
  String committerEmail;
  String committedDate;
}

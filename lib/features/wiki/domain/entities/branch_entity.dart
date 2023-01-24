class BranchEntity {
  BranchEntity(
      {required this.name,
      required this.merged,
      required this.protected,
      required this.defaultBranch,
      required this.developersCanPush,
      required this.developersCanMerge,
      required this.canPush,
      required this.webUrl});

  String name;
  bool merged;
  bool protected;
  bool defaultBranch;
  bool developersCanPush;
  bool developersCanMerge;
  bool canPush;
  String webUrl;
}

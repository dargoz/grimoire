class MarkerModel {
  MarkerModel(
      {required this.field,
      required this.matchedTokens,
      required this.snippet});

  String field;
  List<String> matchedTokens = [];
  String snippet;
}

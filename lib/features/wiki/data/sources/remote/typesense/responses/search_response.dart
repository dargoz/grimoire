import 'package:grimoire/features/wiki/data/sources/remote/typesense/models/hit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  SearchResponse(
      {required this.facetCounts,
      required this.found,
      required this.hits,
      required this.outOf,
      required this.page,
      required this.searchCutoff,
      required this.searchTimeMs});

  List<dynamic> facetCounts = [];
  int found;
  List<Hit> hits;
  int outOf;
  int page;
  bool searchCutoff;
  int searchTimeMs;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

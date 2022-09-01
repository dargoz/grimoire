import 'package:json_annotation/json_annotation.dart';

part 'search_query_request.g.dart';

@JsonSerializable()
class SearchQueryRequest {
  SearchQueryRequest(
      {required this.q, required this.queryBy, this.filterBy, this.sortBy});

  String q;
  String queryBy;
  String? filterBy;
  String? sortBy;

  factory SearchQueryRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchQueryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchQueryRequestToJson(this);
}

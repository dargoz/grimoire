import 'package:json_annotation/json_annotation.dart';

part 'stats_response.g.dart';

@JsonSerializable()
class Stats {
  Stats(
      {required this.additions, required this.deletions, required this.total});

  int additions;
  int deletions;
  int total;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  Map<String, dynamic> toJson() => _$StatsToJson(this);
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:grimoire/features/wiki/data/sources/remote/gitlab/responses/commit_response.dart';

import '../../../../../data/get_string.dart';

void main() {
  test('fromJson toJson test', () {
    String apiResponseString = getString('commit_response.json');
    var json = jsonDecode(apiResponseString);
    var result = CommitResponse.fromJson(json);
    print('result : ${result.toJson().toString()}');
    var expected =
        '{id: 6104942438c14ec7bd21c6cd5bd995272b3faff6, short_id: 6104942438c, created_at: 2021-09-20T09:06:12.300+03:00, parent_ids: [ae1d9fb46aa2b07ee9836d49862ec4e2c46fbbba], title: Sanitize for network graph, message: Sanitize for network graph, author_name: randx, author_email: user@example.com, authored_date: 2021-09-20T09:06:12.420+03:00, committer_name: Dmitriy, committer_email: user@example.com, committed_date: 2021-09-20T09:06:12.300+03:00, trailers: null, web_url: https://gitlab.example.com/thedude/gitlab-foss/-/commit/6104942438c14ec7bd21c6cd5bd995272b3faff6, stats: {additions: 15, deletions: 10, total: 25}, status: running, project_id: null, last_pipeline: {id: 8, ref: master, sha: 2dc6aa325a317eda67812f05600bdf0fcdc70ab0, status: created}}';
    expect(result.toJson().toString(), expected);
  });
}

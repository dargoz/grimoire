import 'package:grimoire/core/db/hive_data_source.dart';
import 'package:grimoire/features/auth/data/sources/local/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends HiveDataSource
    implements AuthLocalDataSource {
  static const String authBox = 'authBox';

  AuthLocalDataSourceImpl() : super();

  @override
  Future<String> getAccessToken() async {
    var box = await openBox(authBox);
    return box.get('access_token', defaultValue: '');
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    var box = await openBox(authBox);
    box.put("access_token", accessToken);
  }
  
  @override
  Future removeAccessToken() async {
    var box = await openBox(authBox);
    box.delete("access_token");
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/data/sources/local/auth_local_data_source.dart' as _i736;
import 'features/auth/data/sources/local/auth_local_data_source_impl.dart'
    as _i383;
import 'features/auth/data/sources/remote/auth_remote_data_source.dart'
    as _i641;
import 'features/auth/data/sources/remote/auth_remote_data_source_impl.dart'
    as _i900;
import 'features/auth/data/sources/remote/auth_rest_client.dart' as _i567;
import 'features/auth/data/sources/remote/auth_rest_client_impl.dart' as _i990;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/auth/domain/usecases/get_access_token_use_case.dart' as _i1;
import 'features/auth/domain/usecases/remove_access_token_use_case.dart'
    as _i238;
import 'features/auth/domain/usecases/request_access_token_use_case.dart'
    as _i26;
import 'features/auth/domain/usecases/save_access_token_use_case.dart' as _i220;
import 'features/wiki/data/repositories/search_repository_impl.dart' as _i192;
import 'features/wiki/data/repositories/wiki_repository_impl.dart' as _i905;
import 'features/wiki/data/sources/local/local_data_source.dart' as _i981;
import 'features/wiki/data/sources/local/local_data_source_impl.dart' as _i595;
import 'features/wiki/data/sources/remote/remote_data_source.dart' as _i838;
import 'features/wiki/data/sources/remote/remote_data_source_impl.dart' as _i77;
import 'features/wiki/data/sources/remote/rest_client.dart' as _i605;
import 'features/wiki/data/sources/remote/rest_client_impl.dart' as _i613;
import 'features/wiki/data/sources/remote/search_data_source.dart' as _i301;
import 'features/wiki/data/sources/remote/search_data_source_impl.dart'
    as _i508;
import 'features/wiki/domain/repositories/search_repository.dart' as _i697;
import 'features/wiki/domain/repositories/wiki_repository.dart' as _i26;
import 'features/wiki/domain/usecases/get_document_use_case.dart' as _i827;
import 'features/wiki/domain/usecases/get_file_tree_use_case.dart' as _i315;
import 'features/wiki/domain/usecases/get_image_use_case.dart' as _i56;
import 'features/wiki/domain/usecases/get_saved_branch_use_case.dart' as _i1003;
import 'features/wiki/domain/usecases/get_version_use_case.dart' as _i235;
import 'features/wiki/domain/usecases/search_document_use_case.dart' as _i899;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i567.AuthRestClient>(() => _i990.AuthRestClientImpl());
  gh.singleton<_i981.LocalDataSource>(() => _i595.LocalDataSourceImpl());
  gh.singleton<_i736.AuthLocalDataSource>(
      () => _i383.AuthLocalDataSourceImpl());
  gh.singleton<_i605.RestClient>(() => _i613.RestClientImpl());
  gh.singleton<_i301.SearchDataSource>(() => _i508.SearchDataSourceImpl());
  gh.singleton<_i641.AuthRemoteDataSource>(
      () => _i900.AuthRemoteDataSourceImpl(gh<_i567.AuthRestClient>()));
  gh.singleton<_i838.RemoteDataSource>(
      () => _i77.RemoteDataSourceImpl(gh<_i605.RestClient>()));
  gh.singleton<_i1015.AuthRepository>(() => _i111.AuthRepositoryImpl(
        gh<_i641.AuthRemoteDataSource>(),
        gh<_i736.AuthLocalDataSource>(),
      ));
  gh.singleton<_i26.WikiRepository>(() => _i905.WikiRepositoryImpl(
        gh<_i838.RemoteDataSource>(),
        gh<_i981.LocalDataSource>(),
      ));
  gh.factory<_i1.GetAccessTokenUseCase>(
      () => _i1.GetAccessTokenUseCase(gh<_i1015.AuthRepository>()));
  gh.factory<_i238.RemoveAccessTokenUseCase>(
      () => _i238.RemoveAccessTokenUseCase(gh<_i1015.AuthRepository>()));
  gh.factory<_i26.RequestAccessTokenUseCase>(
      () => _i26.RequestAccessTokenUseCase(gh<_i1015.AuthRepository>()));
  gh.factory<_i220.SaveAccessTokenUseCase>(
      () => _i220.SaveAccessTokenUseCase(gh<_i1015.AuthRepository>()));
  gh.singleton<_i697.SearchRepository>(() => _i192.SearchRepositoryImpl(
        gh<_i301.SearchDataSource>(),
        gh<_i981.LocalDataSource>(),
      ));
  gh.factory<_i899.SearchDocumentUseCase>(
      () => _i899.SearchDocumentUseCase(gh<_i697.SearchRepository>()));
  gh.factory<_i827.GetDocumentUseCase>(() => _i827.GetDocumentUseCase(
        gh<_i26.WikiRepository>(),
        gh<_i697.SearchRepository>(),
      ));
  gh.factory<_i315.GetFileTreeUseCase>(
      () => _i315.GetFileTreeUseCase(gh<_i26.WikiRepository>()));
  gh.factory<_i56.GetImageUseCase>(
      () => _i56.GetImageUseCase(gh<_i26.WikiRepository>()));
  gh.factory<_i1003.GetSavedBranchUseCase>(
      () => _i1003.GetSavedBranchUseCase(gh<_i26.WikiRepository>()));
  gh.factory<_i235.GetVersionUseCase>(
      () => _i235.GetVersionUseCase(gh<_i26.WikiRepository>()));
  return getIt;
}

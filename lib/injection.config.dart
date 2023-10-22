// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'features/auth/data/repositories/auth_repository_impl.dart' as _i18;
import 'features/auth/data/sources/local/auth_local_data_source.dart' as _i3;
import 'features/auth/data/sources/local/auth_local_data_source_impl.dart'
    as _i4;
import 'features/auth/data/sources/remote/auth_remote_data_source.dart' as _i15;
import 'features/auth/data/sources/remote/auth_remote_data_source_impl.dart'
    as _i16;
import 'features/auth/data/sources/remote/auth_rest_client.dart' as _i5;
import 'features/auth/data/sources/remote/auth_rest_client_impl.dart' as _i6;
import 'features/auth/domain/repositories/auth_repository.dart' as _i17;
import 'features/auth/domain/usecases/get_access_token_use_case.dart' as _i19;
import 'features/auth/domain/usecases/remove_access_token_use_case.dart'
    as _i22;
import 'features/auth/domain/usecases/request_access_token_use_case.dart'
    as _i23;
import 'features/auth/domain/usecases/save_access_token_use_case.dart' as _i24;
import 'features/wiki/data/repositories/search_repository_impl.dart' as _i14;
import 'features/wiki/data/repositories/wiki_repository_impl.dart' as _i27;
import 'features/wiki/data/sources/local/local_data_source.dart' as _i7;
import 'features/wiki/data/sources/local/local_data_source_impl.dart' as _i8;
import 'features/wiki/data/sources/remote/remote_data_source.dart' as _i20;
import 'features/wiki/data/sources/remote/remote_data_source_impl.dart' as _i21;
import 'features/wiki/data/sources/remote/rest_client.dart' as _i9;
import 'features/wiki/data/sources/remote/rest_client_impl.dart' as _i10;
import 'features/wiki/data/sources/remote/search_data_source.dart' as _i11;
import 'features/wiki/data/sources/remote/search_data_source_impl.dart' as _i12;
import 'features/wiki/domain/repositories/search_repository.dart' as _i13;
import 'features/wiki/domain/repositories/wiki_repository.dart' as _i26;
import 'features/wiki/domain/usecases/get_document_use_case.dart' as _i28;
import 'features/wiki/domain/usecases/get_file_tree_use_case.dart' as _i29;
import 'features/wiki/domain/usecases/get_image_use_case.dart' as _i30;
import 'features/wiki/domain/usecases/get_saved_branch_use_case.dart' as _i31;
import 'features/wiki/domain/usecases/get_version_use_case.dart' as _i32;
import 'features/wiki/domain/usecases/search_document_use_case.dart' as _i25;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.AuthLocalDataSource>(_i4.AuthLocalDataSourceImpl());
  gh.singleton<_i5.AuthRestClient>(_i6.AuthRestClientImpl());
  gh.singleton<_i7.LocalDataSource>(_i8.LocalDataSourceImpl());
  gh.singleton<_i9.RestClient>(_i10.RestClientImpl());
  gh.singleton<_i11.SearchDataSource>(_i12.SearchDataSourceImpl());
  gh.singleton<_i13.SearchRepository>(_i14.SearchRepositoryImpl(
    gh<_i11.SearchDataSource>(),
    gh<_i7.LocalDataSource>(),
  ));
  gh.singleton<_i15.AuthRemoteDataSource>(
      _i16.AuthRemoteDataSourceImpl(gh<_i5.AuthRestClient>()));
  gh.singleton<_i17.AuthRepository>(_i18.AuthRepositoryImpl(
    gh<_i15.AuthRemoteDataSource>(),
    gh<_i3.AuthLocalDataSource>(),
  ));
  gh.factory<_i19.GetAccessTokenUseCase>(
      () => _i19.GetAccessTokenUseCase(gh<_i17.AuthRepository>()));
  gh.singleton<_i20.RemoteDataSource>(
      _i21.RemoteDataSourceImpl(gh<_i9.RestClient>()));
  gh.factory<_i22.RemoveAccessTokenUseCase>(
      () => _i22.RemoveAccessTokenUseCase(gh<_i17.AuthRepository>()));
  gh.factory<_i23.RequestAccessTokenUseCase>(
      () => _i23.RequestAccessTokenUseCase(gh<_i17.AuthRepository>()));
  gh.factory<_i24.SaveAccessTokenUseCase>(
      () => _i24.SaveAccessTokenUseCase(gh<_i17.AuthRepository>()));
  gh.factory<_i25.SearchDocumentUseCase>(
      () => _i25.SearchDocumentUseCase(gh<_i13.SearchRepository>()));
  gh.singleton<_i26.WikiRepository>(_i27.WikiRepositoryImpl(
    gh<_i20.RemoteDataSource>(),
    gh<_i7.LocalDataSource>(),
  ));
  gh.factory<_i28.GetDocumentUseCase>(() => _i28.GetDocumentUseCase(
        gh<_i26.WikiRepository>(),
        gh<_i13.SearchRepository>(),
      ));
  gh.factory<_i29.GetFileTreeUseCase>(
      () => _i29.GetFileTreeUseCase(gh<_i26.WikiRepository>()));
  gh.factory<_i30.GetImageUseCase>(
      () => _i30.GetImageUseCase(gh<_i26.WikiRepository>()));
  gh.factory<_i31.GetSavedBranchUseCase>(
      () => _i31.GetSavedBranchUseCase(gh<_i26.WikiRepository>()));
  gh.factory<_i32.GetVersionUseCase>(
      () => _i32.GetVersionUseCase(gh<_i26.WikiRepository>()));
  return getIt;
}

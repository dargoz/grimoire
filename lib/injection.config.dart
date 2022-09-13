// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'features/wiki/data/repositories/search_repository_impl.dart' as _i10;
import 'features/wiki/data/repositories/wiki_repository_impl.dart' as _i15;
import 'features/wiki/data/sources/local/local_data_source.dart' as _i3;
import 'features/wiki/data/sources/local/local_data_source_impl.dart' as _i4;
import 'features/wiki/data/sources/remote/remote_data_source.dart' as _i11;
import 'features/wiki/data/sources/remote/remote_data_source_impl.dart' as _i12;
import 'features/wiki/data/sources/remote/rest_client.dart' as _i5;
import 'features/wiki/data/sources/remote/rest_client_impl.dart' as _i6;
import 'features/wiki/data/sources/remote/search_data_source.dart' as _i7;
import 'features/wiki/data/sources/remote/search_data_source_impl.dart' as _i8;
import 'features/wiki/domain/repositories/search_repository.dart' as _i9;
import 'features/wiki/domain/repositories/wiki_repository.dart' as _i14;
import 'features/wiki/domain/usecases/get_document_use_case.dart' as _i16;
import 'features/wiki/domain/usecases/get_file_tree_use_case.dart' as _i17;
import 'features/wiki/domain/usecases/get_image_use_case.dart' as _i18;
import 'features/wiki/domain/usecases/search_document_use_case.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.LocalDataSource>(_i4.LocalDataSourceImpl());
  gh.singleton<_i5.RestClient>(_i6.RestClientImpl());
  gh.singleton<_i7.SearchDataSource>(_i8.SearchDataSourceImpl());
  gh.singleton<_i9.SearchRepository>(
      _i10.SearchRepositoryImpl(get<_i7.SearchDataSource>()));
  gh.singleton<_i11.RemoteDataSource>(
      _i12.RemoteDataSourceImpl(get<_i5.RestClient>()));
  gh.factory<_i13.SearchDocumentUseCase>(
      () => _i13.SearchDocumentUseCase(get<_i9.SearchRepository>()));
  gh.singleton<_i14.WikiRepository>(_i15.WikiRepositoryImpl(
      get<_i11.RemoteDataSource>(), get<_i3.LocalDataSource>()));
  gh.factory<_i16.GetDocumentUseCase>(() => _i16.GetDocumentUseCase(
      get<_i14.WikiRepository>(), get<_i9.SearchRepository>()));
  gh.factory<_i17.GetFileTreeUseCase>(
      () => _i17.GetFileTreeUseCase(get<_i14.WikiRepository>()));
  gh.factory<_i18.GetImageUseCase>(
      () => _i18.GetImageUseCase(get<_i14.WikiRepository>()));
  return get;
}

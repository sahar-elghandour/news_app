// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../api/api_manager.dart' as _i1047;
import '../data/repository/news/data-sources/remote/impl/news-remote-data-sources-impl.dart'
    as _i248;
import '../data/repository/news/data-sources/remote/news-remote-data-sources.dart'
    as _i652;
import '../data/repository/news/repository/impl/news-repository-impl.dart'
    as _i708;
import '../data/repository/news/repository/news-repository.dart' as _i9;
import '../data/repository/sources/data-sources/local/impl/source-local-data-source-impl.dart'
    as _i276;
import '../data/repository/sources/data-sources/local/source-local-data-source.dart'
    as _i325;
import '../data/repository/sources/data-sources/remote/impl/source-remote-data-source-impl.dart'
    as _i658;
import '../data/repository/sources/data-sources/remote/source-remote-data-source.dart'
    as _i652;
import '../data/repository/sources/repository/impl/source-repository-impl.dart'
    as _i14;
import '../data/repository/sources/repository/source-repository.dart' as _i181;
import '../Ui/home/category_details/cubit/sources-view-model.dart' as _i1045;
import '../Ui/home/category_details/news/cubit/news-view-model.dart' as _i364;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i325.SourceLocalDataSource>(
      () => _i276.SourceLocalDataSourceImpl(),
    );
    gh.factory<_i652.SourceRemoteDataSource>(
      () =>
          _i658.SourceRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()),
    );
    gh.factory<_i181.SourceRepository>(
      () => _i14.SourceRepositoryImpl(
        remoteDataSource: gh<_i652.SourceRemoteDataSource>(),
        localDataSource: gh<_i325.SourceLocalDataSource>(),
      ),
    );
    gh.factory<_i652.NewsRemoteDataSources>(
      () =>
          _i248.NewsRemoteDataSourcesImpl(apiManager: gh<_i1047.ApiManager>()),
    );
    gh.factory<_i9.NewsRepository>(
      () => _i708.NewsRepositoryImpl(
        remoteDataSources: gh<_i652.NewsRemoteDataSources>(),
      ),
    );
    gh.factory<_i1045.SourcesViewModel>(
      () => _i1045.SourcesViewModel(
        sourceRepository: gh<_i181.SourceRepository>(),
      ),
    );
    gh.factory<_i364.NewsViewModel>(
      () => _i364.NewsViewModel(newsRepository: gh<_i9.NewsRepository>()),
    );
    return this;
  }
}

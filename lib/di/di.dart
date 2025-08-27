//todo: Source view model       =>obj sourcerepository
//todo: sourcerepository => sourceRemote
//todo: sourceRemote     => apiManager

//todo: news view model       =>obj Newspository
//todo: newsrepository => newsRemote
//todo: newsRemote     => apiManager

 import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/news/data-sources/remote/impl/news-remote-data-sources-impl.dart';
import 'package:news_app/data/repository/news/data-sources/remote/news-remote-data-sources.dart';
import 'package:news_app/data/repository/news/repository/impl/news-repository-impl.dart';
import 'package:news_app/data/repository/sources/data-sources/local/impl/source-local-data-source-impl.dart';
import 'package:news_app/data/repository/sources/data-sources/remote/impl/source-remote-data-source-impl.dart';
import 'package:news_app/data/repository/sources/data-sources/remote/source-remote-data-source.dart';
import 'package:news_app/data/repository/sources/repository/impl/source-repository-impl.dart';
import 'package:news_app/data/repository/sources/repository/source-repository.dart';

import '../data/repository/news/repository/news-repository.dart';
import '../data/repository/sources/data-sources/local/source-local-data-source.dart';
/*
SourceRepository  injectionSourceRepository(){
  return SourceRepositoryImpl(
      remoteDataSource: injectionSourceRemoteDataSources(),
      localDataSource: injectionSourceLocalDataSources());

}
 SourceRemoteDataSource injectionSourceRemoteDataSources(){
  return SourceRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}
SourceLocalDataSource injectionSourceLocalDataSources(){
  return SourceLocalDataSourceImpl();
}

NewsRepository  injectionNewsRepository(){
  return NewsRepositoryImpl(remoteDataSources: injectionNewsRemoteDataSources());

}
NewsRemoteDataSources injectionNewsRemoteDataSources(){
  return NewsRemoteDataSourcesImpl(apiManager: ApiManager.getInstance());
}


 */
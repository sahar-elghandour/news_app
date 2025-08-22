
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/data/repository/news/data-sources/remote/news-remote-data-sources.dart';

import '../../../../../model/NewsResponse.dart';
import '../news-repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsRemoteDataSources remoteDataSources;
  NewsRepositoryImpl({required this.remoteDataSources});

  @override
  Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    // TODO: implement getNewsBySourceId
    return remoteDataSources.getNewsBySourceId(sourceId);

  }
}
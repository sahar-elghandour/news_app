
import 'package:news_app/api/api_manager.dart';

import '../../../../../../model/NewsResponse.dart';
import '../news-remote-data-sources.dart';

class NewsRemoteDataSourcesImpl implements NewsRemoteDataSources{
  ApiManager apiManager;
  NewsRemoteDataSourcesImpl({required this.apiManager});
  @override
  Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    // TODO: implement getNewsBySourceId
    var response = await apiManager.getNewsBySourceId(sourceId);
    return response;
  }

}
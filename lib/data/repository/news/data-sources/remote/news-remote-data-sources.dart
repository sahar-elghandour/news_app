
import '../../../../../model/NewsResponse.dart';
abstract class NewsRemoteDataSources{
  Future<NewsResponse?> getNewsBySourceId(String sourceId);
}
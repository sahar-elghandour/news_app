import 'package:news_app/model/NewsResponse.dart';

import '../../../../model/SourceResponse.dart';

abstract class NewsRepository{
  Future<NewsResponse?> getNewsBySourceId(String sourceId);
}
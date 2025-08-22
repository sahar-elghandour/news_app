//todo: interface source local e data source =>offline

import '../../../../../model/SourceResponse.dart';

abstract class SourceLocalDataSource{
  Future<SourceResponse?> getSources(String categoryId);
}
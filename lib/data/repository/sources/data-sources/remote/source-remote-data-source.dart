//todo: interface source remote data source =>ds

import '../../../../../model/SourceResponse.dart';

abstract class SourceRemoteDataSource{
  Future<SourceResponse?> getSources(String categoryId);
}
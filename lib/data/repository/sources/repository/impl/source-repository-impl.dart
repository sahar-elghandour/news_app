import 'package:news_app/data/repository/sources/data-sources/remote/source-remote-data-source.dart';
import 'package:news_app/data/repository/sources/repository/source-repository.dart';
import 'package:news_app/model/SourceResponse.dart';

class SourceRepositoryImpl implements SourceRepository{
  SourceRemoteDataSource remoteDataSource;
  SourceRepositoryImpl({required this.remoteDataSource});
  @override
  Future<SourceResponse?> getSources(String categoryId) {
    // TODO: implement getSources
   return remoteDataSource.getSources(categoryId);

  }

}
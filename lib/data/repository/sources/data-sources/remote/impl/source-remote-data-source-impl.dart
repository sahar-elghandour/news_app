import 'package:injectable/injectable.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/SourceResponse.dart';

import '../source-remote-data-source.dart';
@Injectable(as: SourceRemoteDataSource)
class SourceRemoteDataSourceImpl implements SourceRemoteDataSource{
  ApiManager apiManager;
  //constructor injection
  SourceRemoteDataSourceImpl({required this .apiManager});
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    // TODO: implement getSources
    var response =await apiManager.getSources(categoryId);
    return response;

  }
  
}
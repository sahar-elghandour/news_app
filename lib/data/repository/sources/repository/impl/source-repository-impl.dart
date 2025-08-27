import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/data/repository/sources/data-sources/local/impl/source-local-data-source-impl.dart';
import 'package:news_app/data/repository/sources/data-sources/local/source-local-data-source.dart';
import 'package:news_app/data/repository/sources/data-sources/remote/source-remote-data-source.dart';
import 'package:news_app/data/repository/sources/repository/source-repository.dart';
import 'package:news_app/model/SourceResponse.dart';
@Injectable(as: SourceRepository)
class SourceRepositoryImpl implements SourceRepository{
  SourceRemoteDataSource remoteDataSource;
  SourceLocalDataSource localDataSource;
  SourceRepositoryImpl({required this.remoteDataSource,required this.localDataSource});
  @override
  Future<SourceResponse?> getSources(String categoryId)async {
    // TODO: implement getSources
    //todo: internet => remote
    final List<ConnectivityResult> connectivityResult
    = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var sourceResponse =await remoteDataSource.getSources(categoryId);
      //todo:save sources
      localDataSource.saveSources(sourceResponse,categoryId);
      return sourceResponse;
    }else{
      //todo: no internet => local
      var sourceResponse=await localDataSource.getSources(categoryId);
      return sourceResponse;
    }



  }

}
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/data/repository/sources/data-sources/local/source-local-data-source.dart';
import 'package:news_app/model/SourceResponse.dart';
@Injectable(as:SourceLocalDataSource )
class SourceLocalDataSourceImpl implements SourceLocalDataSource{
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    // TODO: implement getSources
    var box= await Hive.openBox('sourcesTap');
    var sourceResponse = SourceResponse.fromJson(box.get(categoryId)) ;
    return sourceResponse;
  }

  @override
  void saveSources(SourceResponse? sourceResponse,String categoryId)async {
    // TODO: implement saveSources
    var box=await Hive.openBox('sourcesTap');
    box.put(categoryId, sourceResponse?.toJson());
    await box.close();
  }

}
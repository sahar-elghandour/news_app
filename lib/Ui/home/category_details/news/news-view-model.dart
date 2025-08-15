
import 'package:flutter/material.dart';
import 'package:news_app/model/NewsResponse.dart';

import '../../../../api/api_manager.dart';

class NewsViewModel extends ChangeNotifier {
  //todo: hold data  handel logic
  List<News>? newsList;
  String? errorMessage;
  Future<void> getNewsBySourceId(String sourceId) async {
    //todo: reintialize
    newsList=null;
    errorMessage=null;
    notifyListeners();

    try{
      var response =await ApiManager.getNewsBySourceId(sourceId);
      if(response?.status =='error'){
        // todo: error
        errorMessage=response!.message!;
      }else{
        // todo: success
        newsList=response!.articles!;

      }

    }catch(e){
      errorMessage=e.toString();
    }
    notifyListeners();
  }

}
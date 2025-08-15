import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/SourceResponse.dart';

class SourcesViewModel extends ChangeNotifier{
  //todo: hold data  handel logic
  List<Source>? sourcesList;
  String? errorMessage;
  Future<void> getSources(String categoryId) async {
    //todo: reintialize
    sourcesList=null;
    errorMessage=null;
    notifyListeners();

    try{
      var response =await ApiManager.getSources(categoryId);
      if(response?.status =='error'){
        // todo: error
        errorMessage=response!.message!;
      }else{
        // todo: success
        sourcesList=response!.sources!;

      }

    }catch(e){
      errorMessage=e.toString();
    }
    notifyListeners();
}

}
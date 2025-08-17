import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api_manager.dart';
import 'news-states.dart';

class NewsViewModel extends Cubit<NewsStates>{
  NewsViewModel():super(NewsLoadingState());
  //todo: hold data handel logic
  //List<News>? sourcesList;
  //String? errorMessage;
  void getNewsBySourceId(String sourceId) async {
    try{
      //todo: loading

      emit(NewsLoadingState());
      var response =await ApiManager.getNewsBySourceId(sourceId);
      if(response?.status =='error'){
        // todo: server error
        emit(NewsErrorState(errorMessage: response!.message!));
      }if(response?.status =='ok'){
        // todo: server success
        emit(NewsSuccessState(newsList: response!.articles!));

      }

    }catch(e){
      emit(NewsErrorState(errorMessage: e.toString()));
    }

  }


}
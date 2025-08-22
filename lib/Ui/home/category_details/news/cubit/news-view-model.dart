import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/repository/news/data-sources/remote/impl/news-remote-data-sources-impl.dart';
import 'package:news_app/data/repository/news/data-sources/remote/news-remote-data-sources.dart';
import 'package:news_app/data/repository/news/repository/impl/news-repository-impl.dart';
import 'package:news_app/data/repository/news/repository/news-repository.dart';

import '../../../../../api/api_manager.dart';
import 'news-states.dart';

class NewsViewModel extends Cubit<NewsStates>{
  late NewsRepository newsRepository;

  NewsViewModel({required this.newsRepository}):super(NewsLoadingState());
  //todo: hold data handel logic
  //List<News>? sourcesList;
  //String? errorMessage;
  void getNewsBySourceId(String sourceId) async {
    try{
      //todo: loading

      emit(NewsLoadingState());
      var response =await newsRepository.getNewsBySourceId(sourceId);
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/home/category_details/cubit/sources-states.dart';

import '../../../../api/api_manager.dart';

class SourcesViewModel extends Cubit<SourcesStates>{
  SourcesViewModel():super(SourcesLoadingState());
  //todo: hold data handel logic
  //List<Source>? sourcesList;
  //String? errorMassege;
  void getSources(String categoryId) async {
    try{
      //todo: loading
      emit(SourcesLoadingState());
      var response =await ApiManager.getSources(categoryId);
      if(response?.status =='error'){
        // todo: server error
        emit(SourcesErrorState(errorMessage: response!.message!));
      }if(response?.status =='ok'){
        // todo: server success
        emit(SourcesSuccessState(sourcesList: response!.sources!));

      }

    }catch(e){
      emit(SourcesErrorState(errorMessage: e.toString()));
    }

  }

}
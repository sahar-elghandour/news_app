import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/home/category_details/cubit/sources-states.dart';
import 'package:news_app/data/repository/sources/data-sources/remote/impl/source-remote-data-source-impl.dart';
import 'package:news_app/data/repository/sources/data-sources/remote/source-remote-data-source.dart';
import 'package:news_app/data/repository/sources/repository/impl/source-repository-impl.dart';
import 'package:news_app/data/repository/sources/repository/source-repository.dart';

import '../../../../api/api_manager.dart';

class SourcesViewModel extends Cubit<SourcesStates>{
  late SourceRepository sourceRepository;

  SourcesViewModel({required this.sourceRepository}):super(SourcesLoadingState());

  //todo: hold data handel logic
  //List<Source>? sourcesList;
  //String? errorMassege;
  void getSources(String categoryId) async {
    try{
      //todo: loading
      emit(SourcesLoadingState());
      var response =await sourceRepository.getSources(categoryId);
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
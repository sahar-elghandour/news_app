
import 'package:news_app/model/SourceResponse.dart';

abstract class SourcesStates{}
class SourcesLoadingState extends SourcesStates{}
class SourcesErrorState extends SourcesStates{
  String? errorMessage;
  SourcesErrorState({required this.errorMessage});

}
class SourcesSuccessState extends SourcesStates{
  List<Source>? sourcesList;
  SourcesSuccessState({required this.sourcesList});
}
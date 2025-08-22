import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constant.dart';
import 'package:news_app/api/endpoints.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
class ApiManager{

   Future<SourceResponse?> getSources(String categoryId) async {
    Uri url =Uri.https(ApiConstant.baseUrl,EndPoints.sourceApi,{
      'apiKey':ApiConstant.apiKey,
      'category':categoryId
    });
    try{
      var response = await http.get(url);
      var responseBody=response.body;
      //todo:string => json
      var json = jsonDecode(responseBody);
      //todo: json => obj
      return SourceResponse.fromJson(json);

    }catch(e){
      throw e;
    }


  }

  Future<NewsResponse?> getNewsBySourceId(
      String sourceId, {
        String? query,
        int page = 1,
        int pageSize = 20,
      }) async {
    Uri url = Uri.https(
      ApiConstant.baseUrl,
      EndPoints.everythingApi,
      {
        'apiKey': ApiConstant.apiKey,
        'sources': sourceId,
        if (query != null && query.isNotEmpty) 'q': query,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      },
    );

    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Ui/home/category_details/Source/source_tap_widget.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/api/dio-api-manager.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../../api/app-exception.dart';
import '../../../model/SourceResponse.dart';
/*
class CategoryDetails extends StatefulWidget {
  final Category category;
  final String searchQuery;

  const CategoryDetails({
    super.key,
    required this.category,
    this.searchQuery = '',
  });

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  int selectedSourceIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(widget.category.id),
      builder: (context, snapshot) {
        //todo:loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        //todo:error => client
        if (snapshot.hasError) {
          return buildErrorUI("Something went wrong.");
        }
        //todo:server => response  => success , error
        //todo:server => error
        if (snapshot.data?.status != 'ok') {
          return buildErrorUI(snapshot.data?.message ?? "Unknown error");
        }

        var sourcesList = snapshot.data?.sources ?? [];
        if (sourcesList.isEmpty) {
          return Center(
            child: Text("No data found",
                style: Theme.of(context).textTheme.headlineLarge),

          );
        }
        //todo:server => success

        return SourceTapWidget(
          sourcesList: sourcesList,
          searchQuery: widget.searchQuery,
          initialIndex: selectedSourceIndex,
          onTabChanged: (index) {
            setState(() {
              selectedSourceIndex = index;
            });
          },
        );
      },
    );
  }

  Widget buildErrorUI(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: Theme.of(context).textTheme.labelMedium),
          ElevatedButton(
            onPressed: () => setState(() {}),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greyColor,
            ),
            child: Text(
              "Try again",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}

 */

class CategoryDetails extends StatefulWidget {
  Category category;
   CategoryDetails({super.key,required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
        future: DioApiManager.getInstance().getSources(widget.category.id),
        builder: (context, snapshot) {
          //todo:loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.greyColor,
              ),
            );
          }
          //todo:error => client
          else if (snapshot.hasError) {
            String errorMessage;
            if (snapshot.error is DioException &&
                (snapshot.error as DioException).error is AppException
            ) {
              //todo: object => dioException => object => AppException => message
              errorMessage =
                  ((snapshot.error as DioException).error as AppException)
                      .message;
            } else {
              errorMessage = snapshot.error.toString();
            }

            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(errorMessage, style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium,),
                  ElevatedButton(onPressed: () {
                    DioApiManager.getInstance().getSources(widget.category.id);
                    setState(() {

                    });
                  }, style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyColor
                  ),
                    child: Text("Try again", style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium,),)
                ],
              ),
            );
          } else if (snapshot.hasData) {
            var sourcesList = snapshot.data!.sources;

            if (sourcesList == null || sourcesList.isEmpty) {
              return Center(child: Text('No Sources Found',

                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,),);
            } else {
              return SourceTapWidget(sourcesList: sourcesList,);
            }
          } else {
            return Center(child: Text('Starting fetching data.',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,));
          }
          /*
          //todo:server => response  => success , error
          //todo:server => error
          if(snapshot.data?.status != 'ok'){
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(snapshot.data!.message!,style: Theme.of(context).textTheme.labelMedium,),
                  ElevatedButton(onPressed: (){
                    DioApiManager().getSources(widget.category.id);
                    setState(() {

                    });
                  },style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greyColor
                  ),
                    child: Text("Try again",style: Theme.of(context).textTheme.labelMedium,),)
                ],
              ),
            );
          }
          //todo:server => success
          var sourcesList= snapshot.data?.sources??[];
          return SourceTapWidget(sourcesList: sourcesList,);
        },

           */
        });
  }
}




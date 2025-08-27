import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/home/category_details/Source/source_tap_widget.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/di/di-injectable.dart';
import 'package:news_app/di/di.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/utils/app_colors.dart';

import '../../../model/SourceResponse.dart';
import 'cubit/sources-states.dart';
import 'cubit/sources-view-model.dart';
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
  SourcesViewModel viewModel =getIt<SourcesViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> viewModel,
      child: BlocBuilder<SourcesViewModel,SourcesStates>(
          builder: (context, state) {
            if(state is SourcesLoadingState){
              return const Center(child: CircularProgressIndicator());

            }else if(state is SourcesErrorState){
              return buildErrorUI(state.errorMessage!);


            }else if(state is SourcesSuccessState){
              return SourceTapWidget(
                sourcesList: state.sourcesList!,
                searchQuery: widget.searchQuery,
                initialIndex: selectedSourceIndex,
                onTabChanged: (index) {
                  setState(() {
                    selectedSourceIndex = index;
                  });
                },
              );
            }
            return Container();

          }

      ),
    );
  }

  /*FutureBuilder<SourceResponse?>(
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

       */


  Widget buildErrorUI(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: Theme.of(context).textTheme.labelMedium),
          ElevatedButton(
            onPressed: () {
              viewModel.getSources(widget.category.id);
            },
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
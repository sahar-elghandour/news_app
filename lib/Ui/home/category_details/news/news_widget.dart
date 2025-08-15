import 'package:flutter/material.dart';
import 'package:news_app/Ui/home/category_details/news/news-view-model.dart';
import 'package:news_app/Ui/home/category_details/news/news_item.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../../model/NewsResponse.dart';
import '../../../../utils/app_colors.dart';
/*
class NewsWidget extends StatefulWidget {
  final Source source;
  final String searchQuery;

   NewsWidget({super.key, required this.source, this.searchQuery=''});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final ScrollController scrollController = ScrollController();
  List<News> newsList = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    resetAndFetch();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        fetchNews();
      }
    });
  }

  @override
  void didUpdateWidget(covariant NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.id != widget.source.id ||
        oldWidget.searchQuery != widget.searchQuery) {
      resetAndFetch();
    }
  }
  void resetAndFetch() {
    setState(() {
      newsList.clear();
      currentPage = 1;
      hasMore = true;
      isLoading = false;
    });
    fetchNews();
  }

  Future<void> fetchNews() async {
    setState(() => isLoading = true);

    final response = await ApiManager.getNewsBySourceId(
      widget.source.id ?? '',
      page: currentPage,
      pageSize: 20,
      query: widget.searchQuery.isNotEmpty ? widget.searchQuery : null,
    );

    if (response != null && response.status == 'ok') {
      setState(() {
        newsList.addAll(response.articles ?? []);
        currentPage++;
        if ((response.articles ?? []).isEmpty) {
          hasMore = false;
        }
      });
    } else {
      hasMore = false;
    }

    setState(() => isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (newsList.isEmpty && isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: newsList.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < newsList.length) {
          return NewsItem(news: newsList[index]);
        } else {
          return  Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width*.02,
              vertical: height*.02
            ),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

 */
class NewsWidget extends StatefulWidget {
  final Source source;

  NewsWidget({super.key, required this.source});

  @override
  State createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  NewsViewModel viewModel = NewsViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getNewsBySourceId(widget.source.id??'');
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context)=>viewModel,
      child:Consumer<NewsViewModel>(builder: (context, viewModel, child) {

        if(viewModel.errorMessage !=null){
          //todo: error
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  viewModel.errorMessage!,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.getNewsBySourceId(widget.source.id ?? '');

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greyColor,
                  ),
                  child: Text(
                    "Try again",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              ],
            ),
          );

        }else if(viewModel.newsList ==null){
          //todo: Loading
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.greyColor,
              ),
            );

        }else{
          //todo:success
          return ListView.builder(
            itemCount: viewModel.newsList!.length,
            itemBuilder: (context, index) {
              return NewsItem(news: viewModel.newsList![index]);
            },
          );

        }


      },));
      /*
      FutureBuilder<NewsResponse?>(
        future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
        builder: (context, snapshot) {
          //todo: Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.greyColor,
              ),
            );
          }

          //todo:client error
          else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Something went wrong.",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ApiManager.getNewsBySourceId(widget.source.id ?? '');
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyColor,
                    ),
                    child: Text(
                      "Try again",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  )
                ],
              ),
            );
          }

          //todo: Server error success
          //todo: Server error
          if (snapshot.data?.status != 'ok') {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    snapshot.data?.message ?? "Unknown error",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ApiManager.getNewsBySourceId(widget.source.id ?? '');
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyColor,
                    ),
                    child: Text(
                      "Try again",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  )
                ],
              ),
            );
          }

          //todo:success
          var newsList = snapshot.data?.articles ?? [];
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              return NewsItem(news: newsList[index]);
            },
          );
        },
      ),
    );

       */
  }
}




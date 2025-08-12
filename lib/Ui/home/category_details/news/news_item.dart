import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Ui/home/category_details/news/full_new_bottom_sheet.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatefulWidget {
  News news;
   NewsItem({super.key,required this.news});

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  var height;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showFullNewBottomSheet();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: width * .02, vertical: height * .01
        ),
        padding: EdgeInsets.all(width * .02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 1.5,
                color: Theme
                    .of(context)
                    .indicatorColor)
        ), child: Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: widget.news.urlToImage ?? '',
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator(
                    color: AppColors.greyColor,
                  )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: height * .02,),
          Text(widget.news.title ?? '', style: Theme
              .of(context)
              .textTheme
              .labelLarge,),
          SizedBox(height: height * .02,),
          Row(

            children: [
              Expanded(
                  child: Text('By:${widget.news.author ?? ''}', style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall,)),
              Spacer(),
              Text(
                timeago.format(
                    DateTime.parse(widget.news.publishedAt ?? '').toLocal()),
                style: Theme
                    .of(context)
                    .textTheme
                    .labelSmall,
              )
            ],)

        ],
      ),
      ),
    );
  }

  void showFullNewBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme
          .of(context)
          .indicatorColor,
      isScrollControlled: false,
      builder: (context) =>
          SizedBox(
            height: height * 0.5,
            child: SingleChildScrollView(
              child: FullNewBottomSheet(news: widget.news),
            ),
          ),
    );
  }

}
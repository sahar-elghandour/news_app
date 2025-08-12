import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/assets_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../model/NewsResponse.dart';
import '../../../../utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/app_routes.dart';
import 'news_web_view.dart';

class FullNewBottomSheet extends StatelessWidget {
  News news;
   FullNewBottomSheet({super.key,required this.news});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: width*.02,
        right: width*.02,
        top:  height*.01,
        bottom: height*.03
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
              imageUrl: news.urlToImage??''
                , placeholder: (context, url) =>
              Center(child: CircularProgressIndicator(
               color: AppColors.greyColor,
              )),
               errorWidget: (context, url, error) => Icon(Icons.error),
           ),
         ),SizedBox(height: height*.01,),
        
            Text(news.content??'',style: Theme.of(context).textTheme.headlineSmall,)
          ,SizedBox(height: height*.03,),
            ElevatedButton(
                onPressed: () {
                  if (news.url != null && news.url!.startsWith('http')) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.newsWebViesRouteName,
                      arguments: news.url!,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid URL")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: height*.02
                    )
                    ,shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )
                ),
                child:Text(AppLocalizations.of(context)!.viewFullArticle
                  ,style: Theme.of(context).textTheme.labelLarge,)
            )
          ],
        ),
      ),
    );
  }

  void openUrl(String url) async {
    if (url.isEmpty) {
      debugPrint("URL is empty");
      return;
    }
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
}

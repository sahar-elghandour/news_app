import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/app_language_provider.dart';

class CategoryItem extends StatelessWidget {
  Category category;
  int index;
   CategoryItem({super.key,required this.category,required this.index});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      alignment:(index %2 ==0)? Alignment.bottomRight:Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child:
          Image.asset(category.image),
        ),
        Container(
          width: width*.38,
          margin: EdgeInsets.symmetric(
              horizontal: width*.02,
              vertical: height*.02
          ),
          padding: EdgeInsetsDirectional.only(
            start: (index%2==0)?width*.02:0,
            end: (index%2==0)? 0:width*.02,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(84),
            color: AppColors.greyColor,

          ),child: Row(

           textDirection:(index%2 ==0)? TextDirection.ltr:TextDirection.rtl ,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.viewAll,style: AppStyles.med24White,),
            CircleAvatar(
              radius: 27,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon((index%2 ==0)? Icons.arrow_forward_ios_rounded:Icons.arrow_back_ios_new_rounded
                ,color:Theme.of(context).indicatorColor ,),
            )
          ],
        ),
        )

      ],
    );
  }
}

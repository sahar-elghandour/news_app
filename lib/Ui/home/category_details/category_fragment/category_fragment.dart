import 'package:flutter/material.dart';

import 'package:news_app/Ui/home/category_details/category_fragment/widget/category_item.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_theme_provider.dart';
typedef OnCategoryItemClick =void Function(Category);
class CategoryFragment extends StatelessWidget {
  OnCategoryItemClick onCategoryItemClick;
   CategoryFragment({super.key,required this.onCategoryItemClick});

   List<Category> categoryList=[];
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    categoryList=Category.getCategoriesList(themeProvider.appTheme == ThemeMode.dark);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*.03),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.goodMorningNews,style: Theme.of(context).textTheme.headlineMedium,),
          SizedBox(height: height*.02,),
          Expanded(
           child: ListView.separated(
                 separatorBuilder: (context, index) {
                   return SizedBox(height: height*.02,);

                 },
           itemBuilder: (context, index) {
                   return InkWell(
                     onTap: (){
                       onCategoryItemClick(categoryList[index]);

                     },child:
                   CategoryItem(category: categoryList[index],index: index,));

           },
             itemCount: categoryList.length,
           ),
         )

        ],
      ),
    );
  }
}

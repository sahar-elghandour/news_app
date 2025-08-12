import 'package:flutter/material.dart';
import 'package:news_app/Ui/home/category_details/Source/source_tap_widget.dart';
import 'package:news_app/Ui/home/category_details/category_details.dart';
import 'package:news_app/Ui/home/category_details/category_fragment/category_fragment.dart';
import 'package:news_app/Ui/home/theme/theme_bottom_sheet.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/utils/assets_manager.dart';
import 'package:provider/provider.dart';

import '../../api/api_manager.dart';
import '../../model/SourceResponse.dart';
import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';
import 'language/language_bootom_sheet.dart';

class HomeScreen extends StatefulWidget {
  Source? source;


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool showAppbar=true;
  late LanguageProvider languageProvider;
  late ThemeProvider themeProvider;
  String searchText='';
  List<Source> sourcesList = [];



  @override
  Widget build(BuildContext context) {
     themeProvider = Provider.of<ThemeProvider>(context);
     languageProvider = Provider.of<LanguageProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(

      appBar:showAppbar? AppBar(
        leading: Builder(builder: (context)=> IconButton(
            onPressed: () {
          Scaffold.of(context).openDrawer();

        },
            icon: Icon(Icons.menu),color: Theme.of(context).indicatorColor,)),
        title:
        Text(selectedCategory==null?AppLocalizations.of(context)!.home
        :selectedCategory!.title
        ,style: Theme
            .of(context)
            .textTheme
            .headlineLarge,),
        actions: [
          IconButton(onPressed: (){
            showAppbar=false;
            setState(() {

            });
          }, icon: Icon(Icons.search),color: Theme.of(context).indicatorColor,)
        ],
      ):AppBar(
        toolbarHeight: height*.077,
        automaticallyImplyLeading: false,
      title: TextField(
        autofocus: true,
        style: TextStyle(
          color: Theme.of(context).indicatorColor
        ),
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: searchText.isEmpty ?Icon(Icons.search,color: Theme.of(context).indicatorColor) : null,
          suffixIcon: IconButton(
            icon:  Icon(Icons.close_outlined,color: Theme.of(context).indicatorColor),
            onPressed: () {
              setState(() {
                searchText = "";
                showAppbar = true;
              });
            },
          ),
          hintText: searchText.isEmpty ? AppLocalizations.of(context)!.search : null,
          hintStyle: Theme.of(context).textTheme.headlineLarge,
          filled: true,
          fillColor: Theme.of(context).primaryColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).indicatorColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).indicatorColor,
              width: 1.5,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: height * .001),
        ),
      ),

      ),
      drawer: showDrawer(context),

    body: selectedCategory == null
     ? CategoryFragment(onCategoryItemClick: onCategoryItemClick)
        : CategoryDetails(
    category: selectedCategory!,
    searchQuery: searchText,
    ));


  }

  Widget showDrawer(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: AppColors.blackColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:  BoxDecoration(color: AppColors.whiteColor),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.newsApp,
                style: AppStyles.bold24Black
              ),
            ),
          ),
          ListTile(
            leading: Image(image: AssetImage(AssetsManager.homeIcon)),
            title:  Text(AppLocalizations.of(context)!.goToHome, style: TextStyle(color: AppColors.whiteColor)),
            onTap: () {
              selectedCategory=null;
              Navigator.pop(context);
              setState(() {

              });
            },
          ),
           Divider(color: AppColors.whiteColor
           ,endIndent: width*.04,indent: width*.04,),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width*.04, vertical: height*.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Row(
                 children: [
                   Image(image: AssetImage(AssetsManager.themeIcon)),
                   SizedBox(width: width*.02,),
                   Text(AppLocalizations.of(context)!.theme
                                 ,style:AppStyles.bold20White),
                 ],
               ),
              Container(padding: EdgeInsets.symmetric(vertical: height*.013,horizontal: width*.02),
                  margin: EdgeInsets.symmetric(vertical: height*.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width:2,color: AppColors.greyColor),
                  ),child:InkWell(
                    onTap: (){
                      showThemeBottomSheet();
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(themeProvider.appTheme==ThemeMode.light?
                        AppLocalizations.of(context)!.light:AppLocalizations.of(context)!.dark
                            ,style: AppStyles.bold20White),
                        Icon(Icons.arrow_drop_down_outlined,color: AppColors.whiteColor,size: 35,)
                      ],
                    ),
                  )),
                Divider(color: AppColors.whiteColor
                  ,endIndent: width*.01,indent: width*.01,),
                SizedBox(height: height*.02,),
                Row(
                  children: [
                    Image(image: AssetImage(AssetsManager.themeIcon)),
                    SizedBox(width: width*.02,),
                    Text(AppLocalizations.of(context)!.language
                      ,style:
                      AppStyles.bold20White),
                  ],
                ),
                Container(padding: EdgeInsets.symmetric(
                    vertical: height*.013,horizontal: width*.02),
                    margin: EdgeInsets.symmetric(vertical: height*.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 2,color: AppColors.greyColor),
                    ),child:InkWell(
                      onTap: (){
                        showLanguageBottomSheet();
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(languageProvider.appLanguage=='en'?
                          AppLocalizations.of(context)!.english:AppLocalizations.of(context)!.arabic
                              ,style: AppStyles.bold20White),
                          Icon(Icons.arrow_drop_down_outlined,color: AppColors.whiteColor,size: 35,)
                        ],
                      ),
                    ))

              ],
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(context:context,
        builder:(context) => LanguageBottomSheet()
    );
  }
  void showThemeBottomSheet() {
    showModalBottomSheet(context:context,
        builder:(context) => ThemeBottomSheet()
    );
  }
  Category? selectedCategory;
  void onCategoryItemClick(Category newSelctedCategory){

    setState(() {
      selectedCategory =newSelctedCategory;

    });

  }

}

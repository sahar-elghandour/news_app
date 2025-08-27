import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_language_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class LanguageBottomSheet extends StatefulWidget{
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.all(width*.07),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(onTap: (){
            languageProvider.changeLanguage('en');
          },
            child:languageProvider.appLanguage=='en'?
            getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english):
            getUnSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english),
          )
          ,SizedBox(height: height*.02,)
          ,InkWell(onTap: (){
            languageProvider.changeLanguage('ar');
          },
            child:languageProvider.appLanguage=='ar'?
            getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.arabic):
            getUnSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.arabic),
          )],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String textLanguage}){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textLanguage,style: AppStyles.bold24Black,),
        Icon(Icons.check,color: AppColors.blackColor,)
      ],);
  }
  Widget getUnSelectedLanguageItem({required String textLanguage}){
    return  Text(textLanguage,
      style: AppStyles.med20Black,);
  }


}
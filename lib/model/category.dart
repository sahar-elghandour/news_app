import 'package:news_app/utils/assets_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Category {
  String id;
  String title;
  String image;

  Category({required this.id, required this.image, required this.title});

  static List<Category> getCategoriesList(bool isDark){
    return[
      Category(id:'general',
          image: isDark? AssetsManager.generalLight:AssetsManager.generalDark,
          title: 'General'
      ),
      Category(id:'business',
          image: isDark? AssetsManager.businessLight:AssetsManager.businessDark,
          title: 'Business'
      ),
      Category(id:'sports',
          image: isDark? AssetsManager.sportLight:AssetsManager.sportsDark,
          title: 'Sports'
      ),
      Category(id:'technology',
          image: isDark? AssetsManager.technologyLight:AssetsManager.technologyDark,
          title: 'technology'
      ),
      Category(id:'entertainment',
          image: isDark? AssetsManager.entertainmentLight:AssetsManager.entertainmentDark,
          title: 'Entertainment'
      ),
      Category(id:'health',
          image: isDark? AssetsManager.healthLight:AssetsManager.healthDark,
          title: 'Health'
      ),
      Category(id:'science',
          image: isDark? AssetsManager.scienceLight:AssetsManager.scienceDark,
          title: 'Science'
      )
    ];
     
  }
}
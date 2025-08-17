import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Ui/home/category_details/news/news_web_view.dart';
import 'package:news_app/providers/app_language_provider.dart';
import 'package:news_app/providers/app_theme_provider.dart';
import 'package:news_app/splash_screen/splash_screen.dart';
import 'package:news_app/utils/app_routes.dart';
import 'package:news_app/utils/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/utils/my-block-observer.dart';
import 'package:provider/provider.dart';
import 'Ui/home/home_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(
      MultiProvider(providers: [
          ChangeNotifierProvider(create:(context) => LanguageProvider()),
         ChangeNotifierProvider(create:(context) => ThemeProvider()),],
      child: MyApp()));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRouteName,
      routes: {
        AppRoutes.splashRouteName:(context)=>SplashScreen(),
        AppRoutes.homeRouteName:(context)=>HomeScreen(),
       AppRoutes.newsWebViesRouteName: (context) {
              final url = ModalRoute.of(context)!.settings.arguments
              as String;
              return NewsWebView(url: url);
        }
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,

    );
  }

}
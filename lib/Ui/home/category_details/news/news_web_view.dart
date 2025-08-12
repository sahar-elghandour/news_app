import 'package:flutter/material.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final String url;
  const NewsWebView({super.key, required this.url});

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height*.03,
        backgroundColor: AppColors.whiteColor,
          iconTheme: IconThemeData(
            color: AppColors.blackColor,),

      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
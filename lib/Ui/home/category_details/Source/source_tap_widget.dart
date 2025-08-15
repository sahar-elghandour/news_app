import 'package:flutter/material.dart';
import 'package:news_app/Ui/home/category_details/Source/source_name.dart';
import 'package:news_app/Ui/home/category_details/news/news_widget.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/utils/app_colors.dart';

class SourceTapWidget extends StatefulWidget {
  final List sourcesList;
  final String searchQuery;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  const SourceTapWidget({
    super.key,
    required this.sourcesList,
    this.searchQuery = '',
    this.initialIndex = 0,
    this.onTabChanged,
  });

  @override
  State<SourceTapWidget> createState() => _SourceTapWidgetState();
}

class _SourceTapWidgetState extends State<SourceTapWidget> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourcesList.length,
      initialIndex: selectedIndex,
      child: Column(
        children: [
          TabBar(
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
              widget.onTabChanged?.call(index);
            },
            isScrollable: true,
            indicatorColor: Theme.of(context).indicatorColor,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            tabs: widget.sourcesList.map((source) {
              return SourceName(
                sources: source,
                isSelected: selectedIndex ==
                    widget.sourcesList.indexOf(source),
              );
            }).toList(),
          ),
          Expanded(
            child: NewsWidget(
              key: ValueKey(widget.sourcesList[selectedIndex].id),
              source: widget.sourcesList[selectedIndex],
             // searchQuery: widget.searchQuery,
            ),
          )
        ],
      ),
    );
  }
}

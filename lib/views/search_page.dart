import 'package:flutter/material.dart';
import 'package:precious/resources/widgets/custom_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: const Hero(tag: "search_bar", child: CustomSearchBar()));
  }
}

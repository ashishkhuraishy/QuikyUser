import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: TextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.go,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              hintText: "Search Restaurants and foods",),
          autofocus: true,
        ),
      ),
    );
  }
}

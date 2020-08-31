import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/core/Services/search_service.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentaddress = Provider.of<AddressProvider>(context,listen:false).currentAddress;
    SearchService search = new SearchService(currentAddress: currentaddress);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: TextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.go,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            hintText: "Search Restaurants and foods",
          ),
          autofocus: false,
          onChanged: (val){
            search.getResaturents(query: val);
          },
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable:  null,
          builder: (BuildContext context, dynamic value, Widget child) {
             return  Text("Asdasd");
          },
       ),
    );
  }
}

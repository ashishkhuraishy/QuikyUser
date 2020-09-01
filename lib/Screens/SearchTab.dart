import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Widgets/OptionCard.dart';
import 'package:quiky_user/Widgets/StoreCard.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/core/Providers/HomeProvider.dart';
import 'package:quiky_user/core/Services/search_service.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = new TextEditingController();

  Address currentaddress;
  SearchService search;
  bool loading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentaddress =
        Provider.of<AddressProvider>(context, listen: false).currentAddress;
    search = new SearchService(currentAddress: currentaddress);
    // searchController.addListener(searchListener);
  }

  void searchHandler(data) async {
    if (data.length > 3) {
      setState(() {
        loading = true;
      });
      await search.getResaturents(query: data);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
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
          onSubmitted: (val) {
            searchHandler(val);
          },
          onChanged: (val) {
            if (val.length < 3) {
              search.clearSearch();
            }
          },
          controller: searchController,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ValueListenableBuilder<List<Restaurant>>(
          valueListenable: search.searchValues,
          builder:
              (BuildContext context, List<Restaurant> value, Widget child) {
            if(loading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if (value.length > 0) {
              return ListView.builder(
                itemCount: value.length,
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemBuilder: (ctx, index) {
                  print(value);
                  return StoreCard(
                      scWidth: MediaQuery.of(context).size.width,
                      restaurantModel: value[index]);
                },
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: search.recentQueries.length,
                      itemBuilder: (ctx, index) {
                        return RecentSearchItem(data:search.recentQueries[index],onTap:(){
                          searchHandler(search.recentQueries[index]);
                        });
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: scWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Popular Brands",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text("Most ordered from around your locality",
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: scWidth,
                      height: 141,
                      child: Consumer<HomeProvider>(
                        builder: (ctx, provider, _) {
                          if (provider.popularBrands != null) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.popularBrands.length,
                              itemBuilder: (ctxx, index) {
                                return OptionCard(
                                  title:
                                      "${provider.popularBrands[index].title}",
                                  networkImage:
                                      "$BASE_URL${provider.popularBrands[index].profilePicture}",
                                  secondTitle:
                                      "${provider.popularBrands[index].avgDeliveryTime} mins",
                                );
                              },
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class RecentSearchItem extends StatelessWidget {
  const RecentSearchItem({
    Key key,@required this.data, this.onTap
  }) : super(key: key);

  final String data;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal:10),
          child: Row(
            children: [
              Icon(Icons.search),
              Text("${data}"),
            ],
          ),
        ),
      );
  }
}

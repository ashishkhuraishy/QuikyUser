import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Widgets/StoreCard.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/core/Services/restaurant_service.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/theme/themedata.dart';

class AllStore extends StatelessWidget {
  const AllStore({Key key}) : super(key: key);

  // RestaurantService fetchData({StoreType storeType, BuildContext context}) {
  //   return rs;
  // }

  @override
  Widget build(BuildContext context) {
    final StoreType storeType = ModalRoute.of(context).settings.arguments;

    final currentAddress =
        Provider.of<AddressProvider>(context, listen: false).currentAddress;
    //TODO: Change Hardcoded lat and long
    RestaurantService rs =
        new RestaurantService(storeType: storeType, lat: 10.0261, lng: 76.3125);
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // final address = Provider.of<AddressProvider>(context, listen: false)
            //     .currentAddress;
            // print(address);
            // Navigator.of(context).popAndPushNamed('/selectlocation');
          },
          child: Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.location_on,
                    color: primary,
                  )),
              Consumer<AddressProvider>(
                builder: (ctx, val, widget) {
                  return Text(
                    "${val.currentAddress.shortAddress}",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              )
            ],
          ),
        ),
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: rs.getStores(),
        builder: (ctxz, AsyncSnapshot<List<Restaurant>> stores) {
          if (stores.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                          hintText: "Search...",
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        FilterItem(
                          selected: true,
                        ),
                        FilterItem(
                          selected: false,
                        ),
                        FilterItem(
                          selected: false,
                        ),
                        FilterItem(
                          selected: false,
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: stores.data.length,
                    itemBuilder: (ctx, index) {
                      return StoreCard(
                          scWidth: scWidth,
                          restaurantModel: stores.data[index]);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem({
    Key key,
    this.selected,
  }) : super(key: key);

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: selected ? primary : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: primary),
      ),
      padding: EdgeInsets.all(5),
      child: Text(
        "Trending",
        style: selected ? white13 : Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}

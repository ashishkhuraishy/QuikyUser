import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/core/Services/restaurant_service.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';

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
    RestaurantService rs = new RestaurantService(
        storeType: storeType,
        lat: currentAddress.lat,
        lng: currentAddress.long);
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: rs.getStores(),
          builder: (ctxz, AsyncSnapshot<List<Restaurant>> stores) {
          if (stores.hasData) {
            // return ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: stores.data.length,
            //   itemBuilder: (ctx, index) {
            //     return Text("Asdasdasd");
            //   },
            // );
            print("store data ${stores.data}");
            return Text("loading done");

          } else {
            return Text("loading");
          }
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Widgets/StoreCard.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/core/Services/restaurant_service.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/theme/themedata.dart';

class AllStore extends StatefulWidget {
  const AllStore({Key key}) : super(key: key);

  @override
  _AllStoreState createState() => _AllStoreState();
}

class _AllStoreState extends State<AllStore> {
  RestaurantService rs;
  List<Restaurant> currentFilteredStores = [];
  StoreType storeType;
  bool loading = true;
  String filter = 'All';
  List<Restaurant> animatedlistitems = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  int counter = 0;

  void getData(StoreType storeType) async {
    setState(() {
      loading = true;
    });
    final currentAddress =
        Provider.of<AddressProvider>(context, listen: false).currentAddress;
    //TODO: Change Hardcoded lat and long
    rs =
        new RestaurantService(storeType: storeType, lat: 10.0261, lng: 76.3125);
    currentFilteredStores = await rs.getStores();
    setState(() {
      loading=false;
    });
  }

  void addToAnimatedList() {
    for (int i = 0; i < currentFilteredStores.length; i++) {
    print("future builder calleddfgdfgdfg");

      listKey.currentState
          .insertItem(i, duration: const Duration(milliseconds: 500));
    }
    animatedlistitems = []..addAll(currentFilteredStores);
  }

  Future<List<Restaurant>> getFutureData() async {
    //TODO: Clear print
    print("future builder called");
    // addToAnimatedList();
    return currentFilteredStores;
  }

  Future<void> changeFilter(String filtert) async {
    setState(() {
      filter = filtert;
    });
    switch (filter) {
      case 'All':
        currentFilteredStores = await rs.getStores();
        break;
      case 'Trending':
        currentFilteredStores = rs.trending;
        break;
      case 'Offers':
        currentFilteredStores = rs.nearby;
        break;
      case 'Below 30 Mins':
        currentFilteredStores = rs.nearby;
        break;
      case 'New Arrivals':
        currentFilteredStores = rs.newArrivals;
        break;
      case 'Top Rated':
        currentFilteredStores = rs.rating;
        break;
      default:
    }
    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    animatedlistitems = []..addAll(currentFilteredStores);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    storeType = ModalRoute.of(context).settings.arguments;
    getData(storeType);
  }

  @override
  Widget build(BuildContext context) {
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
        future: getFutureData(),
        // future:  rs.getStores(),
        builder: (ctxz, AsyncSnapshot<List<Restaurant>> stores) {
          if (loading) {
            print("loading one occured");
            return Center(child: CircularProgressIndicator());
          } else if (stores.hasData) {
            if (loading == false) {
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
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          FilterItem(
                              name: "All",
                              selected: filter,
                              onClick: () {
                                changeFilter("All");
                              }),
                          FilterItem(
                              name: "Trending",
                              selected: filter,
                              onClick: () {
                                changeFilter("Trending");
                              }),
                          FilterItem(
                              name: "Offers",
                              selected: filter,
                              onClick: () {
                                changeFilter("Offers");
                              }),
                          FilterItem(
                              name: "Below 30 Mins",
                              selected: filter,
                              onClick: () {
                                changeFilter("Below 30 Mins");
                              }),
                          FilterItem(
                              name: "New Arrivals",
                              selected: filter,
                              onClick: () {
                                changeFilter("New Arrivals");
                              }),
                          FilterItem(
                              name: "Top Rated",
                              selected: filter,
                              onClick: () {
                                changeFilter("Top Rated");
                              }),
                        ],
                      ),
                    ),
                    AnimatedList(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      initialItemCount: animatedlistitems.length,
                      key: listKey,
                      itemBuilder: (ctx, index, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: Offset(0, 0),
                          ).animate(animation),
                          child: StoreCard(
                              scWidth: scWidth,
                              restaurantModel: animatedlistitems[index]),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (loading) {
            print("loading one occured");

              return Center(child: CircularProgressIndicator());
            }
          } else if (stores.hasError) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Something went wrong"),
                    RaisedButton(
                      onPressed: () {
                        print(stores.data);
                        // TODO: add retry code here
                        rs.getStores();
                      },
                      child: Text("Retry"),
                    )
                  ],
                ),
              ),
            );
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
    this.name,
    this.onClick,
  }) : super(key: key);

  final String name;
  final String selected;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: CustomBorderedButton(
        onTap: () {
          onClick();
        },
        color: selected == name
            ? primary
            : Theme.of(context).scaffoldBackgroundColor,
        child: Text(
          "$name",
          style: selected == name
              ? white13
              : Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}

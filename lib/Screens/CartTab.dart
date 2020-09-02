import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Widgets/ProductCard.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';

import '../core/Providers/CartProvider.dart';
import '../theme/themedata.dart';

class CartTab extends StatelessWidget {
  const CartTab({Key key}) : super(key: key);

  void displayOfferBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctxx, val) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Consumer<CartProvider>(
                  builder: (ctx, provider, _) {
                    if (provider.currentOffers.length > 0 &&
                        provider.currentOffers != null) {
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        itemCount: provider.currentOffers.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Text("adasd");
                        },
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("No Offers Available"),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void displayConfirmOrderBottomSheet(
      BuildContext context, Order order, Function onClose) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return BottomSheet(
          onClosing: (){
            onClose();
          },
          builder: (ctx) {
            return StatefulBuilder(
              builder: (BuildContext ctxx, StateSetter val) {
                print(order);
                int payMethod = 0;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: order.items.length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${order.items[index].name}",
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "₹${order.items[index].inlineTotal}",
                                        style: primaryBold14,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            order.coupon != 'nill'
                                ? PaymentRow(
                                    title: "Offer Applied",
                                    price: "${order.coupon}",
                                    style:
                                        Theme.of(context).textTheme.subtitle1)
                                : Container(),
                            PaymentRow(
                                title: "Sub Total",
                                price: "₹${order.subTotal}",
                                style: Theme.of(context).textTheme.subtitle1),
                            PaymentRow(
                                title: "Tax Total",
                                price: "₹${order.taxtotal}",
                                style: Theme.of(context).textTheme.subtitle1),
                            PaymentRow(
                                title: "Delivery Charges",
                                price: "₹${order.delCharges}",
                                style: Theme.of(context).textTheme.subtitle1),
                            order.coupon != 'nill'
                                ? PaymentRow(
                                    title: "Discount Amount",
                                    price: "₹${order.discountAmount}",
                                    style: primary13)
                                : Container(),
                            PaymentRow(
                                title: "Total",
                                price: "₹${order.total}",
                                style: Theme.of(context).textTheme.headline5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: 10),
                                  child: Text(
                                    "Payment",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      val(() {
                                        payMethod = 1;
                                      });
                                    },
                                    child: PaymentMethodItem(
                                      title: "COD",
                                      img: "assets/img/cod.png",
                                      selected: payMethod,
                                      value: 0,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("asdasd");
                                      val(() {
                                        payMethod = 1;
                                      });
                                    },
                                    child: PaymentMethodItem(
                                      title: "$payMethod",
                                      img: "assets/img/gpay.png",
                                      selected: payMethod,
                                      value: 1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      val(() {
                                        payMethod = 1;
                                      });
                                    },
                                    child: PaymentMethodItem(
                                        title: "CARD",
                                        img: "assets/img/card.png",
                                        selected: payMethod,
                                        value: 2),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: FlatButton(
                          onPressed: () {
                            print(order.id);
                            Navigator.of(context).pushNamed('/existingcard',arguments: order);
                          },
                          child: Text("Continue Payment"),
                          color: primary,
                          padding: EdgeInsets.all(15),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    Provider.of<CartProvider>(context, listen: false).getProductsFromCart();
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: Provider.of<CartProvider>(context, listen: false)
                  .cartProducts
                  .length >
              0
          ? Container(
              width: double.infinity,
              child: StatefulBuilder(
                builder: (ctx, builder) {
                  return FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(15),
                    color: primary,
                    onPressed: () async {
                      builder(() {
                        isLoading = !isLoading;
                      });
                      final currentAddress =
                          Provider.of<AddressProvider>(context, listen: false)
                              .currentAddress;
                      final order = await Provider.of<CartProvider>(context,
                              listen: false)
                          .confrimOrder(
                              userLocation:
                                  "${currentAddress.lat},${currentAddress.long}",
                              coupon: null);
                      if (order.isLeft()) {
                        print("Error Occured");
                        // print(order);
                      } else {
                        print("Corder placed");
                        displayConfirmOrderBottomSheet(
                            context, order.fold((l) => l, (r) => r), () {
                          builder(() {
                            isLoading = false;
                          });
                        });
                      }

                      builder(() {
                        isLoading = false;
                      });
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text("Continue Checkout"),
                  );
                },
              ),
            )
          : Container(
              height: 0,
            ),
      body: SafeArea(
        child: Provider.of<CartProvider>(context, listen: false)
                    .cartProducts
                    .length >
                0
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StoreDetails(scWidth: scWidth),
                    Consumer<CartProvider>(
                      builder: (ctx, provider, _) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.currentProducts.length,
                          itemBuilder: (ctxx, index) {
                            return ProductCard(
                              scWidth: scWidth,
                              dataVariation: provider.currentProducts[index],
                              store: Restaurant(
                                  id: provider.currentStoreId,
                                  offers: provider.currentOffers,
                                  employeeId: null,
                                  title: provider.currentTitle,
                                  mobile: null,
                                  gst: null,
                                  tinTan: null,
                                  typeGoods: null,
                                  delivery: null,
                                  vendor: null,
                                  customer: null,
                                  popularBrand: null,
                                  brandLogo: null,
                                  profilePicture: null,
                                  fssai: null,
                                  storeSubType: null,
                                  status: null,
                                  option: null,
                                  totalReviews: null,
                                  avgRating: null,
                                  coordinate: null,
                                  address: provider.currentStoreAddress,
                                  recommendationCount: null,
                                  minimumCostTwo: null,
                                  avgDeliveryTime: null,
                                  active: null,
                                  inOrder: null,
                                  bulkOrder: null,
                                  opening: null,
                                  closing: null,
                                  highlightStatus: null,
                                  featuredBrand: null,
                                  commisionPercentage: null,
                                  user: null,
                                  city: null,
                                  zone: null,
                                  vendorLocation: null),
                            );
                          },
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Consumer<CartProvider>(
                        builder: (ctx, provider, _) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Price",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    "₹${provider.totalPrice}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: FlatButton(
                        color: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: () {
                          displayOfferBottomSheet(context);
                        },
                        child: Text(
                          "Apply Coupon",
                          style: whiteBold13,
                        ),
                      ),
                    ),
                    NoContactDeliveryCard(),
                  ],
                ),
              )
            : Center(
                child: Text("Empty Cart"),
              ),
      ),
    );
  }
}

class PaymentMethodItem extends StatefulWidget {
  const PaymentMethodItem({
    Key key,
    this.img,
    this.title,
    this.selected,
    this.value,
  }) : super(key: key);

  final int selected, value;

  final String img, title;

  @override
  _PaymentMethodItemState createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<PaymentMethodItem> {
  @override
  Widget build(BuildContext context) {
    // int selected = widget.selected;
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20,
      padding: EdgeInsets.all(5),
      // margin: EdgeInsets.only(right:10),
      decoration: BoxDecoration(
          color:
              widget.selected == widget.value ? Colors.orange : Colors.black12,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '${widget.img}',
            width: 24,
            height: 24,
          ),
          Text(
            "${widget.title}",
          )
        ],
      ),
    );
  }
}

class PaymentRow extends StatelessWidget {
  const PaymentRow({Key key, this.price, this.title, this.style})
      : super(key: key);

  final TextStyle style;
  final String price;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title: ",
            style: style,
          ),
          Text(
            "$price",
            style: style,
          )
        ],
      ),
    );
  }
}

class NoContactDeliveryCard extends StatelessWidget {
  const NoContactDeliveryCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: primary),
          borderRadius: BorderRadius.circular(5),
          color: primary10Fade),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.check_circle_outline),
              Text(
                "  No Contact Delivery",
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Our Delivery Partner will call to confirm. Please Make payment through online for selecting No Contact Delivery.",
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}

class StoreDetails extends StatelessWidget {
  const StoreDetails({
    Key key,
    @required this.scWidth,
  }) : super(key: key);

  final double scWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scWidth,
      padding: EdgeInsets.all(20),
      child: Consumer<CartProvider>(
        builder: (ctx, provider, _) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(
                "assets/img/Burger.jpeg",
                width: 50,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                width: scWidth - 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${provider.currentTitle}",
                        style: Theme.of(context).textTheme.headline6),
                    Text(
                      "${provider.currentStoreAddress.trim()}",
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/ProductCard.dart';
import '../Widgets/StoreDetails.dart';
import '../core/Providers/AddressProvider.dart';
import '../core/Providers/CartProvider.dart';
import '../core/Providers/UserProvider.dart';
import '../core/Services/payment_service.dart';
import '../features/cart/domain/entity/order.dart';
import '../features/home/domain/entity/offer.dart';
import '../features/home/domain/entity/restaurents.dart';
import '../theme/themedata.dart';

class CartTab extends StatelessWidget {
  final PaymentService paymentService = new PaymentService();
  CartTab({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Offer selectedOffer;
  void displayOfferBottomSheet(
      BuildContext context, Function onSelect, Offer selectedOffer) {
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
                      return StatefulBuilder(
                        builder: (ctxxx, builder) {
                          return ListView.builder(
                            padding: EdgeInsets.only(top: 10),
                            itemCount: provider.currentOffers.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              print(provider.currentOffers[index]);
                              bool isSelected = selectedOffer != null &&
                                      selectedOffer.offerId ==
                                          provider.currentOffers[index].offerId
                                  ? true
                                  : false;
                              return InkWell(
                                onTap: () {
                                  scaffoldKey.currentState.setState(() {
                                    builder(() {
                                      isSelected = true;
                                      onSelect(provider.currentOffers[index]);
                                      selectedOffer =
                                          provider.currentOffers[index];
                                    });
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${provider.currentOffers[index].title} "),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: primary,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Text(
                                                "%${provider.currentOffers[index].percentage} OFF"),
                                          ),
                                        ],
                                      ),
                                      isSelected ? Text("Applied") : Container()
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
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

  void displayConfirmOrderBottomSheet(BuildContext context) {
    bool loading = true, error = false;
    Future fetchData({Function onfinish}) async {
      final currentAddress =
          Provider.of<AddressProvider>(context, listen: false).currentAddress;
      final order =
          await Provider.of<CartProvider>(context, listen: false).confrimOrder(
        userLocation: "${currentAddress.lat},${currentAddress.long}",
        shippingAddress: "${currentAddress.formattedAddress}",
        coupon: selectedOffer != null ? selectedOffer.code : null,
      );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        fetchData(onfinish: () {
          scaffoldKey.currentState.setState(() {
            loading = false;
          });
        });
        return BottomSheet(
          backgroundColor: Colors.transparent,
          onClosing: () {},
          builder: (ctx) {
            int payMethod = 0;
            Order returnOrder;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Consumer<CartProvider>(
                builder: (ctx, provider, _) {
                  if (provider.cartConfirmLoading) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 2 - 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (provider.confOrder == null) {
                    return Container(
                        height: MediaQuery.of(context).size.height / 2 - 100,
                        child: Center(child: Text("Something went wrong")));
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15),
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: provider.confOrder.items.length,
                                  itemBuilder: (ctx, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              "${provider.confOrder.items[index].name}",
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "₹${provider.confOrder.items[index].inlineTotal}",
                                              style: primaryBold14,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                provider.confOrder.coupon != 'nill' &&
                                        provider.confOrder.coupon != null &&
                                        provider.confOrder.coupon != 'Null'
                                    ? PaymentRow(
                                        title: "Offer Applied",
                                        price: "${provider.confOrder.coupon}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1)
                                    : Container(),
                                PaymentRow(
                                    title: "Sub Total",
                                    price: "₹${provider.confOrder.subTotal}",
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                PaymentRow(
                                    title: "Tax Total",
                                    price: "₹${provider.confOrder.taxtotal}",
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                PaymentRow(
                                    title: "Delivery Charges",
                                    price: "₹${provider.confOrder.delCharges}",
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                provider.confOrder.coupon != 'nill'
                                    ? PaymentRow(
                                        title: "Discount Amount",
                                        price:
                                            "₹${provider.confOrder.discountAmount}",
                                        style: primary13)
                                    : Container(),
                                PaymentRow(
                                    title: "Total",
                                    price: "₹${provider.confOrder.total}",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 10),
                                      child: Text(
                                        "Payment",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                StatefulBuilder(
                                  builder: (contex2, state) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          PaymentMethodItem(
                                              title: "COD",
                                              img: "assets/img/cod.png",
                                              selected: payMethod,
                                              value: 0,
                                              onTap: () {
                                                scaffoldKey.currentState
                                                    .setState(() {
                                                  state(() {
                                                    payMethod = 0;
                                                  });
                                                });
                                              }),
                                          // PaymentMethodItem(
                                          //     title: "G PAY",
                                          //     img: "assets/img/gpay.png",
                                          //     selected: payMethod,
                                          //     value: 1,
                                          //     onTap: () {
                                          //       scaffoldKey.currentState.setState(() {
                                          //         state(() {
                                          //           payMethod = 1;
                                          //         });
                                          //       });
                                          //     }),
                                          PaymentMethodItem(
                                              title: "CARD",
                                              img: "assets/img/card.png",
                                              selected: payMethod,
                                              value: 2,
                                              onTap: () {
                                                scaffoldKey.currentState
                                                    .setState(() {
                                                  state(() {
                                                    payMethod = 2;
                                                  });
                                                });
                                              }),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: FlatButton(
                              onPressed: () async {
                                // print(order.id);
                                if (payMethod == 0) {
                                  //COD
                                  print(provider.confOrder.id);
                                  paymentService.startCod(provider.confOrder);
                                  
                                  scaffoldKey.currentState.setState(() {
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .clear;
                                  });
                                  Navigator.popAndPushNamed(context, '/orderplaced');
                                  // StripeService sp = new StripeService();
                                  // sp.payAsCod(order.id, order.total);
                                } else if (payMethod == 2) {
                                  //Online Payment

                                  print("${provider.confOrder.id}");
                                  final user = Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .getUser;
                                  paymentService.onSuccess = () {
                                    print("payment success");
                                    paymentService.clearinstance();
                                    scaffoldKey.currentState.setState(() {
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .clear;
                                    });
                                  };
                                  paymentService.onFailure = () {
                                    print("payment failure");
                                    paymentService.clearinstance();
                                  };
                                  await paymentService.startOnlinePayment(
                                    order: provider.confOrder,
                                    user: user,
                                    storeName: "Store",
                                  );
                                  Navigator.popAndPushNamed(context, '/orderplaced');
                                  // Navigator.pop(context);
                                  // paymentService.clearinstance();
                                }
                              },
                              child: Text("Continue Payment"),
                              color: primary,
                              padding: EdgeInsets.all(15),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
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
    Offer coupon;

    return Scaffold(
      key: scaffoldKey,
      bottomSheet: Consumer<CartProvider>(
        builder: (ctx, provider, _) {
          return provider.cartProducts.length > 0
              ? Container(
                  width: double.infinity,
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(15),
                    color: primary,
                    onPressed: () async {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .getUser ==
                          null) {
                        Navigator.of(context).pushNamed('/signup');
                      }
                      displayConfirmOrderBottomSheet(context);
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text("Continue Checkout"),
                  ),
                )
              : Container(
                  height: 0,
                );
        },
      ),
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (ctx, provider, _) {
            return provider.cartProducts.length > 0
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
                                  dataVariation:
                                      provider.currentProducts[index],
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
                                    location: null,
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
                                    vendorLocation: null,
                                  ),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Text(
                                        "₹${provider.totalPrice}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: StatefulBuilder(
                            builder: (context1, state) {
                              return FlatButton(
                                color: primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: () {
                                  displayOfferBottomSheet(context, (offer) {
                                    selectedOffer = offer;
                                  }, coupon);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Apply Coupon",
                                      style: whiteBold13,
                                    ),
                                    coupon != null
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            color: Colors.black12,
                                            child: Text(
                                              "${coupon.title} %${coupon.percentage}OFF",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          )
                                        : Text("►")
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        NoContactDeliveryCard(),
                      ],
                    ),
                  )
                : Center(
                    child: Text("Your cart is empty",style:Theme.of(context).textTheme.headline5),
                  );
          },
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
    this.onTap,
  }) : super(key: key);

  final int selected, value;
  final void Function() onTap;

  final String img, title;

  @override
  _PaymentMethodItemState createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<PaymentMethodItem> {
  @override
  Widget build(BuildContext context) {
    // int selected = widget.selected;
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width / 3 - 20,
      padding: EdgeInsets.all(5),
      // margin: EdgeInsets.only(right:10),
      decoration: BoxDecoration(
          color:
              widget.selected == widget.value ? Colors.orange : Colors.black12,
          borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
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

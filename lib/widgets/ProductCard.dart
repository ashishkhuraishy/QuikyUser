import 'package:flutter/material.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/products/data/models/product_model.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';
import 'package:quiky_user/theme/themedata.dart';
import 'package:quiky_user/widgets/FoodSafetyDot.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.scWidth,
    this.addedToCart,
    this.data,
    this.dataVariation,
  }) : super(key: key);

  final double scWidth;
  final int addedToCart;
  final ProductModel data;
  final Variation dataVariation;

  void displayBottomSheet(BuildContext context, ProductModel data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctxx, val) {
            return Container(
              padding:  EdgeInsets.only(bottom:5.0),
              child: ListView.builder(
                padding: EdgeInsets.only(top:10),
                itemCount: data.variations.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  print(data.variations);
                  return ProductCard(scWidth: scWidth,dataVariation: data.variations[index],);
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
    double maxPrice = 0.0;
    double minPrice;
    if (data != null) {
       minPrice = data.variations[0] != null
        ? double.tryParse(data.variations[0].price)
        : 0;
      data.variations.forEach((element) {
        if (element.price != null) {
          if (double.tryParse(element.price) > maxPrice) {
            maxPrice = double.tryParse(element.price);
          }
          if (double.tryParse(element.price) < minPrice) {
            minPrice = double.tryParse(element.price);
          }
        }
      });
    }

    return Padding(
      padding:  EdgeInsets.only(left: 15.0,bottom:15.0, right: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Stack(
                children: <Widget>[
                  data != null
                      ? data.image != ""
                          ? Image.network(
                              "$BASE_URL${data.image}",
                              width: 90,
                              height: 112,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 30,
                              height: 30,
                            )
                      : dataVariation.image != ""
                          ? Image.network(
                              "$BASE_URL${dataVariation.image}",
                              width: 90,
                              height: 112,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 30,
                              height: 30,
                            ),
                  Positioned(top: 0, right: 0, child: FoodSafetyDot())
                ],
              ) //,
              ),
          Container(
            constraints: BoxConstraints(
              maxWidth: data!=null ?scWidth - (data.image != "" ? 120 : 60):scWidth - (dataVariation.image != "" ? 120 : 60),
              // maxWidth: scWidth - 70,
            ),
            height: 112,
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  data != null ? "${data.title}" : "${dataVariation.title}",
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                // Spacer(flex:1),
                Text(
                  data != null ? "${data.description}" : "",
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  data != null
                      ? "${minPrice != maxPrice ? '₹$minPrice ~ ₹$maxPrice' : '₹$minPrice'} "
                      : "₹${dataVariation.price}",
                  style: primaryBold14,
                  overflow: TextOverflow.ellipsis,
                ),
                dataVariation !=null? 
                addedToCart!=null && addedToCart>0?
                Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: primary)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                width: 40,
                                height: 30,
                                child: FlatButton(
                                  padding: EdgeInsets.all(2),
                                  onPressed: () {},
                                  child: Icon(Icons.remove, color: primary),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("1"),
                              ),
                              SizedBox(
                                width: 40,
                                height: 30,
                                child: FlatButton(
                                  padding: EdgeInsets.all(2),
                                  onPressed: () {},
                                  child: Icon(Icons.add, color: primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ):Align(
                        alignment: Alignment.bottomRight,
                        child: CustomBorderedButton(
                          onTap: () {
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Add"),
                              Icon(Icons.add, color: primary)
                            ],
                          ),
                        ),
                      )
                      :Align(
                        alignment: Alignment.bottomRight,
                        child: CustomBorderedButton(
                          onTap: () {
                            displayBottomSheet(context, data);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Add"),
                              addedToCart != null && addedToCart>0?
                              Icon(Icons.check, color: primary):
                              Icon(Icons.add, color: primary)
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

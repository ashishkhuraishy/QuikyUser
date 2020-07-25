import 'package:quiky_user/features/products/data/models/category_model.dart';
import 'package:quiky_user/features/products/data/models/variation_model.dart';
import 'package:quiky_user/features/products/domain/entity/product.dart';

class ProductModel extends Product {
  int id;
  List<String> productimage;
  List<VariationModel> variation;
  List<String> productreviews;
  List<String> productviews;
  CategoryModel category;
  String image;
  String title;
  String sku;
  String tax;
  String description;
  int quantity;
  String discount;
  bool isStock;
  bool isFeatured;
  bool isDiscount;
  String vegNvEgg;
  bool active;
  String timestamp;
  String updated;
  int user;
  String filter;

  ProductModel(
      {this.id,
      this.productimage,
      this.variation,
      this.productreviews,
      this.productviews,
      this.category,
      this.image,
      this.title,
      this.sku,
      this.tax,
      this.description,
      this.quantity,
      this.discount,
      this.isStock,
      this.isFeatured,
      this.isDiscount,
      this.vegNvEgg,
      this.active,
      this.timestamp,
      this.updated,
      this.user,
      this.filter})
      : super(
          id: id,
          productImages: productimage,
          variations: variation,
          productReviews: productreviews,
          productViews: productreviews,
          category: category,
          image: image,
          title: title,
          sku: sku,
          tax: tax,
          description: description,
          quantity: quantity,
          discount: discount,
          isStock: isStock,
          isFeatured: isFeatured,
          isDiscount: isDiscount,
          vegNvEgg: vegNvEgg,
          active: active,
          timestamp: timestamp,
          updated: updated,
          user: user,
          filter: filter,
        );

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['productimage'] != null) {
      productimage = new List<String>();
      json['productimage'].forEach((v) {
        productimage.add(v);
      });
    } else
      productimage = [];
    if (json['variation'] != null) {
      variation = new List<VariationModel>();
      json['variation'].forEach((v) {
        variation.add(new VariationModel.fromJson(v));
      });
    } else
      variation = [];
    if (json['productreviews'] != String) {
      productreviews = new List<String>();
      json['productreviews'].forEach((v) {
        productreviews.add(v);
      });
    } else
      productreviews = [];
    if (json['productviews'] != String) {
      productviews = new List<String>();
      json['productviews'].forEach((v) {
        productviews.add(v);
      });
    } else
      productviews = [];
    category = json['category'] != String
        ? new CategoryModel.fromJson(json['category'])
        : [];
    image = json['image'] ?? '';
    title = json['title'] ?? '';
    sku = json['sku'] ?? '';
    tax = json['tax'] ?? '';
    description = json['description'] ?? '';
    quantity = json['quantity'] ?? 0;
    discount = json['discount'] ?? '';
    isStock = json['is_stock'] ?? false;
    isFeatured = json['is_featured'] ?? false;
    isDiscount = json['is_discount'] ?? false;
    vegNvEgg = json['veg_nv_egg'] ?? '';
    active = json['active'] ?? false;
    timestamp = json['timestamp'] ?? '';
    updated = json['updated'] ?? '';
    user = json['user'] ?? -1;
    filter = json['filter'] ?? '';
  }
}

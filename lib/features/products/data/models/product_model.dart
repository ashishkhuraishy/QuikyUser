import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';
import 'package:quiky_user/features/products/data/models/category_model.dart';
import 'package:quiky_user/features/products/data/models/variation_model.dart';
import 'package:quiky_user/features/products/domain/entity/product.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';

class ProductModel extends Product {
  final int id;
  final List<String> productimage;
  final List<VariationModel> variations;
  final List<String> productreviews;
  final List<String> productviews;
  final CategoryModel category;
  final String image;
  final String title;
  final String sku;
  final String tax;
  final String description;
  final int quantity;
  final String discount;
  final bool isStock;
  final bool isFeatured;
  final bool isDiscount;
  final String vegNvEgg;
  final bool active;
  final String timestamp;
  final String updated;
  final int user;
  final String filter;

  ProductModel({
    @required this.id,
    @required this.productimage,
    @required this.variations,
    @required this.productreviews,
    @required this.productviews,
    @required this.category,
    @required this.image,
    @required this.title,
    @required this.sku,
    @required this.tax,
    @required this.description,
    @required this.quantity,
    @required this.discount,
    @required this.isStock,
    @required this.isFeatured,
    @required this.isDiscount,
    @required this.vegNvEgg,
    @required this.active,
    @required this.timestamp,
    @required this.updated,
    @required this.user,
    @required this.filter,
  }) : super(
          id: id,
          productImages: productimage,
          variations: variations,
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productimage: json['productimage'] != null
          ? json['productimage'].map<String>((e) => e.toString()).toList()
          : [],
      variations: json['variation'] != null
          ? json['variation']
              .map<VariationModel>((e) => VariationModel.fromJson(e))
              .toList()
          : [],
      productreviews: json['productreviews'] != null
          ? json['productreviews'].map<String>((e) => e.toString()).toList()
          : [],
      productviews: json['productviews'] != null
          ? json['productviews'].map<String>((e) => e.toString()).toList()
          : [],
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : CategoryModel(
              id: null, imgUrl: null, title: null, userId: null, produts: []),
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      sku: json['sku'] ?? '',
      tax: json['tax'].toString() ?? '',
      description: json['description'] ?? '',
      quantity: json['quantity'] ?? 0,
      discount: json['discount'].toString() ?? '',
      isStock: json['is_stock'] ?? false,
      isFeatured: json['is_featured'] ?? false,
      isDiscount: json['is_discount'] ?? false,
      vegNvEgg: json['veg_nv_egg'] ?? '',
      active: json['active'] ?? false,
      timestamp: json['timestamp'] ?? '',
      updated: json['updated'] ?? '',
      user: json['user'] ?? -1,
      filter: json['filter'] ?? '',
    );
  }

  factory ProductModel.fromCartItem(CartItem cartItem) {
    Variation variation = Variation(
      id: cartItem.id,
      image: null,
      title: cartItem.name,
      color: null,
      weight: null,
      size: null,
      isStock: cartItem.inStock,
      price: cartItem.price,
      quantity: cartItem.quantity.toString(),
      updated: null,
      active: null,
      productId: null,
    );

    return ProductModel(
      id: null,
      productimage: null,
      variations: [variation],
      productreviews: null,
      productviews: null,
      category: null,
      image: null,
      title: null,
      sku: null,
      tax: null,
      description: null,
      quantity: null,
      discount: null,
      isStock: null,
      isFeatured: null,
      isDiscount: null,
      vegNvEgg: null,
      active: null,
      timestamp: null,
      updated: null,
      user: null,
      filter: null,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/home/data/model/offer_model.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';

class RestaurantModel extends Restaurant {
  final int id;
  final List<Offer> offers;
  final String employeeId;
  final String title;
  final String mobile;
  final String gst;
  final String tinTan;
  final String typeGoods;
  final bool delivery;
  final bool vendor;
  final bool customer;
  final bool popularBrand;
  final String brandLogo;
  final String profilePicture;
  final String fssai;
  final String storeSubType;
  final String status;
  final String option;
  final String location;
  final String totalReviews;
  final String avgRating;
  final String coordinate;
  final String address;
  final String recommendationCount;
  final String minimumCostTwo;
  final String avgDeliveryTime;
  final bool active;
  final bool inOrder;
  final bool bulkOrder;
  final String opening;
  final String closing;
  final bool highlightStatus;
  final bool featuredBrand;
  final String commisionPercentage;
  final String user;
  final String city;
  final String zone;
  final String vendorLocation;

  RestaurantModel({
    @required this.id,
    @required this.offers,
    @required this.employeeId,
    @required this.title,
    @required this.mobile,
    @required this.gst,
    @required this.tinTan,
    @required this.typeGoods,
    @required this.delivery,
    @required this.vendor,
    @required this.customer,
    @required this.popularBrand,
    @required this.brandLogo,
    @required this.profilePicture,
    @required this.fssai,
    @required this.storeSubType,
    @required this.status,
    @required this.option,
    @required this.totalReviews,
    @required this.avgRating,
    @required this.coordinate,
    @required this.address,
    @required this.location,
    @required this.recommendationCount,
    @required this.minimumCostTwo,
    @required this.avgDeliveryTime,
    @required this.active,
    @required this.inOrder,
    @required this.bulkOrder,
    @required this.opening,
    @required this.closing,
    @required this.highlightStatus,
    @required this.featuredBrand,
    @required this.commisionPercentage,
    @required this.user,
    @required this.city,
    @required this.zone,
    @required this.vendorLocation,
  }) : super(
          id: id,
          offers: offers,
          employeeId: employeeId,
          title: title,
          mobile: mobile,
          gst: gst,
          tinTan: tinTan,
          typeGoods: typeGoods,
          delivery: delivery,
          customer: customer,
          popularBrand: popularBrand,
          brandLogo: brandLogo,
          profilePicture: profilePicture,
          fssai: fssai,
          storeSubType: storeSubType,
          status: status,
          option: option,
          totalReviews: totalReviews,
          avgRating: avgRating,
          coordinate: coordinate,
          address: address,
          recommendationCount: recommendationCount,
          minimumCostTwo: minimumCostTwo,
          avgDeliveryTime: avgDeliveryTime,
          location: location,
          active: active,
          inOrder: inOrder,
          bulkOrder: bulkOrder,
          opening: opening,
          closing: closing,
          highlightStatus: highlightStatus,
          featuredBrand: featuredBrand,
          vendor: vendor,
          commisionPercentage: commisionPercentage,
          user: user,
          city: city,
          zone: zone,
          vendorLocation: vendorLocation,
        );
  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? -1,
      offers:
          json['offer'].map<Offer>((e) => OfferModel.fromJson(e)).toList() ??
              [],
      employeeId: json['employee_id'] ?? '',
      title: json['title'] ?? '',
      mobile: json['mobile'] ?? '',
      gst: json['gst'] ?? '',
      tinTan: json['tin_tan'] ?? '',
      typeGoods: json['type_goods'] ?? '',
      delivery: json['delivery'] ?? false,
      vendor: json['vendor'] ?? false,
      customer: json['customer'] ?? false,
      popularBrand: json['popular_brand'] ?? false,
      brandLogo: json['brand_logo'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      fssai: json['FSSAI'] ?? '',
      storeSubType: json['store_sub_type'] ?? '',
      status: json['status'] ?? '',
      option: json['option'] ?? '',
      totalReviews: "${json['total_reviews'] ?? 0}" ?? '',
      avgRating: json['avg_rating'] ?? '0',
      coordinate: json['coordinate'] ?? '',
      address: json['address'] ?? '',
      recommendationCount: json['recommendation_count'] ?? '',
      minimumCostTwo: json['minimum_cost_two'] ?? '',
      avgDeliveryTime: json['avg_delivery_time'] ?? '0.0',
      active: json['active'] ?? false,
      inOrder: json['in_order'] ?? false,
      bulkOrder: json['bulk_order'] ?? false,
      location: json['location'] ?? '',
      opening: json['opening'] ?? '',
      closing: json['closing'] ?? '',
      highlightStatus: json['highlight_status'] ?? false,
      featuredBrand: json['featured_brand'] ?? false,
      commisionPercentage: "${json['commision_percentage'] ?? ''}" ?? '',
      user: "${json['user'] ?? ''}" ?? '',
      city: "${json['city'] ?? ''}" ?? '',
      zone: "${json['zone'] ?? ''}" ?? '',
      vendorLocation: json['vendor_location'] ?? '',
    );
  }
}

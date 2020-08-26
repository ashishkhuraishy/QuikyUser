import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';

class Restaurant extends Equatable {
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

  Restaurant({
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
  });

  @override
  List<Object> get props => [
        id,
        offers,
        employeeId,
        title,
        mobile,
        gst,
        tinTan,
        typeGoods,
        delivery,
        customer,
        popularBrand,
        brandLogo,
        profilePicture,
        fssai,
        storeSubType,
        status,
        option,
        totalReviews,
        avgRating,
        coordinate,
        address,
        recommendationCount,
        minimumCostTwo,
        avgDeliveryTime,
        active,
        inOrder,
        bulkOrder,
        opening,
        closing,
        highlightStatus,
        featuredBrand,
        vendor,
        storeSubType,
        commisionPercentage,
        user,
        city,
        zone,
        vendorLocation,
      ];
}

import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';

class RatingStarIdicator extends StatelessWidget {
  const RatingStarIdicator({
    Key key,
    this.rating,
    this.totalReview,
  }) : super(key: key);
  final String rating;
  final String totalReview;

  IconData ratingShow(int limit) {
    double ratingD = double.tryParse(rating)??0;
    if (ratingD >= limit) {
      return Icons.star;
    } else if (ratingD > limit - 1) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          ratingShow(1),
          size: 15,
          color: primary,
        ),
        Icon(
          ratingShow(2),
          size: 15,
          color: primary,
        ),
        Icon(
          ratingShow(3),
          size: 15,
          color: primary,
        ),
        Icon(
          ratingShow(4),
          size: 15,
          color: primary,
        ),
        Icon(
          ratingShow(5),
          size: 15,
          color: primary,
        ),
        Text(" $rating ", style: Theme.of(context).textTheme.bodyText1),
        Text(" (${totalReview == 'null' ? 0 : totalReview} Reviews) ",
            style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}

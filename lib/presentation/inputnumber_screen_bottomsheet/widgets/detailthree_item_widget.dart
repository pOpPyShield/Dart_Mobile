import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';

// ignore: must_be_immutable
class DetailthreeItemWidget extends StatelessWidget {
  const DetailthreeItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.h,
      padding: EdgeInsets.symmetric(
        horizontal: 30.h,
        vertical: 13.v,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Text(
        "1",
        style: theme.textTheme.titleLarge,
      ),
    );
  }
}

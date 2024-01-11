import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';

// ignore: must_be_immutable
class SlidercontentItemWidget extends StatelessWidget {
  const SlidercontentItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Spread Love Easier",
          style: theme.textTheme.headlineLarge,
        ),
        SizedBox(height: 9.v),
        SizedBox(
          width: 328.h,
          child: Text(
            "If you don't know how to help people in easiest way, now you can do it by donating through HALO",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.labelLargeBluegray200,
          ),
        ),
      ],
    );
  }
}

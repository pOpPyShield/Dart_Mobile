import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';

// ignore: must_be_immutable
class Slidercontent2ItemWidget extends StatelessWidget {
  const Slidercontent2ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Start to help",
          style: theme.textTheme.headlineLarge,
        ),
        SizedBox(height: 9.v),
        SizedBox(
          width: 315.h,
          child: Text(
            "It is easier now to help people in the midst of your busy life by using, HALO your trusted fundraising online apps.",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: CustomTextStyles.labelLargeBluegray200,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';

// ignore: must_be_immutable
class Slidercontent1ItemWidget extends StatelessWidget {
  const Slidercontent1ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Trusted Institution",
          style: theme.textTheme.headlineLarge,
        ),
        SizedBox(height: 12.v),
        SizedBox(
          width: 334.h,
          child: Text(
            "It is normal to feel doubt with fundraising institution. But our institution is overseen bu the financial services authority.",
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

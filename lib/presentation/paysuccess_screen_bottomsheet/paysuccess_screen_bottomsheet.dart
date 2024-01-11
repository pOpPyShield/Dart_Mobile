import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';

class PaysuccessScreenBottomsheet extends StatelessWidget {
  const PaysuccessScreenBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 45.v),
            decoration: AppDecoration.fillWhiteA
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder48),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 11.v),
                  CustomImageView(
                      imagePath: ImageConstant.imgUntitled11,
                      height: 164.adaptSize,
                      width: 164.adaptSize),
                  SizedBox(height: 11.v),
                  Text("Thank You",
                      style: CustomTextStyles.headlineMediumPrimary),
                  SizedBox(height: 21.v),
                  Container(
                      width: 328.h,
                      margin: EdgeInsets.only(left: 26.h, right: 27.h),
                      child: Text(
                          "Your donation has been successful and will be transferred soon to the needy.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.titleSmallOnPrimary_1
                              .copyWith(height: 1.86))),
                  SizedBox(height: 52.v),
                  CustomElevatedButton(
                      text: "Done",
                      onPressed: () {
                        onTapDone(context);
                      })
                ])));
  }

  /// Navigates to the bottomnavigationScreen when the action is triggered.
  onTapDone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bottomnavigationScreen);
  }
}

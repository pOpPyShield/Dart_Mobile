import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/core/models/volunteerActivity.dart';
import 'package:volunteerapp/presentation/inputnumber_screen_bottomsheet/inputnumber_screen_bottomsheet.dart';
import 'package:volunteerapp/presentation/paymethod_screen/paymethod_screen.dart';
import 'package:volunteerapp/presentation/paysuccess_screen_bottomsheet/paysuccess_screen_bottomsheet.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';
import 'package:volunteerapp/widgets/custom_icon_button.dart';

class DetailScreen extends StatelessWidget {
  final VolunteerActivity activity;

  const DetailScreen({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: theme.colorScheme.onPrimary.withOpacity(1),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _buildImageStack(context),
                  SizedBox(height: 38.v),
                  _buildEducationRow(context),
                  SizedBox(height: 22.v),
                  Container(
                      width: 364.h,
                      margin: EdgeInsets.only(left: 16.h, right: 33.h),
                      child: Text(activity.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.titleLargeBlack900)),
                  SizedBox(height: 21.v),
                  Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Text("By: HT Organization",
                          style: CustomTextStyles.labelLargeGray400)),
                  SizedBox(height: 22.v),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          child: Container(
                              height: 8.v,
                              width: 382.h,
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(4.h)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.h),
                                  child: LinearProgressIndicator(
                                      value: 0.26,
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          appTheme.blueGray100)))))),
                  SizedBox(height: 19.v),
                  _buildPriceRow(context),
                  SizedBox(height: 38.v),
                  Container(
                      width: 368.h,
                      margin: EdgeInsets.only(left: 16.h, right: 29.h),
                      child: Text(
                          "Make learning possible for students of all ages, from pre-school to graduate school. They also provide otger educational servuces and opportunities that help make schools more effective and more accessible to students of all backgrounds.",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.titleSmallGray400
                              .copyWith(height: 1.86))),
                  SizedBox(height: 62.v),
                  CustomElevatedButton(
                    height: 36.v,
                    width: 84.h,
                    text: "Donate",
                    margin: EdgeInsets.only(right: 23.h),
                    buttonStyle: CustomButtonStyles.fillLightGreenTL8,
                    buttonTextStyle: CustomTextStyles.labelLargeBlack900Bold,
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymethodScreen(activity: activity),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  Widget _buildImageStack(BuildContext context) {
    return SizedBox(
        height: 348.v,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.topLeft, children: [
          CustomImageView(
              imagePath: activity.image,
              height: 348.v,
              width: 414.h,
              radius: BorderRadius.vertical(bottom: Radius.circular(32.h)),
              alignment: Alignment.center),
          Padding(
              padding: EdgeInsets.only(left: 16.h, top: 28.v),
              child: CustomIconButton(
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  padding: EdgeInsets.all(4.h),
                  alignment: Alignment.topLeft,
                  onTap: () {
                    onTapBtnVector(context);
                  },
                  child: CustomImageView(
                      imagePath: ImageConstant.imgVectorBlack900)))
        ]));
  }

  /// Section Widget
  Widget _buildEducationRow(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomElevatedButton(
                      height: 36.v,
                      width: 84.h,
                      text: "Education",
                      margin: EdgeInsets.only(bottom: 2.v),
                      buttonTextStyle: CustomTextStyles.titleSmallOnPrimary),
                  Padding(
                      padding: EdgeInsets.only(top: 20.v),
                      child: Text("40 Days left",
                          style: CustomTextStyles.titleSmallLightgreen600))
                ])));
  }

  /// Section Widget
  Widget _buildPriceRow(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Current: ",
                            style: CustomTextStyles.labelLargeGray400Medium),
                        TextSpan(
                            text: "50.4646", style: theme.textTheme.titleMedium)
                      ]),
                      textAlign: TextAlign.left),
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Target: ",
                            style: CustomTextStyles.labelLargeGray400Medium),
                        TextSpan(
                            text: "99.4646", style: theme.textTheme.titleMedium)
                      ]),
                      textAlign: TextAlign.left)
                ])));
  }

  /// Navigates back to the previous screen.
  onTapBtnVector(BuildContext context) {
    Navigator.pop(context);
  }
}

import '../onbroading_screen_one_screen/widgets/slidercontent_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class OnbroadingScreenOneScreen extends StatelessWidget {
  OnbroadingScreenOneScreen({Key? key}) : super(key: key);

  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 38.h, vertical: 24.v),
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgLogo,
                      height: 110.v,
                      width: 150.h,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 78.h)),
                  SizedBox(height: 50.v),
                  CustomImageView(
                      imagePath: ImageConstant.imgPicture,
                      height: 254.adaptSize,
                      width: 254.adaptSize,
                      radius: BorderRadius.circular(30.h)),
                  SizedBox(height: 81.v),
                  _buildSliderContent(context),
                  SizedBox(height: 40.v),
                  SizedBox(
                      height: 8.v,
                      child: AnimatedSmoothIndicator(
                          activeIndex: sliderIndex,
                          count: 1,
                          axisDirection: Axis.horizontal,
                          effect: ScrollingDotsEffect(
                              spacing: 7,
                              activeDotColor:
                                  theme.colorScheme.onPrimary.withOpacity(1),
                              dotColor: appTheme.blueGray100.withOpacity(0.48),
                              dotHeight: 8.v,
                              dotWidth: 8.h))),
                  SizedBox(height: 96.v),
                  _buildSkipButtons(context),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  Widget _buildSliderContent(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 82.v,
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  sliderIndex = index;
                }),
            itemCount: 1,
            itemBuilder: (context, index, realIndex) {
              return SlidercontentItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildSkipButtons(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      CustomElevatedButton(
          height: 37.v,
          width: 68.h,
          text: "Skip",
          margin: EdgeInsets.only(bottom: 2.v),
          buttonStyle: CustomButtonStyles.fillOnPrimary,
          buttonTextStyle: CustomTextStyles.labelLargeBluegray400,
          onPressed: () {
            onTapSkip(context);
          }),
      CustomElevatedButton(
          height: 40.v,
          width: 68.h,
          text: "Next",
          buttonStyle: CustomButtonStyles.fillLightGreen,
          buttonTextStyle: CustomTextStyles.labelLargeOnPrimary,
          onPressed: () {
            onTapNext(context);
          })
    ]);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapSkip(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }

  /// Navigates to the onbroadingScreenTwoScreen when the action is triggered.
  onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.onbroadingScreenTwoScreen);
  }
}

import '../onbroading_screen/widgets/slidercontent2_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';

class OnbroadingScreen extends StatelessWidget {
  OnbroadingScreen({Key? key})
      : super(
          key: key,
        );

  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 36.h,
            vertical: 24.v,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLogo,
                height: 110.v,
                width: 150.h,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 80.h),
              ),
              SizedBox(height: 50.v),
              CustomImageView(
                imagePath: ImageConstant.imgVector2,
                height: 254.adaptSize,
                width: 254.adaptSize,
                radius: BorderRadius.circular(
                  30.h,
                ),
              ),
              SizedBox(height: 82.v),
              _buildSliderContent(context),
              SizedBox(height: 25.v),
              SizedBox(
                height: 8.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: sliderIndex,
                  count: 1,
                  axisDirection: Axis.horizontal,
                  effect: ScrollingDotsEffect(
                    spacing: 8,
                    activeDotColor: theme.colorScheme.onPrimary.withOpacity(1),
                    dotColor: appTheme.blueGray100.withOpacity(0.52),
                    dotHeight: 8.v,
                    dotWidth: 8.h,
                  ),
                ),
              ),
              SizedBox(height: 96.v),
              _buildSignUpStack(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSliderContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.h),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 97.v,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          scrollDirection: Axis.horizontal,
          onPageChanged: (
            index,
            reason,
          ) {
            sliderIndex = index;
          },
        ),
        itemCount: 1,
        itemBuilder: (context, index, realIndex) {
          return Slidercontent2ItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildSignUpStack(BuildContext context) {
    return SizedBox(
      height: 61.v,
      width: 340.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          CustomElevatedButton(
            height: 60.v,
            width: 157.h,
            text: "Sign Up",
            buttonStyle: CustomButtonStyles.fillBlueGray,
            buttonTextStyle: CustomTextStyles.titleLargeBluegray400,
            alignment: Alignment.centerRight,
          ),
          CustomElevatedButton(
            height: 60.v,
            width: 209.h,
            text: "Login",
            buttonStyle: CustomButtonStyles.fillLightGreenTL12,
            buttonTextStyle: CustomTextStyles.titleLargeOnPrimary,
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }
}

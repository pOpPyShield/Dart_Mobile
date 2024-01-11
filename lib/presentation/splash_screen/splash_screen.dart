import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLogo1,
                height: 92.v,
                width: 217.h,
              ),
              SizedBox(height: 13.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Easiest way to",
                      style: CustomTextStyles.titleMediumOnPrimary_1,
                    ),
                    TextSpan(
                      text: " ",
                    ),
                    TextSpan(
                      text: "help others",
                      style: CustomTextStyles.titleMediumLightgreen700,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}

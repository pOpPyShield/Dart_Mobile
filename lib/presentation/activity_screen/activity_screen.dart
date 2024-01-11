import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.v),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.h,
                  vertical: 53.v,
                ),
                decoration: AppDecoration.fillWhiteA.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderBL48,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Activity",
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                    SizedBox(height: 29.v),
                    CustomElevatedButton(
                      text: "Your Donate",
                      buttonStyle: CustomButtonStyles.fillOnPrimaryTL8,
                      buttonTextStyle: CustomTextStyles.headlineMediumPrimary28,
                    ),
                    SizedBox(height: 25.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dec 03, 2023",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    SizedBox(height: 15.v),
                    _buildHtOrganizationRow(context),
                    SizedBox(height: 7.v),
                    _buildWhoRow(context),
                    SizedBox(height: 36.v),
                    _buildDecRow(context),
                    SizedBox(height: 36.v),
                    _buildDecRow(context),
                    SizedBox(height: 36.v),
                    _buildDecRow(context),
                    SizedBox(height: 36.v),
                    _buildDecRow(context),
                    SizedBox(height: 36.v),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHtOrganizationRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "HT Organization",
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 6.v),
            SizedBox(
              width: 232.h,
              child: Text(
                "Build Tomorrow's Leaders: Volunteer in Education Today!",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.labelLargeGray500_1,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 11.v,
            bottom: 25.v,
          ),
          child: Text(
            "25.25",
            style: CustomTextStyles.titleMediumPrimary,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildWhoRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WHO",
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 7.v),
            SizedBox(
              width: 212.h,
              child: Text(
                "Be part of covid-19 vaccine research development",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.labelLargeGray500_1,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 12.v,
            bottom: 25.v,
          ),
          child: Text(
            "1000.25",
            style: CustomTextStyles.titleMediumPrimary,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildDecRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dec 05, 2023",
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 7.v),
            Text(
              "HT Organization",
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 10.v),
            SizedBox(
              width: 232.h,
              child: Text(
                "Build Tomorrow's Leaders: Volunteer in Education Today!",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.labelLargeGray500_1,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 40.v,
            bottom: 25.v,
          ),
          child: Text(
            "23.75",
            style: CustomTextStyles.titleMediumPrimary,
          ),
        ),
      ],
    );
  }
}

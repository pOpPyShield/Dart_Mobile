import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/widgets/app_bar/appbar_leading_image.dart';
import 'package:volunteerapp/widgets/app_bar/appbar_title.dart';
import 'package:volunteerapp/widgets/app_bar/custom_app_bar.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';
import 'package:volunteerapp/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class EditprofileScreen extends StatelessWidget {
  EditprofileScreen({Key? key}) : super(key: key);

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
                child: Column(children: [
              SizedBox(height: 5.v),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 24.v),
                  decoration: AppDecoration.fillWhiteA.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderBL48),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    _buildAppBar(context),
                    SizedBox(height: 46.v),
                    CustomImageView(
                        imagePath: ImageConstant.imgRectangle25,
                        height: 112.adaptSize,
                        width: 112.adaptSize,
                        radius: BorderRadius.circular(8.h)),
                    SizedBox(height: 39.v),
                    _buildFirstName(context),
                    SizedBox(height: 67.v),
                    _buildFifty(context),
                    SizedBox(height: 67.v),
                    _buildFiftyThree(context),
                    SizedBox(height: 84.v),
                    CustomElevatedButton(
                        text: "Save Change",
                        margin: EdgeInsets.symmetric(horizontal: 16.h)),
                    SizedBox(height: 23.v)
                  ]))
            ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 25.v,
        leadingWidth: 23.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgVectorBlack900,
            margin: EdgeInsets.only(left: 16.h, top: 7.v, bottom: 5.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Edit Profile"));
  }

  /// Section Widget
  Widget _buildFiftyOne(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(right: 11.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("First Name", style: theme.textTheme.titleSmall),
              SizedBox(height: 3.v),
              CustomTextFormField(
                  width: 180.h,
                  controller: firstNameController,
                  borderDecoration: TextFormFieldStyleHelper.fillGrayTL8,
                  fillColor: appTheme.gray10003)
            ])));
  }

  /// Section Widget
  Widget _buildFiftyTwo(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: 11.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Last Name", style: theme.textTheme.titleSmall),
              SizedBox(height: 2.v),
              CustomTextFormField(
                  width: 180.h,
                  controller: lastNameController,
                  borderDecoration: TextFormFieldStyleHelper.fillGrayTL8,
                  fillColor: appTheme.gray10003)
            ])));
  }

  /// Section Widget
  Widget _buildFirstName(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildFiftyOne(context), _buildFiftyTwo(context)]));
  }

  /// Section Widget
  Widget _buildFifty(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Email", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: emailController,
              borderDecoration: TextFormFieldStyleHelper.fillGrayTL8,
              fillColor: appTheme.gray10003)
        ]));
  }

  /// Section Widget
  Widget _buildFiftyThree(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Phone Number", style: theme.textTheme.titleSmall),
          SizedBox(height: 3.v),
          CustomTextFormField(
              controller: phoneNumberController,
              textInputAction: TextInputAction.done,
              borderDecoration: TextFormFieldStyleHelper.fillGrayTL8,
              fillColor: appTheme.gray10003)
        ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}

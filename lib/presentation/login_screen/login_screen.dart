import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/core/services/api_login.dart';
import 'package:volunteerapp/presentation/bottomnavigation_screen/bottomnavigation_screen.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';
import 'package:volunteerapp/widgets/custom_icon_button.dart';
import 'package:volunteerapp/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.v),
                    child: Column(children: [
                      CustomImageView(
                          imagePath: ImageConstant.imgLogo,
                          height: 110.v,
                          width: 150.h,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 100.h)),
                      SizedBox(height: 6.v),
                      SizedBox(
                          height: 485.v,
                          width: 382.h,
                          child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                _buildSignInOptions(context),
                                _buildSignInForm(context)
                              ])),
                      SizedBox(height: 33.v),
                      Text("Or Login With",
                          style: CustomTextStyles.labelLargePrimaryContainer),
                      SizedBox(height: 23.v),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconButton(
                                height: 54.adaptSize,
                                width: 54.adaptSize,
                                padding: EdgeInsets.all(11.h),
                                child: CustomImageView(
                                    imagePath: ImageConstant.imgSocialIcons)),
                            Padding(
                                padding: EdgeInsets.only(left: 18.h),
                                child: CustomIconButton(
                                    height: 54.adaptSize,
                                    width: 54.adaptSize,
                                    padding: EdgeInsets.all(11.h),
                                    child: CustomImageView(
                                        imagePath: ImageConstant
                                            .imgSocialIconsBlueA700))),
                            Padding(
                                padding: EdgeInsets.only(left: 18.h),
                                child: CustomIconButton(
                                    height: 54.adaptSize,
                                    width: 54.adaptSize,
                                    padding: EdgeInsets.all(11.h),
                                    child: CustomImageView(
                                        imagePath: ImageConstant
                                            .imgSocialIconsBlack900)))
                          ]),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Section Widget
  Widget _buildSignInOptions(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(left: 16.h, top: 229.v, right: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 39.h, vertical: 13.v),
            decoration: AppDecoration.fillWhiteA
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Padding(
                  padding: EdgeInsets.only(top: 213.v),
                  child: Text("Don’t have account?",
                      style: CustomTextStyles.labelLargePrimaryContainer)),
              GestureDetector(
                  onTap: () {
                    onTapTxtCreateNewAccount(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.h, top: 213.v),
                      child: Text("Create new account",
                          style: CustomTextStyles.labelLargeBlack900)))
            ])));
  }

  /// Section Widget
  Widget _buildSignInForm(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 24.v),
            decoration: AppDecoration.outlineBlack
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder27),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 2.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          width: 162.h,
                          child: Text("Sign in\nto continute",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineMedium))),
                  SizedBox(height: 40.v),
                  CustomTextFormField(
                    controller: phoneController,
                    hintText: "Username or email",
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 8.v),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: "Password",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 20.v),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 19.h),
                          child: Text("Forgot password?",
                              style: CustomTextStyles
                                  .titleSmallBlack900SemiBold))),
                  SizedBox(height: 85.v),
                  CustomElevatedButton(
                      text: "Login",
                      onPressed: () {
                        APILogin apiLogin = APILogin();
                        apiLogin.login(phoneController.text,
                            passwordController.text, context);
                      },
                      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700)
                ])));
  }

  /// Navigates to the signupScreen when the action is triggered.
  onTapTxtCreateNewAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signupScreen);
  }
}

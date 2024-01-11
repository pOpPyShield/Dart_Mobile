import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/core/services/api_resgister.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';
import 'package:volunteerapp/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                              imagePath: ImageConstant.imgLogo,
                              height: 110.v,
                              width: 150.h,
                              margin: EdgeInsets.only(left: 100.h)),
                          SizedBox(height: 10.v),
                          SizedBox(
                              height: 570.v,
                              width: 382.h,
                              child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    _buildAlreadyHaveAccountRow(context),
                                    _buildCreateNewAccountColumn(context)
                                  ])),
                          SizedBox(height: 5.v)
                        ])))));
  }

  /// Section Widget
  Widget _buildAlreadyHaveAccountRow(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(left: 16.h, top: 227.v, right: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 78.h, vertical: 15.v),
            decoration: AppDecoration.fillWhiteA
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 253.v),
                      child: Text("Already have account?  ",
                          style: CustomTextStyles.labelLargePrimaryContainer)),
                  GestureDetector(
                      onTap: () {
                        onTapTxtSignIn(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(left: 4.h, top: 253.v),
                          child: Text("Sign in",
                              style: CustomTextStyles.labelLargeBlack900)))
                ])));
  }

  /// Section Widget
  Widget _buildCreateNewAccountColumn(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 28.v),
            decoration: AppDecoration.outlineBlack
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder27),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      width: 155.h,
                      child: Text("Create New Account",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineMedium))),
              SizedBox(height: 35.v),
              CustomTextFormField(
                  controller: userNameController, hintText: "Username"),
              SizedBox(height: 8.v),
              CustomTextFormField(
                  controller: phoneController,
                  hintText: "Phone or email",
                  textInputType: TextInputType.emailAddress),
              SizedBox(height: 8.v),
              CustomTextFormField(
                  controller: passwordController,
                  hintText: "Password",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true),
              SizedBox(height: 8.v),
              CustomTextFormField(
                  controller: password2Controller,
                  hintText: "Password Again",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true),
              SizedBox(height: 84.v),
              CustomElevatedButton(
                text: "Create Account",
                buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                onPressed: () {
                  APIRegister remoteRegister = APIRegister();
                  String textUsername = userNameController.text;
                  String txtphone = phoneController.text;
                  String password1 = passwordController.text;
                  String password2 = password2Controller.text;
                  Map<String, dynamic> registrationData = {
                    "username": textUsername,
                    "email": txtphone,
                    "password1": password1,
                    "password2": password1,
                  };
                  remoteRegister.register(registrationData, context);
                },
              )
            ])));
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtSignIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/core/models/user.dart';
import 'package:volunteerapp/core/models/volunteerActivity.dart';
import 'package:volunteerapp/core/services/api_user.dart';
import 'package:volunteerapp/presentation/editprofile_screen/editprofile_screen.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';
import 'package:volunteerapp/widgets/custom_icon_button.dart';

class ProfileScreen extends StatefulWidget {
  late VoidCallback? onLogoutPressed;

  ProfileScreen({Key? key, this.onLogoutPressed}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late VoidCallback? onLogoutPressed = widget.onLogoutPressed;
  late User user = User(
      username: '', firstname: '', lastname: '', email: '', phonenumber: '');

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final data = await APIUser.getUserData(token!);

      setState(() {
        user = User.fromJson(data);
      });
    } catch (error) {
      print('Error fetching user data: $error');
      // Handle other errors as needed
    }
  }

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
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 48.v),
                decoration: AppDecoration.fillWhiteA.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderBL48,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.v),
                    _buildProfileSection(context),
                    SizedBox(height: 57.v),
                    Text("Email address", style: theme.textTheme.titleSmall),
                    SizedBox(height: 4.v),
                    Text(user.email, style: theme.textTheme.titleMedium),
                    SizedBox(height: 46.v),
                    Text("Account ID", style: theme.textTheme.titleSmall),
                    SizedBox(height: 3.v),
                    Text("18-9275665999", style: theme.textTheme.titleMedium),
                    SizedBox(height: 47.v),
                    _buildPaymentMethodSection(context),
                    SizedBox(height: 95.v),
                    _buildFortyNineSection(context),
                    SizedBox(height: 43.v),
                    CustomElevatedButton(
                      text: "Logout",
                      onPressed: () {
                        _removeToken();
                        onLogoutPressed?.call();
                      },
                      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Profile", style: theme.textTheme.headlineSmall),
        SizedBox(height: 27.v),
        Padding(
          padding: EdgeInsets.only(left: 5.h),
          child: Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle25,
                height: 76.adaptSize,
                width: 76.adaptSize,
                radius: BorderRadius.circular(8.h),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.h, top: 18.v, bottom: 12.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.username, style: theme.textTheme.titleMedium),
                    SizedBox(height: 6.v),
                    Text("+84 941979240", style: theme.textTheme.titleSmall),
                  ],
                ),
              ),
              Spacer(),
              CustomIconButton(
                height: 16.adaptSize,
                width: 16.adaptSize,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditprofileScreen(),
                    ),
                  );
                },
                child: CustomImageView(
                  imagePath: ImageConstant.imgArrowRight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Widget _buildPaymentMethodSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 6.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Payment Method", style: theme.textTheme.titleSmall),
              SizedBox(height: 8.v),
              SizedBox(
                width: 167.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage3328x62,
                      height: 28.v,
                      width: 62.h,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgImage35,
                      height: 22.v,
                      width: 84.h,
                      margin: EdgeInsets.only(bottom: 4.v),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgImage36,
          height: 42.adaptSize,
          width: 42.adaptSize,
          margin: EdgeInsets.only(left: 21.h, top: 20.v),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 18.v),
          child: CustomIconButton(
            height: 16.adaptSize,
            width: 16.adaptSize,
            child: CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFortyNineSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Version", style: theme.textTheme.titleSmall),
        SizedBox(height: 3.v),
        Text("1.01.2", style: theme.textTheme.titleMedium),
      ],
    );
  }
}

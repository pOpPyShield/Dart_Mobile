import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/presentation/tabview_page/tabview_page.dart';
import 'package:volunteerapp/widgets/app_bar/appbar_subtitle.dart';
import 'package:volunteerapp/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:volunteerapp/widgets/app_bar/appbar_trailing_iconbutton.dart';
import 'package:volunteerapp/widgets/app_bar/custom_app_bar.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key})
      : super(
          key: key,
        );

  @override
  HomeScreenPageState createState() => HomeScreenPageState();
}

class HomeScreenPageState extends State<HomeScreenPage>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary.withOpacity(1),
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 11.v),
              _buildBanner(context),
              SizedBox(height: 29.v),
              _buildHomeUrgentlyNeeded(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Column(
          children: [
            AppbarSubtitleOne(
              text: "Hello!",
              margin: EdgeInsets.only(right: 50.h),
            ),
            SizedBox(height: 3.v),
            AppbarSubtitle(
              text: "MinhThien",
            ),
          ],
        ),
      ),
      actions: [
        AppbarTrailingIconbutton(
          imagePath: ImageConstant.imgVector,
          margin: EdgeInsets.fromLTRB(16.h, 9.v, 16.h, 14.v),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildBanner(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(
        horizontal: 82.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 214.h,
            child: Text(
              "Give hope, change lives \nsupport charity now",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.titleMediumOnPrimaryBold,
            ),
          ),
          SizedBox(height: 5.v),
          CustomElevatedButton(
            height: 30.v,
            width: 78.h,
            text: "Donate",
            buttonStyle: CustomButtonStyles.fillLightGreenTL8,
            buttonTextStyle: CustomTextStyles.labelLargeOnPrimaryBold,
          ),
          SizedBox(height: 7.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHomeUrgentlyNeeded(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 14.h),
          child: Text(
            "Urgently Needed",
            style: CustomTextStyles.titleMedium18,
          ),
        ),
        SizedBox(height: 38.v),
        Column(
          children: [
            SizedBox(
              height: 36.v,
              width: 382.h,
              child: TabBar(
                controller: tabviewController,
                labelPadding: EdgeInsets.zero,
                labelColor: theme.colorScheme.onPrimary.withOpacity(1),
                labelStyle: TextStyle(
                  fontSize: 14.fSize,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelColor: appTheme.gray500,
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.fSize,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
                indicator: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(
                    8.h,
                  ),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      "Education",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Health",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Animal",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Enviroment",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 485.v,
              child: TabBarView(
                controller: tabviewController,
                children: [
                  TabviewPage(tags: ["Education"]),
                  TabviewPage(tags: ["Health"]),
                  TabviewPage(tags: ["Animal"]),
                  TabviewPage(tags: ["Enviroments"]),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

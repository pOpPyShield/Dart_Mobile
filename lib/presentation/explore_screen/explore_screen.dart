import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/widgets/custom_search_view.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 5.v),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 53.v,
                  ),
                  decoration: AppDecoration.fillWhiteA.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderBL48,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildExploreSection(context),
                      SizedBox(
                        height: 24.v,
                      ),
                      // Spacer(),
                      Text(
                        "Finding Help to Take Their Next Steps",
                        style: theme.textTheme.titleMedium,
                      ),

                      SizedBox(height: 10.v),
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgEllipse10,
                            height: 44.adaptSize,
                            width: 44.adaptSize,
                            radius: BorderRadius.circular(
                              22.h,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16.h,
                              top: 3.v,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "HT Organization",
                                  style: CustomTextStyles.titleSmallBlack900,
                                ),
                                SizedBox(height: 3.v),
                                Text(
                                  "Dec 03, 2023",
                                  style: CustomTextStyles.titleSmallGray400_1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60.v),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildExploreSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Explore",
          style: theme.textTheme.headlineSmall,
        ),
        SizedBox(height: 25.v),
        CustomSearchView(
          controller: searchController,
          hintText: "Donate for ...",
        ),
      ],
    );
  }
}

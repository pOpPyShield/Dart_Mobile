import '../inputnumber_screen_bottomsheet/widgets/detailthree_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';

class InputnumberScreenBottomsheet extends StatelessWidget {
  const InputnumberScreenBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 27.v),
            decoration: AppDecoration.fillWhiteA
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder48),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 101.h),
                      child: Text("", style: theme.textTheme.titleLarge))),
              Text("0.00", style: theme.textTheme.displayMedium),
              SizedBox(height: 3.v),
              Divider(color: appTheme.gray10003, indent: 39.h, endIndent: 39.h),
              SizedBox(height: 14.v),
              _buildDetailThree(context),
              SizedBox(height: 30.v),
              CustomElevatedButton(
                  height: 52.v,
                  text: "Donate",
                  buttonTextStyle: CustomTextStyles.titleMediumOnPrimaryBold_1,
                  onPressed: () {
                    onTapDonate(context);
                  }),
              SizedBox(height: 11.v)
            ])));
  }

  /// Section Widget
  Widget _buildDetailThree(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 4.h),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 53.v,
                crossAxisCount: 3,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 15.h),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 13,
            itemBuilder: (context, index) {
              return DetailthreeItemWidget();
            }));
  }

  /// Navigates to the paymethodScreen when the action is triggered.
  onTapDonate(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paymethodScreen);
  }
}

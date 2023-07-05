import 'package:admin_app/ui/components/custom_button.dart';
import 'package:admin_app/ui/screens/user_online_reports/user_online_report.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/model/users_model.dart';
import 'package:admin_app/shared/helper/mangers/colors.dart';
import 'package:admin_app/shared/helper/mangers/constants.dart';
import 'package:admin_app/shared/helper/mangers/size_config.dart';
import 'package:admin_app/shared/helper/methods.dart';
import 'package:admin_app/ui/components/app_text.dart';
import 'package:admin_app/ui/screens/map_screen/map_screen.dart';
import 'package:admin_app/ui/screens/user_report/user_report_screen.dart';
import '../../../../layout/cubit/main_cubit.dart';

class UserDesign extends StatelessWidget {
  UserModel userModel;
  MainCubit cubit;

  UserDesign(this.userModel, this.cubit);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, UserOnlineReport(userModel.id ?? ""));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: ColorsManger.darkPrimary)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(10),
              vertical: getProportionateScreenHeight(5)),
          child: Column(
            children: [
              Row(
                children: [
/*
                  Container(
                    height: getProportionateScreenHeight(120),
                    width: getProportionateScreenHeight(120),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: userModel.image == ConstantsManger.DEFULT
                              ? AssetImage("assets/images/defult_image.png")
                              : NetworkImage(userModel.image!)
                                  as ImageProvider),
                    ),
                  ),
*/
                  CircleAvatar(
                    backgroundImage: userModel.image == ConstantsManger.DEFULT
                        ? AssetImage("assets/images/defult_image.png")
                        : NetworkImage(userModel.image!) as ImageProvider,
                    backgroundColor: Colors.white,
                    radius: SizeConfigManger.bodyHeight * .06,
                  ),
                  SizedBox(width: getProportionateScreenHeight(10)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              AppText(
                                  text: userModel.username ?? "",
                                  textSize: 22,
                                  color: userModel.isActive ==true ?Colors.black :Colors.red ,

                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      AppText(text: userModel.phone ?? ""),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: getProportionateScreenHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      cubit.setNotification(
                          token: userModel.token ?? "", type: "track");
                      navigateTo(context, MapScreen(userModel.id ?? ""));
                    },
                    child: AppText(
                      text: "Track",
                      color: Colors.blue,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(width: getProportionateScreenHeight(30)),
                  InkWell(
                    onTap: () {
                      navigateTo(context, UserReportScreen(userModel.id ?? ""));
                    },
                    child: AppText(
                      text: "Reports",
                      color: Colors.blue,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(width: getProportionateScreenHeight(30)),
                  InkWell(
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.INFO,
                        body: Column(
                          children: [
                            AppText(
                                text:
                                    "Do you want to ${userModel.isActive == true ? "Ban" : "Active"}  ${userModel.username}? "),
                            SizedBox(
                              height: SizeConfigManger.bodyHeight * .05,
                            ),
                            CustomButton(
                              backgroundColor: userModel.isActive == true
                                  ? Colors.red
                                  : ColorsManger.darkPrimary,
                              press: () {
                                cubit.banOrActiveUser(
                                    state: userModel.isActive ?? false,
                                    id: userModel.id ?? "");
                                Navigator.pop(context);
                              },
                              text:
                                  "${userModel.isActive == true ? "Ban" : "Active"}",
                            )
                          ],
                        ),
                        title: 'This is Ignored',
                        desc: 'This is also Ignored',
                      )..show();
                    },

                    child: AppText(
                      text:
                          "${userModel.isActive == true ? "Ban User" : "Active User"}",
                      color: Colors.blue,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

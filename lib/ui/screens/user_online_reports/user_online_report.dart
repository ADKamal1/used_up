import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app/shared/helper/mangers/size_config.dart';
import 'package:admin_app/ui/components/app_text.dart';
import 'package:admin_app/ui/screens/user_online_reports/cubit/online_cubit.dart';

class UserOnlineReport extends StatelessWidget {
  String uid;

  UserOnlineReport(this.uid);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnlineCubit()..getAllOnline(uid: uid),
      child: BlocConsumer<OnlineCubit, OnlineState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          OnlineCubit cubit = OnlineCubit.get(context);
          return Scaffold(
            body: state is GetAllOnlineLoading
                ? Center(child: CircularProgressIndicator(),)
                : SafeArea(
                    child: cubit.onlineList.isEmpty
                        ? Center(child: AppText(text: "No Data"))
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(16)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                AppText(
                                                    text: "Status", textSize: 25),
                                                AppText(
                                                    text: cubit.onlineList[index]
                                                                .isOnline ==
                                                            true
                                                        ? "Online"
                                                        : "Offline",
                                                    textSize: 25),
                                              ],
                                            ),
                                            SizedBox(
                                                width:
                                                    getProportionateScreenHeight(
                                                        20)),
                                            CircleAvatar(
                                                radius:
                                                    getProportionateScreenHeight(
                                                        15),
                                                backgroundColor: cubit
                                                            .onlineList[index]
                                                            .isOnline ==
                                                        true
                                                    ? Colors.green
                                                    : Colors.red),
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(20)),
                                        AppText(
                                            text:
                                                "time : ${cubit.onlineList[index].time}",
                                            textSize: 25),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                height: getProportionateScreenHeight(10)),
                            itemCount: cubit.onlineList.length)),
          );
        },
      ),
    );
  }
}

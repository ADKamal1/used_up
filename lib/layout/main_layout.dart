import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app/layout/cubit/main_cubit.dart';
import 'package:admin_app/shared/helper/icon_broken.dart';
import 'package:admin_app/ui/components/custom_text_form_field.dart';
import 'package:admin_app/ui/screens/users_screen/components/user_design.dart';
import '../shared/helper/mangers/size_config.dart';

class MainLayout extends StatelessWidget {
  var searchScreen = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..getUsers(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return cubit.isSearch
              ? WillPopScope(
                  onWillPop: () {
                    cubit.getSearchScreen();
                    return Future.value(false);
                  },
                  child: Scaffold(
                    body: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(10)),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              hintText: "Search",
                              type: TextInputType.text,
                              onChange: (String? value) {
                                if (value!.isNotEmpty) {
                                  MainCubit.get(context)
                                      .serachQuery(query: value.toLowerCase() as String);
                                }
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) => UserDesign(
                                        MainCubit.get(context)
                                            .userSearchList[index],
                                        MainCubit.get(context)),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10)),
                                    itemCount: MainCubit.get(context)
                                        .userSearchList
                                        .length))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  appBar: cubit.currentIndex == 0
                      ? AppBar(
                          actions: [
                            IconButton(
                                onPressed: () => cubit.getSearchScreen(),
                                icon: Icon(IconBroken.Search))
                          ],
                        )
                      : null,
                  body: cubit.screens[cubit.currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    onTap: (index) {
                      cubit.changeIndexNumber(index);
                    },
                    items: cubit.navList,
                    currentIndex: cubit.currentIndex,
                  ),
                );
        },
      ),
    );
  }
}

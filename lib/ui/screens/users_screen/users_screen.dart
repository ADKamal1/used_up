import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app/layout/cubit/main_cubit.dart';
import 'package:admin_app/shared/helper/mangers/size_config.dart';

import 'components/user_design.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainCubit cubit = MainCubit.get(context)..getUsers();
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return cubit.usersList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        UserDesign(cubit.usersList[index], cubit),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: getProportionateScreenHeight(10)),
                    itemCount: cubit.usersList.length),
              )
            : Center(

        );
      },
    );
  }
}

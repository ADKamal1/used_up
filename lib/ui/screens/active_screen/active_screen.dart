import 'package:admin_app/layout/cubit/main_cubit.dart';
import 'package:admin_app/shared/helper/mangers/size_config.dart';
import 'package:admin_app/ui/screens/users_screen/components/user_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveUsersScreen extends StatelessWidget {
  const ActiveUsersScreen({super.key});
 @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return cubit.userActiveList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                    itemBuilder: (context, index) =>UserDesign(cubit.userActiveList[index], cubit),
                    separatorBuilder: (context, index) =>SizedBox(height: getProportionateScreenHeight(10)),
                    itemCount: cubit.userActiveList.length),
              )
            : Center(
          child: CircularProgressIndicator(color: Colors.red,strokeWidth: 2),
        );
      },
    );
  }
}

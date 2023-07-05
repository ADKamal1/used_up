import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app/layout/cubit/main_cubit.dart';
import 'package:admin_app/shared/helper/mangers/size_config.dart';
import 'package:admin_app/ui/components/custom_button.dart';
import 'package:admin_app/ui/components/custom_text_form_field.dart';
import 'package:tbib_toast/tbib_toast.dart';

class AddScreen extends StatelessWidget {
  var password = TextEditingController();
  var username = TextEditingController();
  var phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is CreateUserError) {
          Toast.show(state.error, context,
              backgroundColor: Colors.red, duration: 3);
        } else if (state is CreateUserSucess) {
          Toast.show("Success Created Account", context,
              backgroundColor: Colors.green, duration: 3);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(20)),
              child: Column(
                children: [
                  SizedBox(height: SizeConfigManger.bodyHeight*.1),
                  CustomTextFormField(
                    controller: username,
                    prefixIcon: 'assets/icons/User.svg',
                    type: TextInputType.text,
                    lableText: 'Customer Name',
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Customer is Required";
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  CustomTextFormField(
                    controller: password,
                    prefixIcon: 'assets/icons/Lock.svg',
                    type: TextInputType.visiblePassword,
                    lableText: 'password',
                    isPassword: true,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Password is Required";
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  CustomTextFormField(
                    controller: phone,
                    prefixIcon: 'assets/icons/Phone.svg',
                    type: TextInputType.phone,
                    lableText: 'Phone number',
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "Phone number is Required";
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(50)),
                  state is CreateUserLoading
                      ? LinearProgressIndicator()
                      : Center(),
                  SizedBox(height: getProportionateScreenHeight(50)),
                  CustomButton(
                      press: () {
                        MainCubit.get(context).createUser(
                            password: password.text,
                            username: username.text,
                            phone: phone.text);
                      },
                      text: "Create User",
                      height: 65),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

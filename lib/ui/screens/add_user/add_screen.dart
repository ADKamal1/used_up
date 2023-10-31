import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app/layout/cubit/main_cubit.dart';
import 'package:admin_app/shared/helper/mangers/size_config.dart';
import 'package:admin_app/ui/components/custom_button.dart';
import 'package:admin_app/ui/components/custom_text_form_field.dart';
import 'package:tbib_toast/tbib_toast.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var password = TextEditingController();

  var username = TextEditingController();

  var phone = TextEditingController();

  String?  selectedGroup;

  String?  selectedSupGroup;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    MainCubit cubit = MainCubit.get(context);
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
        cubit.getAllGroups();
        cubit.getSubGroups();
        cubit.getAllType();
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
                    lableText: 'User Name',
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "User Name is Required";
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
                  DropdownButton<String>(
                    items: cubit.groupsList
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:(value.toString() =='Ausis')? Text('Isis'): Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGroup = value;
                      });
                    },
                    value: selectedGroup,

                    hint: Text("Group      "),
                  ),
                  SizedBox(height: getProportionateScreenHeight(50)),

                  DropdownButton<String>(
                    items: cubit.subgroupsList
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSupGroup = value;
                      });
                    },
                    value: selectedSupGroup,

                    hint: Text("Sub Group "),
                  ),
                  SizedBox(height: getProportionateScreenHeight(50)),
                  //
                  // DropdownButton<String>(
                  //   items: cubit.typesList
                  //       .map((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedType = value;
                  //     });
                  //   },
                  //   value: selectedType,
                  //
                  //   hint: Text("Type      "),
                  // ),
                  state is CreateUserLoading
                      ? LinearProgressIndicator()
                      : Center(),
                  SizedBox(height: getProportionateScreenHeight(50)),
                  CustomButton(
                      press: () {
                        if (password == null ||
                            username == null ||
                            phone == null||selectedGroup==null||selectedSupGroup==null) {
                          Toast.show(
                              "complete your selections", context,
                              backgroundColor: Colors.red,
                              duration: 3);
                        }else {
                          MainCubit.get(context).createUser(
                              password: password.text,
                              username: username.text,
                              phone: phone.text,
                              group: selectedGroup ?? '',
                              subgroup: selectedSupGroup ?? '',
                              );
                        }
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

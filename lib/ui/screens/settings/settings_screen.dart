
import 'package:admin_app/create_line/createLine.dart';
import 'package:admin_app/shared/helper/methods.dart';
import 'package:admin_app/ui/components/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/cubit/main_cubit.dart';
import '../../../shared/helper/mangers/colors.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../components/app_text.dart';
import '../../components/custom_card_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfigManger.bodyHeight * 0.30,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: SizeConfigManger.bodyHeight * .22,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            image: DecorationImage(
                                image: AssetImage("assets/images/cover.jpg")
                                    as ImageProvider,
                                fit: BoxFit.cover)),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: SizeConfigManger.bodyHeight * .084,
                          backgroundColor: ColorsManger.darkPrimary,
                        ),
                        CircleAvatar(
                          radius: SizeConfigManger.bodyHeight * .08,
                          backgroundImage:
                              AssetImage("assets/images/defult_image.png"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Center(
                child: AppText(
                  text: "Admin Account",
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  textSize: 28,
                ),
              ),
              CardItem(
                title: "email",
                detials: "admin@yahoo.com",
                prefix: Icons.email,
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              CardItem(
                title: "phone",
                detials: "admin phone number",
                prefix: Icons.phone,
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              CustomButton(
                text: "Update Token",
                press: () async {
                  FirebaseMessaging.instance.getToken().then((token) {
                    FirebaseFirestore.instance
                        .collection("admin")
                        .doc("admin")
                        .update({"token": token,});
                  });
                },
              ),
              SizedBox(height: 20,),
              CustomButton(
                text: "Create Line",
               press: (){
                  navigateTo(context, CreateLineScreen());
               },
              )
            ],
          ),
        );
      },
    );
  }
}

// class _MyWidgetState extends State<MyWidget> {
//   final List<String> items = [];
//   final TextEditingController _controller = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: TextFormField(
//             controller: _controller,
//             decoration: InputDecoration(
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed: _addItem,
//               ),
//               hintText: 'Enter text',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
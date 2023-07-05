import 'package:admin_app/ui/screens/active_screen/active_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app/shared/helper/icon_broken.dart';
import 'package:admin_app/shared/helper/mangers/constants.dart';
import 'package:admin_app/ui/screens/add_points/add_points_screen.dart';
import 'package:admin_app/ui/screens/add_user/add_screen.dart';
import 'package:admin_app/ui/screens/settings/settings_screen.dart';
import 'package:admin_app/ui/screens/users_screen/users_screen.dart';
import 'package:meta/meta.dart';
import '../../model/users_model.dart';
import '../../shared/services/network/dio_helper.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  int currentIndex = 0;

  static MainCubit get(context) => BlocProvider.of(context);

  void changeIndexNumber(int index) {
    this.currentIndex = index;
    if (index == 1) {
      getActiveUsers();
    }
    emit(ChangeBottomNavigationIndex());
  }

  List<UserModel> userSearchList = [];

  void serachQuery({required String query}) {
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .where('searchName',
            isGreaterThanOrEqualTo: query,
            isLessThan: query.substring(0, query.length - 1) +
                String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
        .get()
        .then((value) {
      userSearchList.clear();
      value.docs.forEach((element) {
        userSearchList.add(UserModel.fromJson(element.data()));
      });
      emit(SeachListState());
    });
  }

  List<BottomNavigationBarItem> navList = [
    BottomNavigationBarItem(
        icon: Icon(
          IconBroken.User1,
        ),
        label: "All Users"),
    BottomNavigationBarItem(
        icon: Icon(
          IconBroken.Activity,
        ),
        label: "Active Users"),
    BottomNavigationBarItem(
        icon: Icon(
          IconBroken.Add_User,
        ),
        label: "Create User"),
    BottomNavigationBarItem(
        icon: Icon(
          IconBroken.Setting,
        ),
        label: "Settings"),
  ];

  List<Widget> screens = [
    UsersScreen(),
    ActiveUsersScreen(),
    AddScreen(),
    SettingsScreen()
  ];

  bool isSearch = false;

  void getSearchScreen() {
    this.isSearch = !isSearch;
    emit(GetSeachScreen());
  }

///////////////////////// UsersScreen /////////////////////////

  List<UserModel> usersList = [];

  void getUsers() {
    emit(GetAllUsersLoading());
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .snapshots()
        .listen((event) {
      usersList.clear();
      event.docs.forEach((element) {
        usersList.add(UserModel.fromJson(element.data()));
      });
      print(usersList.length);
      emit(GetAllUsersSuccess());
    });
  }

  void banOrActiveUser({required bool state, required String id}) {
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .doc(id)
        .update({"isActive": !state}).then((value) {
      emit(BanUserSuccess());
    });
  }

  void setNotification({required String token, required String type}) {
    final data = {
      "to": "${token}",
      /*"notification": {
        "body": "",
        "title": "Admin Notification",
        "sound": "default"
      },
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_HIGH",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true,
        },
      },*/
      "data": {
        "type": type,
        "id": "87",
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
      }
    };
    DioHelper().postData(path: 'fcm/send', data: data).then((value) {
        if (value.statusCode == 200) {
        print("Done Sending ");
      }
    });
  }

  //////////////////////// ActiveUsersScreen  ///////////////////////////////////////

  List<UserModel> userActiveList = [];

  void getActiveUsers() {
    emit(GetActiveUsersLoading());
    FirebaseFirestore.instance.collection("Online").get()
      .then((value) {
        userActiveList.clear();
        value.docs.forEach((element) async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(element.id)
              .get()
              .then((user) {
            UserModel userModel = UserModel.fromJson(user.data() ?? {});
            userActiveList.add(userModel);
          });
          emit(GetActiveUsersSuccess());
        });
      });
  }

  //////////////////////// Add User ///////////////////////////////////////

  void createUser(
      {required String username,
      required String password,
      required String phone}) {
    emit(CreateUserLoading());
    UserModel userModel = UserModel(
        username: username,
        ver: 2,
        searchName: username.toLowerCase(),
        isMocking: false,
        image: ConstantsManger.DEFULT,
        isOnline: false,
        password: password,
        phone: phone,
        lon: 0.0,
        lat: 0.0,
        info: ConstantsManger.DEFULT,
        email: ConstantsManger.DEFULT,
        token: ConstantsManger.DEFULT,
        id: ConstantsManger.DEFULT);
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .where("phone", isEqualTo: phone)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        String mail = username.replaceAll(" ", "s").toLowerCase();
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: "${mail}@gmail.com", password: password)
            .then((user) {
          FirebaseFirestore.instance
              .collection(ConstantsManger.USERS)
              .doc(user.user!.uid)
              .set(userModel.toMap())
              .then((val) {
            FirebaseFirestore.instance
                .collection(ConstantsManger.USERS)
                .doc(user.user!.uid)
                .update({"id": user.user!.uid});
          });
          emit(CreateUserSucess());
        }).catchError((error) {
          emit(CreateUserError(error.toString()));
        });
      } else {
        emit(CreateUserError("Phone Already Exits"));
      }
    });
  }
}

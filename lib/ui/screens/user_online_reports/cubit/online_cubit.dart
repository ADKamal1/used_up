import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_app/shared/helper/mangers/constants.dart';
import 'package:admin_app/shared/helper/methods.dart';
import 'package:meta/meta.dart';

import '../../../../model/online_report_model.dart';

part 'online_state.dart';

class OnlineCubit extends Cubit<OnlineState> {
  OnlineCubit() : super(OnlineInitial());

  static OnlineCubit get(context) => BlocProvider.of(context);

  List<OnlineReport> onlineList = [];

  void getAllOnline({required String uid, String? date}) {
    emit(GetAllOnlineLoading());
    FirebaseFirestore.instance
        .collection(ConstantsManger.ONLINEREPORT)
        .where("date", isEqualTo: date ?? formatDate())
        .orderBy("time")
        .get()
        .then((value) {
      onlineList.clear();
      value.docs.forEach((element) {
        OnlineReport report = OnlineReport.fromJson(element.data());
        if (report.id == uid) {
          onlineList.add(report);
        }
      });
      emit(GetAllOnlineSuccess());
    }).catchError((error) {
      emit(GetAllOnlineError());
    });
  }



}

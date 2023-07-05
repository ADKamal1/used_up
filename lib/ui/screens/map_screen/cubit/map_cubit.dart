import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../../model/users_model.dart';
import '../../../../shared/helper/mangers/constants.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  static MapCubit get(context) => BlocProvider.of(context);

  late GoogleMapController controller;
  bool added = false;

  late UserModel userModel;

  void getUserLocation({required String id}) {
    emit(GetUserLocationLoading());
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .doc(id)
        .snapshots()
        .listen((event) {
      userModel = UserModel.fromJson(event.data() ?? {});
      if (added) {
        animateCam(latitude: userModel.lat ?? 0, longitude: userModel.lon ?? 0);
      }
      emit(GetUserLocationSuccess());
    });
  }

  void onMapCreted({required GoogleMapController mController}) {
    this.controller = mController;
    this.added = true;
    emit(MapControllerSuccess());
  }

  Future<void> animateCam(
      {required double latitude, required double longitude}) async {
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 60.47)));
  }
}

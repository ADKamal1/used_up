import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:admin_app/layout/cubit/main_cubit.dart';
import 'package:admin_app/ui/components/custom_timer.dart';
import 'package:admin_app/ui/screens/map_screen/cubit/map_cubit.dart';

class MapScreen extends StatelessWidget {
  String id;

  MapScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit()..getUserLocation(id: id),
      child: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {},
        builder: (context, state) {
          MapCubit cubit = MapCubit.get(context);
          return WillPopScope(
            onWillPop: () async {
              await Future.delayed(Duration(milliseconds: 800));
              Navigator.of(context).pop();
              return Future.value(false);
            },
            child: Scaffold(
              body: state is GetUserLocationLoading
                  ? Center()
                  : SafeArea(
                      child: Column(
                        children: [
                          CustomTimer(),
                          Expanded(
                            child: GoogleMap(
                              mapType: MapType.normal,
                              markers: {
                                Marker(
                                    markerId:
                                        MarkerId('${cubit.userModel.username}'),
                                    position: LatLng(cubit.userModel.lat.toDouble() ?? 0.0,
                                        cubit.userModel.lon ?? 0.0),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueMagenta)),
                              },
                              onMapCreated: (GoogleMapController controller) {
                                cubit.onMapCreted(mController: controller);
                              },
                              initialCameraPosition: CameraPosition(
                                  zoom: 14.5,
                                  target: LatLng(cubit.userModel.lat.toDouble() ?? 0.0,
                                      cubit.userModel.lon ?? 0.0
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

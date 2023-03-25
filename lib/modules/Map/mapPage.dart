import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yummy/shared/components/imports.dart';
import 'package:latlong2/latlong.dart';

import '../../shared/components/components.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextEditingController searchController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  void initState()
  {
    getCurrentPosition(context, AppCubit.get(context) );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppCubit.get(context);
        return WillPopScope(

          child: Scaffold(
            // appBar: AppBar(),

            body: SafeArea(
              child: ConditionalBuilder(
                condition: cubit.isMapLoaded,
                builder: (context)=> Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 5,),

                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 14.0, end: 14, bottom: 14),
                        child: defaultFormField(
                            controller: searchController,
                            keyboard: TextInputType.text,
                            borderRadius: 10,
                            label: 'Search',
                            prefix: Icons.search_rounded,
                            validate: (value)
                            {
                              if(value!.isNotEmpty)
                                {
                                  return null;
                                }
                              return "Enter a value to search";
                            },

                            onSubmit: (val)
                            {
                              if(formKey.currentState!.validate())
                                {
                                  cubit.getCoordinatesFromAddress(val);
                                }
                            }
                        ),
                      ),

                      Visibility(
                        visible: state is AppChangeMapCoordinatesFromAddressLoadingState,
                        child: Column(
                          children:
                          [
                            const SizedBox(height: 10,),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: defaultLinearProgressIndicator(context),
                            ),

                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),

                      Expanded(
                        child: FlutterMap(
                          options: MapOptions(
                            center: LatLng(cubit.mapLatitude,cubit.mapLongitude), //LatLng(51.509364, -0.128928),
                            zoom: 15.2,

                            onLongPress: (tapPosition, LatLng position)
                            {
                              defaultToast(msg: 'Setting Marker...');
                              cubit.setMarker(position.longitude, position.latitude);

                              // showModalBottomSheet(
                              //   context: context,
                              //   builder: (context)
                              //   {
                              //     return Container(
                              //       height: 200,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //       ),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(24.0),
                              //         child: Column(
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children:
                              //           [
                              //             Expanded(
                              //               child: Text(
                              //                 'Area Name',
                              //                 style: defaultMealNameTextStyle,
                              //               ),
                              //             ),
                              //
                              //             Expanded(
                              //               child: Text(
                              //                 'Region Name',
                              //                 style: defaultDescriptionTextStyle,
                              //               ),
                              //             ),
                              //
                              //             Expanded(
                              //               child: Row(
                              //                 children:
                              //                 [
                              //                   const Text('Longitude is: -128.00'),
                              //
                              //                   const Spacer(),
                              //
                              //                   const Text('Latitude is: -25.00')
                              //                 ],
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   }
                              // );
                            },

                          ),
                          mapController: cubit.mapController,

                          nonRotatedChildren: [
                            // AttributionWidget.defaultWidget(
                            //
                            //   source: cubit.areaName,
                            //
                            //   sourceTextStyle: const TextStyle(
                            //     overflow: TextOverflow.ellipsis
                            //   ),
                            //   alignment: Alignment.bottomLeft,
                            //   onSourceTapped: () {},
                            //
                            // ),


                            Align(
                              alignment: Alignment.bottomLeft,
                              child: ColoredBox(
                                color: const Color(0xCCFFFFFF),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                       Text('You are at: ${cubit.areaName}'),
                                    ],
                                  ),
                                ),
                              ),
                            )

                          ],

                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),

                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(cubit.mapLatitude, cubit.mapLongitude),
                                  width: 80,
                                  height: 80,
                                  builder: (context) =>  Icon(Icons.pin_drop_rounded, size: 35, color: defaultDarkColor,),
                                  anchorPos: AnchorPos.exactly(Anchor(cubit.mapLatitude+2, cubit.mapLongitude)),
                                ),

                                Marker(
                                  point: LatLng(cubit.markerLatitude, cubit.markerLongitude),
                                  width: 80,
                                  height: 80,
                                  builder: (context) =>  Icon(Icons.pin_drop_rounded, size: 35, color: defaultColor,),
                                  anchorPos: AnchorPos.exactly(Anchor(cubit.markerLatitude, cubit.markerLongitude)),
                                ),

                              ],
                            ),
                          ],

                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context)=> Center(child: defaultProgressIndicator(context),),
              ),
            ),

            floatingActionButton: Visibility(
              visible: cubit.isMapLoaded,
              child: FloatingActionButton(
                onPressed: ()
                {
                  getCurrentPosition(context, cubit, isFAB: true);
                },

                elevation: 20,
                child: const Icon(Icons.gps_fixed_rounded),

              ),
            ),
          ),

          onWillPop: () async
          {
            cubit.setMarker(0, 0);
            cubit.changeIsMapLoaded(false);
            return true;
          },
        );
      },
    );
  }


  Future<void> getCurrentPosition(BuildContext context,AppCubit cubit, {bool isFAB=false}) async
  {

    final hasPermission = await handleLocationPermission(context); //Check for Permission
    if (!hasPermission) return;
    defaultToast(msg: 'Getting Coordinates, Please wait');
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high).then((Position position)
    {
      print('Your Position is, $position}');

      if(isFAB==true)
        {
          cubit.changeMapCoordinates(position.longitude,position.latitude, true);
        }
      else
        {
          cubit.changeMapCoordinates(position.longitude, position.latitude, false);
        }
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

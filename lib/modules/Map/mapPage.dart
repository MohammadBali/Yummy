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
        return Scaffold(
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

                        ),
                        mapController: cubit.mapController,
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                        ],

                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context)=> Center(child: defaultProgressIndicator(context)),
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
              getCurrentPosition(context, cubit, isFAB: true);
            },

            elevation: 20,
            child: const Icon(Icons.gps_fixed_rounded),

          ),
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

      cubit.changeMapCoordinates(position.longitude, position.latitude, false);

      setState(() {
        if(isFAB==true)
          {
            cubit.changeMapCoordinates(position.longitude,position.latitude, true);
          }
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

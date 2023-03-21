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

  bool isLoaded=false;
  late double longitude;
  late double latitude;

  MapController mapController=MapController();

  @override
  void initState()
  {
    getCurrentPosition(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),

          body: ConditionalBuilder(
            condition: isLoaded,
            builder: (context)=> FlutterMap(
              options: MapOptions(
                center: LatLng(latitude,longitude), //LatLng(51.509364, -0.128928),
                zoom: 15.2,
              ),
              mapController: mapController,
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ],

            ),
            fallback: (context)=> Center(child: defaultProgressIndicator(context)),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
              getCurrentPosition(context, isFAB: true);
            },

            elevation: 20,
            child: const Icon(Icons.gps_fixed_rounded),

          ),
        );
      },
    );
  }


  Future<void> getCurrentPosition(BuildContext context, {bool isFAB=false}) async
  {
    final hasPermission = await handleLocationPermission(context); //Check for Permission
    if (!hasPermission) return;
    defaultToast(msg: 'Getting Coordinates, Please wait');
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high).then((Position position)
    {
      print('Your Position is, $position}');
      // defaultToast(msg: 'Your Position is, $position}');
      setState(() {

        longitude= position.longitude;
        latitude=position.latitude;
        isLoaded=true;

        if(isFAB==true)
          {
            mapController.move(LatLng(position.latitude,position.longitude), 15.2);
          }
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

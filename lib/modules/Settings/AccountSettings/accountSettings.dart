import 'package:geolocator/geolocator.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/components/imports.dart';
import 'package:flutter_geocoder/geocoder.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

  String? _currentAddress;
  // Position? _currentPosition;

  bool isLoading=false; //Check for getting location

  TextEditingController firstNameController= TextEditingController();
  TextEditingController lastNameController= TextEditingController();

  TextEditingController autoLocationController= TextEditingController();
  TextEditingController locationController= TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    firstNameController.dispose();
    lastNameController.dispose();
    autoLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),

            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Visibility(
                          visible: isLoading,
                          child: defaultLinearProgressIndicator(context),
                        ),

                        const SizedBox(height: 20,),

                        Text(
                          'Personal Information',
                          style: defaultHeadlineTextStyle,
                        ),

                        const SizedBox(height: 35,),

                        Text(
                          'You can change your name and your current location',
                          style: defaultDescriptionTextStyle,
                        ),

                        const SizedBox(height: 50,),

                        defaultFormField(
                          controller: firstNameController,
                          keyboard: TextInputType.name,
                          label: 'First Name',
                          prefix: Icons.person_rounded,
                          borderRadius: 10,
                          validate: (value)
                          {
                            if(value!.isNotEmpty)
                              {
                                return null;
                              }
                            return "Name Can't be empty";
                          },
                        ),

                        const SizedBox(height: 30,),

                        defaultFormField(
                          controller: lastNameController,
                          keyboard: TextInputType.name,
                          label: 'Last Name',
                          prefix: Icons.person_rounded,
                          borderRadius: 10,
                          validate: (value)
                          {
                            if(value!.isNotEmpty)
                            {
                              return null;
                            }
                            return "Last Name Can't be empty";
                          },
                        ),

                        const SizedBox(height: 30,),


                        defaultFormField(
                          controller: locationController,
                          keyboard: TextInputType.text,
                          label: 'Written Location',
                          prefix: Icons.home_rounded,
                          borderRadius: 10,
                          validate: (value)
                          {
                            if(value!.isNotEmpty)
                            {
                              return null;
                            }
                            return "Location Can't be empty";
                          },
                        ),

                        const SizedBox(height: 30,),

                        defaultFormField(
                          controller: autoLocationController,
                          keyboard: TextInputType.none,
                          label: 'Auto Location',
                          prefix: Icons.map_rounded,
                          borderRadius: 10,
                          readOnly: true,
                          validate: (value)
                          {
                            if(value!.isNotEmpty)
                            {
                              return null;
                            }
                            return "Auto Location Can't be empty";
                          },

                          onTap: ()
                          {
                            getCurrentPosition(context);
                          },
                        ),



                        const SizedBox(height: 50,),

                        Center(
                          child: defaultButton(
                            title: 'submit',
                            onTap: ()
                            {
                              if(formKey.currentState?.validate() ==true)
                                {
                                  defaultToast(msg: 'Updating...');
                                }

                            }
                          ),
                        ),

                      ],
                    ),
                ),
              ),
            ),
          );
        },
    );
  }

  Future<void> getCurrentPosition(BuildContext context) async
  {
    setState(() {
      isLoading=true;
    });
    final hasPermission = await handleLocationPermission(context); //Check for Permission
    if (!hasPermission) return;
    defaultToast(msg: 'Getting Coordinates, Please wait');
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high).then((Position position)
    {
      print('Your Position is, $position}');
      defaultToast(msg: 'Your Position is, $position}');
      setState(() {
        autoLocationController.text=position.toString();
        // _currentPosition=position;
        // getAddressFromLatLng(position);
        getAddressFromCoordinates(position);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getAddressFromCoordinates(Position position) async
  {
    defaultToast(msg: 'Getting Address from Coordinates');
    
    final coordinates = Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");

    setState(() {
      autoLocationController.text='${first.featureName}, ${first.addressLine}';

      isLoading=false;
    });
  }
}

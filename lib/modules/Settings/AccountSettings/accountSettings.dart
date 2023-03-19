import 'package:flutter/material.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/components/imports.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

  TextEditingController firstNameController= TextEditingController();
  TextEditingController lastNameController= TextEditingController();

  TextEditingController locationController= TextEditingController();
  var formKey=GlobalKey<FormState>();

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
                          keyboard: TextInputType.none,
                          label: 'Location',
                          prefix: Icons.maps_home_work_rounded,
                          borderRadius: 10,
                          readOnly: true,
                          validate: (value)
                          {
                            if(value!.isNotEmpty)
                            {
                              return null;
                            }
                            return "Location Can't be empty";
                          },

                          onTap: (){},
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
}

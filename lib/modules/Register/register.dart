import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:yummy/layout/home_layout.dart';
import 'package:yummy/modules/Register/cubit/registerCubit.dart';
import 'package:yummy/modules/Register/cubit/registerStates.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/components/imports.dart';
import 'package:yummy/shared/network/local/cache_helper.dart';

import '../../shared/components/constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController firstNameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  TextEditingController passController=TextEditingController();
  TextEditingController writtenLocationController=TextEditingController();

  // TextEditingController autoLocationController=TextEditingController();
  //
  // bool isLoading=false; //Check for getting location

  // List<String> listOfGenders = ['M','F'];
  // String currentGender='M';  //User's Gender.

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
    phoneController.dispose();
    passController.dispose();
    writtenLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state)
        {
          if(state is UserRegisterSuccessState)
            {
              if(state.registerModel.success==1)
                {
                  print(state.registerModel.message);
                  print(state.registerModel.token);
                  defaultToast(
                    msg: 'Success',
                    state: ToastStates.success,
                  );

                  CacheHelper.saveData(key: 'token', value: state.registerModel.token).then((value)
                  {
                    token=state.registerModel.token!;
                    navigateAndFinish(context, const HomeLayout() );
                  }).catchError((error)
                  {
                    print('ERROR WHILE SAVING TOKEN IN REGISTER SCREEN, ${error.toString()}');
                  });
                }
            }

          if(state is UserRegisterErrorState)
            {
              defaultToast(
                msg: state.error.toString(),
                state:ToastStates.error,
              );
            }
        },
        builder: (context,state){
          var cubit= RegisterCubit().get(context);
          return WillPopScope(

            child: Scaffold(
              appBar: AppBar(),

              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [

                        Visibility(
                          visible: state is RegisterGetAddressFromCoordinatesLoadingState || state is RegisterGetCoordinatesLoadingState || state is UserRegisterLoadingState,
                          child: defaultLinearProgressIndicator(context),
                        ),

                        const SizedBox(height: 20,),

                         GradientText(
                          'REGISTER NOW',
                          style: const TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                           colors:
                           [
                             HexColor('590D22'),

                             HexColor('800F2F'),

                             HexColor('C9184A'),

                             HexColor('FF4D6D'),

                             HexColor('FF8FA3'),
                           ],
                        ),

                        const SizedBox(height: 20,),

                        Text(
                          'Register to start a path you won\'t regret !',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                        ),

                        const SizedBox(height: 40,),

                        defaultFormField(
                            controller: firstNameController,
                            keyboard: TextInputType.name,
                            label: 'Full Name',
                            prefix: Icons.person_rounded,
                            borderRadius: 10,
                            digitsLimits: 20,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                                {
                                  return 'Name Cannot be Empty';
                                }
                              return null;
                            }
                        ),

                        const SizedBox(height: 30,),


                        defaultFormField(
                            controller: phoneController,
                            keyboard: TextInputType.number,
                            label: 'Phone Number',
                            prefix: Icons.phone_rounded,
                            borderRadius: 10,
                            digitsLimits: 10,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Phone Cannot be Empty';
                              }
                              return null;
                            }
                        ),

                        const SizedBox(height: 30,),


                        defaultFormField(
                            controller: passController,
                            keyboard: TextInputType.text,
                            label: 'Password',
                            prefix: Icons.password_rounded,
                            suffix: cubit.isPassVisible? Icons.visibility_off_rounded : Icons.visibility_rounded,
                            isObscure: cubit.isPassVisible? true : false,
                            borderRadius: 10,
                            digitsLimits: 15,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Password Cannot be Empty';
                              }
                              return null;
                            },

                            onPressedSuffixIcon: ()
                            {
                              cubit.changePassVisibility();
                            }
                        ),

                        const SizedBox(height: 30,),


                        defaultFormField(
                            controller: writtenLocationController,
                            keyboard: TextInputType.text,
                            label: 'Written Location',
                            prefix: Icons.home_rounded,
                            borderRadius: 10,
                            digitsLimits: 60,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Written Location Cannot be Empty';
                              }
                              return null;
                            }
                        ),

                        const SizedBox(height: 30,),

                        defaultFormField(
                            controller: cubit.autoLocationController,
                            keyboard: TextInputType.none,
                            label: 'Auto Location',
                            prefix: Icons.map_rounded,
                            borderRadius: 10,
                            digitsLimits: 60,
                            readOnly: true,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Auto Location Cannot be Empty';
                              }
                              return null;
                            },

                            onTap:()
                            {
                              cubit.getCurrentPosition(context);
                            }
                        ),

                        const SizedBox(height: 50,),

                        Center(
                          child: defaultButton(
                            title: 'Register',
                            onTap: ()
                            {
                              if(formKey.currentState!.validate())
                                {
                                  cubit.userRegister(
                                      name: firstNameController.value.text,
                                      password: passController.value.text,
                                      phoneNumber: phoneController.value.text,
                                      writtenLocation: writtenLocationController.value.text,
                                      // autoLocation: cubit.autoLocationController.value.text,
                                  );
                                }
                            }
                          ),
                        ),

                        // FormField<String>(
                        //   builder: (FormFieldState<String> state) {
                        //     return InputDecorator(
                        //       decoration: InputDecoration(
                        //           errorStyle:const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        //           labelText: 'Gender',
                        //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                        //       child: DropdownButtonHideUnderline(
                        //         child: DropdownButton<String>(
                        //           style: TextStyle(color: AppCubit.get(context).isDarkTheme? defaultDarkColor : defaultColor),
                        //
                        //           value: currentGender,
                        //           isDense: true,
                        //           onChanged: (newValue) {
                        //             setState(() {
                        //               currentGender = newValue!;
                        //               state.didChange(newValue);
                        //             });
                        //           },
                        //           items: listOfGenders.map((String value) {
                        //             return DropdownMenuItem<String>(
                        //               value: value,
                        //               child: Text(value),
                        //             );
                        //           }).toList(),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            onWillPop: ()async
            {
              cubit.autoLocationController.text='';
              return true;
            },
          );
        },
      ),
    );
  }

}

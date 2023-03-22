import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:yummy/modules/Register/cubit/registerCubit.dart';
import 'package:yummy/modules/Register/cubit/registerStates.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/components/imports.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController firstNameController=TextEditingController();


  List<String> listOfGenders = ['M','F'];
  String currentGender='M';  //User's Gender.

  var formKey=GlobalKey<FormState>();

  @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
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
                          label: 'First Name',
                          prefix: Icons.person_rounded,
                          borderRadius: 10,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                              {
                                return 'Name Cannot be Empty';
                              }
                            return null;
                          }
                      ),

                      const SizedBox(height: 40,),

                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                errorStyle:const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                labelText: 'Gender',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                style: TextStyle(color: AppCubit.get(context).isDarkTheme? defaultDarkColor : defaultColor),

                                value: currentGender,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentGender = newValue!;
                                    state.didChange(newValue);
                                  });
                                },
                                items: listOfGenders.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),


                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

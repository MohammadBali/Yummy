import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummy/modules/Login/cubit/loginCubit.dart';
import 'package:yummy/modules/Login/cubit/loginStates.dart';
import 'package:yummy/modules/Register/register.dart';
import 'package:yummy/shared/components/components.dart';
import 'package:yummy/shared/components/constants.dart';
import 'package:yummy/shared/components/imports.dart';
import 'package:yummy/shared/network/local/cache_helper.dart';

import '../../layout/home_layout.dart';

class Login extends StatelessWidget {
   Login({Key? key}) : super(key: key);

  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state)
        {
          if(state is LoginErrorState)
            {
              defaultToast(msg: state.error, state: ToastStates.error);
            }

          if(state is LoginSuccessState)
            {
              if(state.loginModel.success==1)
                {
                  defaultToast(msg: 'Success', state: ToastStates.success);

                  CacheHelper.saveData(key: 'token', value: state.loginModel.token).then((value)
                  {
                    token=state.loginModel.token!;

                    navigateAndFinish(context, const HomeLayout());

                  }).catchError((error)
                  {
                    print('ERROR WHILE CACHING USER TOKEN IN LOGIN, ${error.toString()}');
                  });
                }
            }
        },

        builder: (context,state)
        {
          var cubit= LoginCubit.get(context);
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

                      Center(
                        child: Text(
                          'Yummy',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontFamily: 'MagistralHonesty',
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            color: defaultDarkColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 50,),

                       Text(
                        'Login now to explore a world of wonders !',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blueGrey),
                      ),

                      const SizedBox(height: 50,),

                      defaultFormField(
                        controller: phoneController,
                        keyboard: TextInputType.number,
                        label: 'Phone Number',
                        prefix: Icons.numbers_rounded,
                        borderRadius: 10,
                        validate: (value)
                        {

                          if(value!.isEmpty)
                            {
                              return 'Phone Number Can\'t be empty';
                            }
                          return null;
                        }
                      ),

                      const SizedBox(height: 35,),

                      defaultFormField(
                          controller: passwordController,
                          keyboard: TextInputType.text,
                          label: 'Password',
                          prefix: Icons.password_rounded,
                          suffix: cubit.isPassVisible? Icons.visibility_off_rounded : Icons.visibility_rounded,
                          isObscure: cubit.isPassVisible? true : false,
                          borderRadius: 10,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Password Can\'t be empty';
                            }
                            return null;
                          },

                        onPressedSuffixIcon: ()
                        {
                          cubit.changePassVisibility();
                        },

                        onSubmit: (val)
                        {
                          if(formKey.currentState!.validate())
                          {

                          }
                        },
                      ),

                      const SizedBox(height: 25,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Don't have an account?"
                          ),

                          TextButton(
                            onPressed: ()
                            {
                              navigateTo(context, const Register());
                            },

                            child: const Text(
                              'REGISTER NOW!'
                            ),

                            onLongPress: ()
                            {
                              navigateAndFinish(context, const HomeLayout());
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 25,),

                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context)=>Center(child: defaultButton(

                            title: 'login',

                            onTap: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.userLogin(
                                  phoneController.value.text,
                                  passwordController.value.text,
                                );
                              }
                            }),
                        ),
                        fallback: (context)=>Center(child: defaultProgressIndicator(context),)
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

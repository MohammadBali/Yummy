import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/imports.dart';
import '../../../shared/network/local/cache_helper.dart';

class BankingHome extends StatelessWidget {
   BankingHome({Key? key, this.isOrder=false}) : super(key: key);

   TextEditingController idController=TextEditingController();
   TextEditingController passwordController=TextEditingController();

   var formKey=GlobalKey<FormState>();

  bool isOrder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state)
      {
        if(state is AppBankingLoginErrorState)
        {
          defaultToast(msg: state.error, state: ToastStates.error);
        }

        if(state is AppBankingLoginSuccessState)
        {
          if(state.model.success==1)
          {
            defaultToast(msg: 'Success', state: ToastStates.success);

            CacheHelper.saveData(key: 'bankingToken', value: state.model.token).then((value)
            {
              bankingToken=state.model.token!;

              if(isOrder==true) //If Coming from an Order, then do something
                {
                  AppCubit.get(context).submitOrder();
                }
            }).catchError((error)
            {
              print('ERROR WHILE CACHING BANKING TOKEN IN LOGIN, ${error.toString()}');
            });
          }
        }
      },

      builder: (context,state)
      {
        var cubit=AppCubit.get(context);
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
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Banking Credentials',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),

                    const SizedBox(height: 50,),

                    Text(
                      'Enter your credentials to pay per debut cards',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blueGrey),
                    ),

                    const SizedBox(height: 50,),

                    defaultFormField(
                        controller: idController,
                        keyboard: TextInputType.number,
                        label: 'Card ID',
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
                      suffix: cubit.isBankPassVisible? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      suffixIconColor: cubit.isDarkTheme? Colors.white: Colors.black,
                      isObscure: cubit.isBankPassVisible? true : false,
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


                    const SizedBox(height: 25,),

                    ConditionalBuilder(
                        condition: state is! AppBankingLoginLoadingState,
                        builder: (context)=>Center(
                          child:defaultButton(
                            title: 'login',
                            onTap: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.userLogin(
                                  idController.value.text,
                                  passwordController.value.text,
                                );
                              }
                            }
                            ),
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
    );
  }
}

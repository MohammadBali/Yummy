import 'package:yummy/shared/components/components.dart';

import '../../../shared/components/imports.dart';

class BankingPersonalInformation extends StatefulWidget {
  const BankingPersonalInformation({Key? key}) : super(key: key);

  @override
  State<BankingPersonalInformation> createState() => _BankingPersonalInformationState();
}

class _BankingPersonalInformationState extends State<BankingPersonalInformation> {
  var formKey= GlobalKey<FormState>();

  TextEditingController oldPassword= TextEditingController();
  TextEditingController newPassword= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit= AppCubit.get(context);
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
                    Text(
                      'Change Your Password',
                      style: defaultHeadlineTextStyle,
                    ),

                    const SizedBox(height: 75,),

                    defaultFormField(
                      controller: newPassword,
                      keyboard: TextInputType.text,
                      label: 'New Password',
                      prefix: Icons.key_rounded,
                      suffix: cubit.isBankPassVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      suffixIconColor: cubit.isDarkTheme ? Colors.white : Colors.black,
                      isObscure: cubit.isBankPassVisible,
                      onPressedSuffixIcon: ()
                      {
                        cubit.changeBankingPassVisibility();
                      },
                      borderRadius: 7,
                      validate:(value)
                      {
                        if(value!.isEmpty)
                          {
                            return 'Enter a Password';
                          }
                        return null;
                      },
                    ),


                    const SizedBox(height: 50,),

                    defaultFormField(
                      controller: oldPassword,
                      keyboard: TextInputType.text,
                      label: 'Old Password',
                      prefix: Icons.key_rounded,
                      suffix: cubit.isBankPassVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      suffixIconColor: cubit.isDarkTheme ? Colors.white : Colors.black,
                      isObscure: cubit.isBankPassVisible,
                      onPressedSuffixIcon: ()
                      {
                        cubit.changeBankingPassVisibility();
                      },
                      borderRadius: 7,
                      validate:(value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'Enter a Password';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 50,),

                    Center(
                      child: defaultButton(
                        title: 'Submit',
                        onTap: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            cubit.bankingChangePassword(newPassword.value.text);
                          }
                        }),
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

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:yummy/shared/components/components.dart';

import '../../shared/components/imports.dart';

class Search extends StatelessWidget {
   Search({Key? key}) : super(key: key);

  TextEditingController searchController= TextEditingController();
  var formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state)
        {
          if(state is AppSearchMealSuccessState)
            {
              if(state.success ==0)
              {
                defaultToast(msg: 'No Such Meal is Found');
              }
            }
        },
        builder: (context,state)
        {
          var cubit=AppCubit.get(context);
          return WillPopScope(
            child: Scaffold(
              appBar: AppBar(),

              body: SingleChildScrollView(

                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children:
                      [
                        Visibility(
                            visible: state is AppSearchMealLoadingState,
                            child: Column(
                              children:
                              [
                                const SizedBox(height: 10,),

                                defaultLinearProgressIndicator(context),

                                const SizedBox(height: 20,),

                              ],
                            ),
                        ),

                        defaultFormField(
                            controller: searchController,
                            keyboard: TextInputType.text,
                            label: 'Search',
                            borderRadius: 10,
                            prefix: Icons.search_rounded,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                                {
                                  return 'Enter a Value';
                                }
                              return null;
                            },

                            onSubmit: (String? value)
                            {
                              cubit.searchMealModel=null;

                              if(formKey.currentState!.validate())
                                {
                                  cubit.searchMeal(value!);
                                }
                            }
                        ),

                        ConditionalBuilder(
                          condition: cubit.searchMealModel !=null,
                          fallback: (context)=> const SizedBox(height: 25,),
                          builder: (context)=>ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,index)=> mealItemBuilder(context,cubit,cubit.searchMealModel!.data![index] ,sizedBoxHeight: 15),
                            itemCount: cubit.searchMealModel!.data!.length,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

            onWillPop: ()async
            {
              cubit.searchMealModel=null;
              return true;
            },
          );
        },
    );
  }
}

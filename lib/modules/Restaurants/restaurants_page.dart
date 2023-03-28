import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class RestaurantsPage extends StatelessWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit=AppCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ConditionalBuilder(
              condition: cubit.allRestaurantsModel !=null,
              fallback: (context)=>Center(child: defaultProgressIndicator(context)),

              builder: (context)=>Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>restaurantItemBuilder(context, cubit.allRestaurantsModel!.data![index]!),
                      separatorBuilder: (context,state)=> myDivider(),
                      itemCount: cubit.allRestaurantsModel!.data!.length
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

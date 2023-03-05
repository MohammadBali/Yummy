import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yummy/layout/cubit/cubit.dart';
import 'package:yummy/layout/cubit/states.dart';
import 'package:yummy/shared/components/components.dart';

import '../../shared/styles/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children:
              [
                Text(
                  'New Offers',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: defaultHeadlineTextStyle,
                ),

                const SizedBox(height: 10,),

                myDivider(),

                const SizedBox(height: 20,),

                SizedBox(
                  height: 150,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>offerItemBuilder(function: (){}),
                      separatorBuilder: (context,index)=> const SizedBox(width: 15,),
                      itemCount: 5
                  ),
                ),

                const SizedBox(height: 50,),

                Text(
                  'Trendy Meals',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: defaultHeadlineTextStyle,
                ),

                const SizedBox(height: 10,),


                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>mealItemBuilder(),
                    separatorBuilder: (context,index)=> myDivider(),
                    itemCount: 5,
                ),

              ],
            ),
          ),
        );
      },
    );
  }


  Widget offerItemBuilder({
    required void Function()? function,

  }) =>
      InkWell(
        borderRadius: BorderRadius.circular(20),
        highlightColor: Colors.grey.withOpacity(0.5),
        onTap: function,
        child: Container(
          width: 110,
          height: 150,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
                image: AssetImage('assets/images/lasagna.jpg'),
                fit: BoxFit.fill,
                opacity: 0.6,
            ),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:const
            [
              Expanded(
                child: Center(
                    child: Text(
                      'Offer Info',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 9,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      );
}

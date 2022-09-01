import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/home_modules/home_cubit/cubit.dart';
import 'package:shopping/modules/home_modules/home_cubit/status.dart';
import 'package:shopping/shared/componant/componant.dart';
import 'package:shopping/shared/styles/colors.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopHomeStatus>(listener: (context, state) {
      if (state is FavoritChangeSuccessState) {
        if (state.model.status == false) {
          showtoast(
              text: '${state.model.message} try  again please',
              state: toastStates.ERROR);
        }

      }
      if (state is ChangeCartSuccessState) {
        if (state.cartModel.status) {
          showtoast(text: "done", state: toastStates.SUCESS);
        } else {
          showtoast(text: "Try again", state: toastStates.WARRING);
        }
      }
    }, builder: (context, state) {
      return SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConditionalBuilder(
                condition: (ShopCubit.get(context).homeModel != null),
                builder: (context) {
                  return bannertItem(ShopCubit.get(context).homeModel);
                },
                fallback: (context) =>
                    Center(child: Container(
                        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/8),
                        child: CircularProgressIndicator())),
              ),
              //productItem(ShopCubit.get(context).homeModel?.data?.products[0], context)
              ConditionalBuilder(
                  condition: (ShopCubit.get(context).homeModel?.data != null),
                  builder: (BuildContext context) {
                    return defeultGridView(
                        ShopCubit.get(context).homeModel?.data?.products.length,
                        ShopCubit.get(context).homeModel?.data?.products);
                  },
                  fallback: (BuildContext context) => Center(

                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/2),
                            child: CircularProgressIndicator(
                        color: defultColor,
                      ),
                          ))),
            ],
          ),
        ),
      );
    });
  }
}

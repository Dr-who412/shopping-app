import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping/modules/home_modules/home_cubit/cubit.dart';
import 'package:shopping/modules/home_modules/home_cubit/status.dart';
import 'package:shopping/shared/componant/componant.dart';
import '../../models/shopHomemodels/Carts.dart';
import '../../modules/home_modules/cart/carts_sc.dart';
import '../../shared/styles/colors.dart';

class home extends StatelessWidget {
  home({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopHomeStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "shopping",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    ShopCubit.get(context).getCart();
                    navigatTo(context, Carts_Screen());
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ))
            ],
          ),
          body: cubit.Bottomscreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomIndex(index);
            },
            currentIndex: cubit.currentIndex,
            // backgroundColor: HexColor('D98E73A1'),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border_rounded,
                  ),
                  label: 'favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded), label: 'search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined), label: 'products'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined), label: 'category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: 'profile'),
            ],
          ),
        );
      },
    );
  }
}

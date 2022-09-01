import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/modules/home_modules/home_cubit/cubit.dart';

import '../../../shared/styles/colors.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 42,
              crossAxisSpacing: 24,
            ),
            itemCount:
                ShopCubit.get(context).categoryMdel?.data?.dataCategory?.length,
            itemBuilder: (contexy, index) {
              return Card(
                shadowColor: Colors.grey,
                elevation: 6,
                color: defultColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      "${ShopCubit.get(context).categoryMdel?.data?.dataCategory![index].image}",
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${ShopCubit.get(context).categoryMdel?.data?.dataCategory![index].name}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}

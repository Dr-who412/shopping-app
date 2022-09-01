import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/home_modules/home_cubit/cubit.dart';
import 'package:shopping/modules/home_modules/home_cubit/status.dart';

import '../../../shared/componant/componant.dart';
import '../../../shared/styles/colors.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopHomeStatus>(
      listener: (context, state) {
        if(state is FavoritChangeSuccessState){
          showtoast(text: "done", state: toastStates.SUCESS);
        }else if(state is FavoritChangeErrorState){
          showtoast(text: "Try again", state: toastStates.WARRING);
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var list = cubit.favoritProduct?.data?.datafav;
        return SafeArea(
            child: list?.length!= 0
                ? ListView.builder(
                    itemCount: cubit.favoritProduct?.data?.datafav?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showCustomBottomSheet(
                              context: context,
                              title: list![index].product?.name,
                              subTitle: "${list[index].product?.price} ",
                              imageUrl: list[index].product?.image,
                              description: list[index].product?.description);
                        },
                        child: Container(
                          height: 120,
                          margin: EdgeInsets.all(12),
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            shadowColor: Colors.grey,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Image.network(
                                        "${list![index].product?.image}",
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            'assets/shop.png',
                                            color: Colors.black12,
                                          );
                                        },
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }

                                          return Center(
                                            child: Container(
                                              padding: EdgeInsets.all(42),
                                              width: 120,
                                              height: 120,
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${list[index].product?.name}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${list[index].product?.price}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: defultColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            list[index].product?.discount != 0
                                                ? Text(
                                                    "${list[index].product?.oldPrice}",
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          defultColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                : SizedBox(),
                                            Spacer(),
                                            list[index].product?.discount != 0
                                                ? CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor: defultColor
                                                        .withOpacity(.6),
                                                    child: Text(
                                                      "${list[index].product?.discount}%",
                                                      style: TextStyle(
                                                        decorationColor:
                                                            defultColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ))
                                                : SizedBox(),
                                            Spacer(),
                                            Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                ShopCubit.get(context)
                                                    .changeFavorite(list[index]
                                                        .product
                                                        ?.id);
                                                list.removeAt(index);
                                              },
                                              icon: Icon(
                                                ShopCubit.get(context)
                                                                .favoritList[
                                                            list[index]
                                                                .product
                                                                ?.id] ==
                                                        true
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_border_rounded,
                                                color: defultColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.grey,
                        size: 84,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "favorite is empty",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.grey),
                      )
                    ],
                  )));
      },
    );
  }
}

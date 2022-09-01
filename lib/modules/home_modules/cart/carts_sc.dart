import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../shared/componant/componant.dart';
import '../../../shared/styles/colors.dart';
import '../home_cubit/cubit.dart';
import '../home_cubit/status.dart';

class Carts_Screen extends StatelessWidget {
  const Carts_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopHomeStatus>(
      listener: (context, state) {
        if(state is FavoritChangeSuccessState){
          showtoast(text: "done", state: toastStates.SUCESS);
        }else if(state is FavoritChangeErrorState){
          showtoast(text: "Try again", state: toastStates.WARRING);
        }
        if(state is ChangeCartSuccessState){
          if (state.cartModel.status) {
          showtoast(text: "done", state: toastStates.SUCESS);
        }else {
          showtoast(text: "Try again", state: toastStates.WARRING);
        }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Carts",
              style: TextStyle(color: defultColor, fontSize: 36),
            ),
          ),
          body: state is LoadingCartstate
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : cubit.cartProduct?.data?.cartItems?.length != 0
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount:
                          cubit.cartProduct?.data?.cartItems?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showCustomBottomSheet(
                                context: context,
                                title: cubit.cartProduct?.data
                                    ?.cartItems![index].productCarts?.name,
                                subTitle:
                                    "${cubit.cartProduct?.data?.cartItems![index].productCarts?.price} ",
                                imageUrl: cubit.cartProduct?.data
                                    ?.cartItems![index].productCarts?.image,
                                description: cubit
                                    .cartProduct
                                    ?.data
                                    ?.cartItems![index]
                                    .productCarts
                                    ?.description);
                          },
                          child: Container(
                            height: 120,
                            margin: EdgeInsets.all(12),
                            child: Slidable(
                              key: ValueKey(cubit.cartProduct?.data
                                  ?.cartItems![index].productCarts?.id),
                              startActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    onPressed: (_) {
                                      print(index);
                                      var item = (cubit.cartProduct?.data
                                              ?.cartItems![index] ??
                                          null)!;
                                      cubit.changeCart(item.productCarts?.id);
                                      cubit.cartProduct?.data?.cartItems
                                          ?.removeAt(index);
                                    },
                                    foregroundColor: Color(0xFFFE4A49),
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
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
                                            "${cubit.cartProduct?.data?.cartItems![index].productCarts?.image}",
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Image.asset(
                                                'assets/shop.png',
                                                color: Colors.black12,
                                              );
                                            },
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }

                                              return Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(42),
                                                  width: 120,
                                                  height: 120,
                                                  child:
                                                      CircularProgressIndicator(
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
                                              "${cubit.cartProduct?.data?.cartItems![index].productCarts?.name}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${cubit.cartProduct?.data?.cartItems![index].productCarts?.price}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: defultColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                cubit
                                                            .cartProduct
                                                            ?.data
                                                            ?.cartItems![index]
                                                            .productCarts
                                                            ?.discount !=
                                                        0
                                                    ? Text(
                                                        "${cubit.cartProduct?.data?.cartItems![index].productCarts?.oldPrice}",
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
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
                                                cubit
                                                            .cartProduct
                                                            ?.data
                                                            ?.cartItems![index]
                                                            .productCarts
                                                            ?.discount !=
                                                        0
                                                    ? CircleAvatar(
                                                        radius: 18,
                                                        backgroundColor:
                                                            defultColor
                                                                .withOpacity(
                                                                    .6),
                                                        child: Text(
                                                          "${cubit.cartProduct?.data?.cartItems![index].productCarts?.discount}%",
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
                                                        .changeFavorite(cubit
                                                            .cartProduct
                                                            ?.data
                                                            ?.cartItems![index]
                                                            .productCarts
                                                            ?.id);
                                                    cubit.favoritProduct?.data
                                                        ?.datafav
                                                        ?.removeWhere((element) =>
                                                            element.id ==
                                                            cubit
                                                                .cartProduct
                                                                ?.data
                                                                ?.cartItems![
                                                                    index]
                                                                .productCarts
                                                                ?.id);
                                                  },
                                                  icon: Icon(
                                                    cubit.favoritList[cubit
                                                                .cartProduct
                                                                ?.data
                                                                ?.cartItems![
                                                                    index]
                                                                .productCarts
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
                          ),
                        );
                      })
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.grey,
                            size: 42,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Cart is empty get some product",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}

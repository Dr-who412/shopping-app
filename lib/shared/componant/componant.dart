import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping/modules/home_modules/home_cubit/cubit.dart';
import 'package:shopping/modules/home_modules/home_cubit/status.dart';
import 'package:shopping/shared/shared_preference/cachHelper.dart';

import '../../models/shopHomemodels/shopHomemodel.dart';
import '../../modules/login/login.dart';
import '../styles/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget pageViewItem(titlepageview model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image(
        image: AssetImage(model.image),
      )),
      SizedBox(
        height: 15,
      ),
      Text(
        model.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10,
      ),
      Text(model.desc),
    ],
  );
}

class titlepageview {
  late final String image;
  late final String title;
  late final String desc;
  titlepageview({required this.image, required this.title, required this.desc});
}

void logout(context) async {
  await CacheHelper.removedata(key:"token").then((value){
    if (value) {
      print(value);
      print(CacheHelper.getdata(key: 'token'));
      navigatandFinish(context, login());
      showtoast(text: "logout Done", state: toastStates.SUCESS);
    } else {
      showtoast(text: "please try again", state: toastStates.ERROR);
    }
  });
}

Future NavigatFinsh(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
      result: (rout) {
        return false;
      },
    );

Widget DefoultformFild({
  required TextEditingController controller,
  required TextInputType type,
  required bool isPassword,
  onsubmit,
  onChange,
  onTap,
  required validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  suffixfun,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onsubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      maxLines: 1,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0.0),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        // label: Text(label),
        hintText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(onPressed: suffixfun, icon: Icon(suffix)),
      ),
    );
Widget defultButton({
  context,
  required onpressed,
  required String text,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: defultColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextButton(
        onPressed: onpressed,
        child: Text(text,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                )),
      ),
    );
Widget defultTextButton({
  context,
  required onpressed,
  required String text,
}) =>
    TextButton(
      onPressed: onpressed,
      child: Text(
        text,
      ),
    );
void navigatTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigatandFinish(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void showtoast({required String text, required toastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);

enum toastStates { ERROR, WARRING, SUCESS }

Color? toastColor({toastStates? state}) {
  Color? color;
  switch (state) {
    case toastStates.ERROR:
      color = Color.fromRGBO(245, 3, 3, 0.6470588235294118).withOpacity(.4);
      break;
    case toastStates.SUCESS:
      color = defultColor.withOpacity(.4);
      break;
    case toastStates.WARRING:
      color = Color.fromRGBO(245, 196, 1, 0.6980392156862745).withOpacity(.4);
      break;
  }
  return color;
}

void showCustomBottomSheet({
  required context,
  required title,
  subTitle,
  description,
  imageUrl,
}) =>
    showModalBottomSheet<void>(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(26), topLeft: Radius.circular(26)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 2 / 3,
          width: double.infinity,
          margin: EdgeInsets.only(top: 28, left: 8, right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                    child: Text(
                  '${title}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                )),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '${subTitle}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: defultColor),
                ),
                SizedBox(
                  height: 12,
                ),

                Image.network(
                  '$imageUrl',
                  width: 140,
                  height: 140,
                ),
                Text(
                  '${description}',
                  style: TextStyle(fontSize: 18),
                ),

                // ElevatedButton(
                // child: Text('Close BottomSheet'),
                // onPressed: () => Navigator.pop(context),
                // )
              ],
            ),
          ),
        );
      },
    );

Widget bannertItem(
  HomeModel? homemodel,
) {
  return CarouselSlider(
      items: homemodel?.data?.banners
          .map((e) => Container(
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  '${e.image}',
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/shop.png',
                      color: Colors.black12,
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: 280,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(seconds: 2),
        autoPlayCurve: Curves.easeInOutBack,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ));
}

Widget productItem(productModel? item, context) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        InkWell(
          onTap: () {
            showCustomBottomSheet(
                context: context,
                title: item?.name,
                description: item?.description,
                imageUrl: item?.image,
                subTitle: "${item?.price}");
          },
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            height: 240,
            width: 160,
            child: Card(
              shadowColor: Colors.grey,
              elevation: 7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 2),
                        child: Container(
                          height: 115,
                          child: Image.network(
                            "${item?.image}",
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset(
                                'assets/shop.png',
                                color: Colors.black12,
                              );
                            },
                            loadingBuilder: (BuildContext context, Widget child,
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
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          if (item?.discount != null && item?.discount != 0)
                            Container(
                              child: Text(
                                "Discount ${item?.discount}%",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: defultColor.withOpacity(0.5),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorite(item?.id);

                              print("now");
                            },
                            icon: Icon(
                              ShopCubit.get(context).favoritList[item?.id] ==
                                      true
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                              color: defultColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${item?.name}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                            ),
                          ),

                          Spacer(),

                          //SizedBox(height: ,),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  " ${item?.price}",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: defultColor),
                                ),
                                Spacer(),
                                if (item?.oldPrice != item?.price)
                                  Text(
                                    "${item?.oldPrice} ",
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          //fontWeight: FontWeight.bold,

                                          color: Colors.grey,

                                          fontSize: 10,

                                          decoration:
                                              TextDecoration.lineThrough,

                                          decorationColor: defultColor,
                                        ),
                                  ),
                              ],
                            ),
                          ),

                          Spacer(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, blurRadius: 8, offset: Offset(0, 5))
              ],
              color: defultColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: () {
                ShopCubit.get(context).changeCart(item?.id);
                print("cart");
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ))
      ],
    );
Widget Gridcustomv(HomeModel? list, count) => StaggeredGridView.countBuilder(
      staggeredTileBuilder: (index) => index % 7 == 0
          ? StaggeredTile.count(2, 2)
          : StaggeredTile.count(1, 1),
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list?.data?.products.length,
      itemBuilder: (BuildContext context, int index) {
        return productItem(list?.data?.products[index], context);
      },
    );

Widget defeultGridView(length, Items) => Items != null
    ? GridView.builder(
        itemCount: length,
        itemBuilder: (context, index) {
          return productItem(Items[index], context);
        },
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      )
    : CircularProgressIndicator();
// Widget Gridcustom(list, count) => GridView.custom(
//       gridDelegate: SliverStairedGridDelegate(
//         crossAxisSpacing: 48,
//         mainAxisSpacing: 24,
//         startCrossAxisDirectionReversed: true,
//         pattern: [
//           StairedGridTile(0.5, 1),
//           StairedGridTile(0.5, 3 / 4),
//           StairedGridTile(1.0, 10 / 4),
//         ],
//       ),
//       childrenDelegate: SliverChildBuilderDelegate(
//         childCount: count,
//         (context, index) => productItem(
//           list.products[index],
//           context,
//         ),
//       ),
//     );

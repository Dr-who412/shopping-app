import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/home_modules/home_cubit/cubit.dart';
import 'package:shopping/modules/home_modules/home_cubit/status.dart';
import '../../../shared/componant/componant.dart';
import '../../../shared/styles/colors.dart';
import 'cubit/searchCubit.dart';
import 'cubit/searchState.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  bool onSearch = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          var list = cubit.searchResult?.data?.data;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 55,
                  margin: EdgeInsets.only(right: 18, left: 18, top: 8),
                  child: DefoultformFild(
                    controller: searchController,
                    type: TextInputType.text,
                    prefix: Icons.search,
                    label: 'search',
                    isPassword: false,
                    validate: (value) {},
                    onsubmit: (value) {
                      cubit.getSearch(searchController.text);
                    },
                  ),
                ),
                if (state is SearchLoadingState)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 34.0,
                      vertical: 1.0,
                    ),
                    child: LinearProgressIndicator(),
                  ),
                Container(
                  child: list != null
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showCustomBottomSheet(
                                    context: context,
                                    title: list[index].name,
                                    subTitle: "${list[index].price}",
                                    imageUrl: list[index].image,
                                    description: list[index].description);
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
                                                "${list[index].image}")),
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
                                                "${list[index].name}",
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
                                                    "${list[index].price}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: defultColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () {
                                                        ShopCubit.get(context)
                                                            .changeFavorite(
                                                                list[index].id);
                                                        ShopCubit.get(context)
                                                            .favoritProduct
                                                            ?.data
                                                            ?.datafav
                                                            ?.removeWhere(
                                                                (element) =>
                                                                    element
                                                                        .id ==
                                                                    list[index]
                                                                        .id);
                                                      },
                                                      icon: BlocBuilder<
                                                          ShopCubit,
                                                          ShopHomeStatus>(
                                                        buildWhen:
                                                            (previse, state) {
                                                          if (state
                                                              is FavoritChangeState) {
                                                            return true;
                                                          } else {
                                                            return false;
                                                          }
                                                        },
                                                        builder:
                                                            (context, state) {
                                                          return Icon(
                                                            ShopCubit.get(context)
                                                                        .favoritList[list[
                                                                            index]
                                                                        .id] ==
                                                                    true
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border_rounded,
                                                            color: defultColor,
                                                          );
                                                        },
                                                      )),
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
                            SizedBox(
                              height: 200,
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 84,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              "search is empty",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.grey),
                            )
                          ],
                        )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

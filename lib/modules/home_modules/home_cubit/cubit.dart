import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/models/shopHomemodels/categoriesModel.dart';
import 'package:shopping/models/shopHomemodels/favorite_Model.dart';
import 'package:shopping/models/shopLoginmodels/shoploginModel.dart';
import 'package:shopping/modules/home_modules/home_cubit/status.dart';
import 'package:shopping/modules/home_modules/profile/profile.dart';
import '../../../models/shopHomemodels/Carts.dart';
import '../../../models/shopHomemodels/favorite_Product_Models.dart';
import '../../../models/shopHomemodels/shopHomemodel.dart';
import '../../../shared/componant/constance.dart';
import '../../../shared/network/remote/endPoint.dart';
import '../../../shared/network/remote/Dio_Helper.dart';
import '../cateogries/categories_sc.dart';
import '../favorites/favorites_sc.dart';
import '../product/product_sc.dart';
import '../search/search_sc.dart';

class ShopCubit extends Cubit<ShopHomeStatus> {
  ShopCubit() : super(IntilHomestate());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 2;
  List<Widget> Bottomscreens = [
    Favorites(),
    Search(),
    Product(),
    Categories(),
    Profile(),
  ];
  void changeBottomIndex(int index) {
    if (index == 0) {
      getFavorite();
    }

    currentIndex = index;
    emit(ChangeBottomNaviBarState());
  }

  Map<int, bool> favoritList = {};
  Map<int, bool> cartList = {};

  HomeModel? homeModel;

  void getHome() async {
    emit(HomeLoadingState());
    await DioHelper.getdata(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel);
      homeModel?.data?.products.forEach((element) {
        favoritList.addAll({element.id: element.inFavorites});
        cartList.addAll({element.id: element.inCart});
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error);
      print(error.toString());
      emit(HomeErrorState(error));
    });
  }

  //CATEGORY
  categories? categoryMdel;
  void getCategory() async {
    emit(CategoryLoadingState());
    await DioHelper.getdata(url: CATEGORY, token: token).then((value) {
      categoryMdel = categories.fromJson(value.data);
      print(categoryMdel);
      emit(CategorySuccessState());
    }).catchError((error) {
      print("error");
      print(error.toString());
      emit(CategoryErrorState(error));
    });
  }

  Favorit? favoritModel;
  void changeFavorite(productId) {
    favoritList[productId] = !(favoritList[productId] ?? null)!;
    emit(FavoritChangeState());
    DioHelper.postData(
      url: FAVORITE,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoritModel = Favorit.fromJson(value.data);
      if (!(favoritModel?.status ?? null)!) {
        favoritList[productId] = !(favoritList[productId] ?? null)!;
      }
      print('add to fav');
      print(value.data);
      emit(FavoritChangeSuccessState(favoritModel));
    }).catchError((error) {
      print(error);
      emit(FavoritChangeErrorState(error));
    });
  }

  FavoritProduct? favoritProduct;
  void getFavorite() async {
    emit(FavoritLoadingState());
    await DioHelper.getdata(url: FAVORITE, token: token).then((value) {
      favoritProduct = FavoritProduct.fromJson(value.data);
      print(favoritProduct);
      emit(FavoritSuccessState());
    }).catchError((error) {
      print("error favorit");
      print(error.toString());
      emit(FavoritErrorState(error));
    });
  }

  Carts? cartProduct;
  void getCart() async {
    emit(LoadingCartstate());
    await DioHelper.getdata(url: CART, token: token).then((value) {
      cartProduct = Carts.fromJson(value.data);
      print(cartProduct);
      emit(SuccessCartstate(cartProduct));
    }).catchError((error) {
      print("error cart");
      print(error.toString());
      emit(ErrorCartstate(error));
    });
  }

  Favorit? cartModel;
  changeCart(productId) {
    cartList[productId] = !(cartList[productId])!;
    emit(ChangeCartState());
    DioHelper.postData(
      url: CART,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      cartModel = Favorit.fromJson(value.data);
      if (!(cartModel?.status ?? null)!) {
        cartList[productId] = !(cartList[productId] ?? null)!;
      }
      print('add to carts');
      print(value.data);
      emit(ChangeCartSuccessState(cartModel));
    }).catchError((error) {
      print("cart error");
      print(error);
      emit(ChangeCartErrorState(error));
    });
  }

  ShopLoginModel? profile;
  void getProfile() async {
    await DioHelper.getdata(url: PROFILE, token: token).then((value) {
      profile = ShopLoginModel.fromJson(value.data);
      emit(ProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ProfileErrorState(error));
    });
  }

  PickedFile? imageFile;
  var imageProfileUrl;

  final ImagePicker _picker = ImagePicker();

  void pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);

      imageFile = pickedFile;
      DioHelper.uploadImage(imageFile, UPDATEPROFILE, token).then((value) {
        print(value);
        imageProfileUrl = value;
      });
    } catch (e) {
      print("Image picker error " + "$e");
    }
  }

  void userUpdate(
      {required String email,
      required String name,
      required String password,
      required String phone}) async {
    emit(EditProfileLoading());
    await DioHelper.putData(url: UPDATEPROFILE, token: token, data: {
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
    }).then((value) {
      profile = ShopLoginModel.fromJson(value.data);
      emit(EditProfileSucces(profile));
    }).catchError((error) {
      print(error);
      emit(EditProfileError());
    });
  }
}

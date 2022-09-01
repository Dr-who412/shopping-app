import 'package:shopping/models/shopHomemodels/favorite_Model.dart';
import 'package:shopping/models/shopHomemodels/shopHomemodel.dart';
import 'package:shopping/modules/home_modules/home_cubit/cubit.dart';
import 'package:shopping/modules/home_modules/profile/editProfile.dart';

abstract class ShopHomeStatus {}

class IntilHomestate extends ShopHomeStatus {}

class ChangeBottomNaviBarState extends ShopHomeStatus {}

class HomeLoadingState extends ShopHomeStatus {}

class HomeSuccessState extends ShopHomeStatus {}

class HomeErrorState extends ShopHomeStatus {
  final error;
  HomeErrorState(this.error);
}

class CategoryLoadingState extends ShopHomeStatus {}

class CategorySuccessState extends ShopHomeStatus {}

class CategoryErrorState extends ShopHomeStatus {
  final error;
  CategoryErrorState(this.error);
}

class FavoritChangeState extends ShopHomeStatus {}

class FavoritChangeSuccessState extends ShopHomeStatus {
  final model;
  FavoritChangeSuccessState(this.model);
}

class FavoritChangeErrorState extends ShopHomeStatus {
  final error;
  FavoritChangeErrorState(this.error);
}

class FavoritLoadingState extends ShopHomeStatus {}

class FavoritSuccessState extends ShopHomeStatus {}

class FavoritErrorState extends ShopHomeStatus {
  final error;
  FavoritErrorState(this.error);
}

class LoadingCartstate extends ShopHomeStatus {}

class SuccessCartstate extends ShopHomeStatus {
  final cartModel;
  SuccessCartstate(this.cartModel);
}

class ErrorCartstate extends ShopHomeStatus {
  final error;
  ErrorCartstate(this.error);
}

class ChangeCartState extends ShopHomeStatus {}
class ChangeCartSuccessState extends ShopHomeStatus {
  final cartModel;
  ChangeCartSuccessState(this.cartModel);
}
class ChangeCartErrorState extends ShopHomeStatus {
  final error;
  ChangeCartErrorState(this.error);
}


class ProfileSuccessState extends ShopHomeStatus {}

class ProfileErrorState extends ShopHomeStatus {
  final error;
  ProfileErrorState(this.error);
}

class EditProfileSucces extends ShopHomeStatus {
  final updatemodel;
  EditProfileSucces(this.updatemodel);
}

class EditProfileLoading extends ShopHomeStatus {}

class EditProfileError extends ShopHomeStatus {}

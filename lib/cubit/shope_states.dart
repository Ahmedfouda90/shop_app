import '../models/login_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates{}
class HomeSuccessState extends ShopStates{}
class HomeErrorState extends ShopStates{
  final String error;

  HomeErrorState(this.error);
}
class HomeLoadingState extends ShopStates{}
class ShopChangeBottomBarState extends ShopStates{}
class CategoriesSuccessState extends ShopStates{}
class CategoriesErrorState extends ShopStates{
  final String error;

  CategoriesErrorState(this.error);
}
class CategoriesFavoriteSuccessState extends ShopStates{}
class CategoriesFavoriteErrorState extends ShopStates{
  final String error;

  CategoriesFavoriteErrorState(this.error);
}


class UserDataLoadingState extends ShopStates{}
class UserDataSuccessState extends ShopStates{
  final LoginModel? loginModel;

  UserDataSuccessState(this.loginModel);
}
class UserDataErrorState extends ShopStates{
  final String error;

  UserDataErrorState(this.error);
}

class UpdateUserLoadingState extends ShopStates{}
class UpdateUserSuccessState extends ShopStates{
  final LoginModel? loginModel;

  UpdateUserSuccessState(this.loginModel);
}
class UpdateUserErrorState extends ShopStates{
  final String error;

  UpdateUserErrorState(this.error);
}







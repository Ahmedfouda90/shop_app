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











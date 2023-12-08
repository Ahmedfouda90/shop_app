import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/consts/consts.dart';
import 'package:shop_app/cubit/shope_states.dart';
import 'package:shop_app/layers/shop_layers/categories.dart';
import 'package:shop_app/layers/shop_layers/favourites.dart';
import 'package:shop_app/layers/shop_layers/prooducts.dart';
import 'package:shop_app/layers/shop_layers/settings.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  List<String> title = [
    'Home Screen',
    'Category Screen',
    'Favourites Screen',
    'Settings Screen',
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomBarState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: kHome, token: token).then((value) {
      print(value);
      if (homeModel == null) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data!.products.forEach((element) {
          favourite.addAll({element.id!: element.inFavorites!});
        });
        print(favourite.toString());
        // print(homeModel!.data!.banners[0].image);
        // print(homeModel!.status);
        emit(HomeSuccessState());
      } else {
        emit(HomeSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    // emit(HomeLoadingState());

    DioHelper.getData(url: kGetCategories, token: token).then((value) {
      print(value);

      categoriesModel =
          CategoriesModel.fromJson(value.data); // Update categoriesModel

      if (categoriesModel != null) {
        emit(CategoriesSuccessState());
      } else {
        emit(CategoriesErrorState('failed in categories model'));
      }
      /* print(value);

      if (categoriesModel != null) {
        emit(CategoriesSuccessState());
      } else {
        emit(CategoriesErrorState("Failed to parse data"));
      }*/
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesErrorState(error.toString()));
    });

    /*  if (categoriesModel == null) {
        categoriesModel = CategoriesModel.fromJson(value.data);

        emit(CategoriesSuccessState());
      } else {
        emit(CategoriesSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesErrorState(error.toString()));
    });*/
  }

  Map<int, bool> favourite = {};

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorite(int productId) {
    DioHelper.postData(url: kFavorites, data: {'product_id': productId})
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      print(value.data);
      emit(CategoriesFavoriteSuccessState());
    }).catchError((error) {
      emit(CategoriesFavoriteErrorState(error.toString()));
      print(error.toString());
    });
  }

  // LoginModel? userModel;

  void getUserData() {
    emit(UserDataLoadingState());
    DioHelper.getData(url: kLogin, token: token).then((value) {
      print(value);
      if (userModel == null) {
        userModel = LoginModel.fromJson(value.data);

        print(value.data.toString());
        // print(homeModel!.data!.bann
        // ers[0].image);
        // print(homeModel!.status);
        emit(UserDataSuccessState(userModel));
      } else {
        emit(UserDataSuccessState(userModel));
      }
    }).catchError((error) {
      print(error.toString());
      emit(UserDataErrorState(error.toString()));
    });
  }

  LoginModel? userModel;

  void updateUserData({
    @required String? name,
    @required String? email,
    @required String? phone,
  }) {
    emit(UpdateUserLoadingState());
    DioHelper.putData(url: kUpdateProfile, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }, query: {}).then((value) {
      print(value);
      if (value.data != null) {
        if (value.data is Map<String, dynamic>) {
          userModel = LoginModel.fromJson(value.data);
          print(value.data.toString());
          emit(UpdateUserSuccessState(userModel!));
        }else {
          print('Unexpected response data type: ${value.data.runtimeType}');
          emit(UpdateUserErrorState('Unexpected response data type'));
        }
      } else {
        // Handle the case where response data is null
        emit(UpdateUserErrorState('Response data is null'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserErrorState(error.toString()));
    });
  }
}

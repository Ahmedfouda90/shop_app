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
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = const [
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
    emit(ShopLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      if (homeModel == null) {
        homeModel = HomeModel.fromJson(value.data);
        // print(homeModel!.data!.banners[0].image);
        // print(homeModel!.status);
        emit(ShopSuccessState());
      } else {
        emit(ShopSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorState(error.toString()));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shope_states.dart';
import 'package:shop_app/custom_widgets/custom_widgets.dart';
import 'package:shop_app/layers/singn_in_and_sign_up/login_screen.dart';
import 'package:shop_app/layers/shop_layers/search.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            // title: Text(shopCubit.title[shopCubit.currentIndex]),
            actions: [

              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: shopCubit.bottomScreens[shopCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              shopCubit.changeBottom(index);
            },
            currentIndex: shopCubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined), label: 'categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: 'favourites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings'),

            ],
          ),
        );
      },
    );
  }
}

/*  CacheHelper.removeData(key: 'token').then((value) {
                if (value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              });*/

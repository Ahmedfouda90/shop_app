import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/consts/consts.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/cubit/login_cubit.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/layers/home_screen.dart';
import 'package:shop_app/layers/singn_in_and_sign_up/login_screen.dart';
import 'package:shop_app/layers/onboarding_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key:'onBoarding');
  token = CacheHelper.getData(key:'token');
  if(onBoarding!=null){
    if(token!=null)
      widget=HomeScreen();
    else
      widget=LoginScreen();

  }else {
    widget=OnBoardingScreen();
  }
  print(onBoarding);
  runApp(ShopApp(startWidget:widget));
}

class ShopApp extends StatelessWidget {
  final Widget? startWidget;
  const ShopApp({super.key,this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getUserData()),
        // BlocProvider(    create: (context) => CategoriesCubit(CategoriesService(Dio()))),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnBoardingScreen(),

        // Scaffold(body:Center(child: YourWidgetContent/*OnBoardingScreen*/()) ,),
        theme: ThemeData(

          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            titleSpacing: 20.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepOrange,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.black,
            elevation: 90.0,
            backgroundColor: Colors.grey,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor:  Colors.black26/*HexColor('333739')*/,
          backgroundColor: Colors.black26/*HexColor('333739')*/,
          appBarTheme: const AppBarTheme(
            titleSpacing: 20.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black26/*HexColor('333739')*/,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: Colors.black26/*HexColor('333739')*/,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepOrange,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.white,
            elevation: 20.0,
            backgroundColor: Colors.grey,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),

      ),
    );
  }
}

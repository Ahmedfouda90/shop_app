import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login_states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

 static  LoginCubit get(context) => BlocProvider.of(context);
  LoginModel?  loginModel;

  void userLogin({
    @required String? email,
    @required String? password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      print(value.data);
      print(value.data['message']);
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  Widget suffixIcon = Icon(Icons.visibility);
  bool isPassword = false;

  void changePassword() {
    isPassword = !isPassword;
    emit(LoginPasswordState());
    /*suffixIcon =
    isPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off);*/
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login_states.dart';
import 'package:shop_app/cubit/register_states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void userRegister({
    @required String? email,
    @required String? password,
    @required String? phone,
    @required String? name,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: kRegister,
      data: {
        'email': email,
        'password': password,
        'phone': phone,
        "name": name
      },
    ).then((value) {
      print(value.data);
      print(value.data['message']);
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  Widget suffixIcon = Icon(Icons.visibility);
  bool isPassword = false;

  void changePassword() {
    isPassword = !isPassword;
    emit(RegisterPasswordState());
    /*suffixIcon =
    isPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off);*/
  }
}

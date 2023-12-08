import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/consts/consts.dart';
import 'package:shop_app/cubit/login_states.dart';
import 'package:shop_app/cubit/register_cubit.dart';
import 'package:shop_app/cubit/register_states.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shope_states.dart';
import 'package:shop_app/custom_widgets/custom_widgets.dart';
import 'package:shop_app/layers/home_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

import '../../cubit/login_cubit.dart';
import '../../custom_widgets/text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              if (state.loginModel.status! /*!= null*/) {
                print(state.loginModel.status);
                print(state.loginModel.data!.name);
                Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  textColor: Colors.black54,
                  fontSize: 18,
                  backgroundColor: Colors.red,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  toastLength: Toast.LENGTH_LONG,
                );
                CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                    .then((value) {
                  token = state.loginModel.data!.token!;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                });
              } else {
                print(state.loginModel.message);
                Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  textColor: Colors.black54,
                  fontSize: 18,
                  backgroundColor: Colors.yellow,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  toastLength: Toast.LENGTH_LONG,
                );
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: 'LOGIN',
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomTextField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter name ';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          onTap: () {},
                          hint: 'name',
                          prefix: Icon(Icons.drive_file_rename_outline),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter phone ';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          onTap: () {},
                          hint: 'phone',
                          prefix: Icon(Icons.phone),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter email ';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          onTap: () {},
                          hint: 'email',
                          prefix: Icon(Icons.email),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          obscureText: RegisterCubit.get(context).isPassword,
                          suffix: IconButton(
                              onPressed: () {
                                RegisterCubit.get(context).changePassword();
                              },
                              icon: RegisterCubit.get(context).isPassword
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter password';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          onTap: () {},
                          hint: 'hello',
                          prefix: Icon(Icons.add),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        state is RegisterLoadingState
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text ,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  color: Colors.blue,
                                  child: Center(
                                    child: customText(
                                        text: 'Register',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22,
                                        textColor: Colors.white),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login_cubit.dart';
import 'package:shop_app/cubit/login_states.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/custom_widgets/text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layers/home_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import '../custom_widgets/custom_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
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
                        hint: 'hello',
                        prefix: Icon(Icons.add),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        obscureText: LoginCubit
                            .get(context)
                            .isPassword,
                        suffix: IconButton(
                            onPressed: () {
                              LoginCubit.get(context).changePassword();
                            },
                            icon: LoginCubit
                                .get(context)
                                .isPassword
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
                      state is LoginLoadingState
                          ? Center(
                        child: CircularProgressIndicator(),
                      )
                          : GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                            print('success');
                            print(emailController.text);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Colors.blue,
                          child: Center(
                            child: customText(
                                text: 'login',
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                textColor: Colors.white),
                          ),
                        ),
                      )
                      ,
                      SizedBox(height: 50,),
                      GestureDetector(
                        onTap: () {
                          ShopCubit.get(context).getHomeData();
                          print(  ShopCubit.get(context).homeModel);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));

                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Colors.blue,
                          child: Center(
                            child: customText(
                                text: 'login',
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
        },
      ),
    );
  }
}

/*
Widget customTextField(
        {String? hint,
        Widget? prefix,
        Widget? suffix,
        void Function()? onTap,
        void Function(String)? onChanged}) =>
    TextFormField(
      onTap: () {},
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: '',
        prefixIcon: Icon(Icons.add),
        suffixIcon: Icon(Icons.add),
      ),
    );
*/

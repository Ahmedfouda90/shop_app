import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/consts/consts.dart';
import 'package:shop_app/cubit/login_states.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shope_states.dart';
import 'package:shop_app/custom_widgets/custom_widgets.dart';
import 'package:shop_app/custom_widgets/text_field.dart';
import 'package:shop_app/layers/home_screen.dart';
import 'package:shop_app/models/login_model.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).userModel;
          if (model != null && model.data != null) {
            nameController.text = model.data!.name!;
            emailController.text = model.data!.email!;
            phoneController.text = model.data!.phone!;
          }
          /*nameController.text = model!.data!.name!;
      emailController.text = model.data!.email!;
      phoneController.text = model.data!.phone!;*/
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  if (state is UpdateUserLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      hint: 'name',
                      prefix: Icon(Icons.person),
                      onTap: () {},
                      onChanged: (va) {},
                      suffix: Icon(Icons.person),
                      controller: nameController,
                      validator: (v) {}),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      hint: 'phone',
                      prefix: Icon(Icons.person),
                      onTap: () {},
                      onChanged: (va) {},
                      suffix: Icon(Icons.phone),
                      controller: phoneController,
                      validator: (v) {}),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    hint: 'email',
                    prefix: Icon(Icons.email),
                    onTap: () {},
                    onChanged: (v) {},
                    suffix: Icon(Icons.person),
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
/*
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));*/
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.blue,
                      child: Center(
                        child: customText(
                            text: 'UPDATE',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            textColor: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      signOut(context);
/*
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));*/
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.blue,
                      child: Center(
                        child: customText(
                            text: 'LOGOUT',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            textColor: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ConditionalWidget extends StatelessWidget {
  final bool condition;
  final Widget Function(BuildContext context) builderIfTrue;
  final Widget Function(BuildContext context) builderIfFalse;

  ConditionalWidget({
    required this.condition,
    required this.builderIfTrue,
    required this.builderIfFalse,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? builderIfTrue(context) : builderIfFalse(context);
  }
}

/*  ShopCubit
            .get(context)
            .userModel == null
            ?   Center(child: CircularProgressIndicator())
            : Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 30,),
              CustomTextField(
                  hint: 'name',
                  prefix: Icon(Icons.person),
                  onTap: () {},
                  onChanged: (va) {},
                  suffix: Icon(Icons.person),
                  controller: nameController,
                  validator: (v) {}),
              SizedBox(height: 30,),

              CustomTextField(
                  hint: 'phone',
                  prefix: Icon(Icons.person),
                  onTap: () {},
                  onChanged: (va) {},
                  suffix: Icon(Icons.phone),
                  controller: phoneController,
                  validator: (v) {}),
              SizedBox(height: 30,),

              CustomTextField(
                hint: 'email',
                prefix: Icon(Icons.email),
                onTap: () {},
                onChanged: (v) {},
                suffix: Icon(Icons.person),
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter password';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    ShopCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,

                    );
                  }
/*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()));*/
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: customText(
                        text: 'UPDATE',
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        textColor: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () {

/*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()));*/
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: customText(
                        text: 'LOGOUT',
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        textColor: Colors.white),
                  ),
                ),
              ),

            ],
          ),
        );*/

/*
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).userModel != null
            ? Column(
                children: [
                  CustomTextField(
                      hint: 'name',
                      prefix: Icon(Icons.person),
                      onTap: () {},
                      onChanged: (va) {},
                      suffix: Icon(Icons.person),
                      controller: nameController,
                      validator: (v) {}),
                  CustomTextField(
                      hint: 'phone',
                      prefix: Icon(Icons.person),
                      onTap: () {},
                      onChanged: (va) {},
                      suffix: Icon(Icons.phone),
                      controller: phoneController,
                      validator: (v) {}),
                  CustomTextField(
                    hint: 'email',
                    prefix: Icon(Icons.email),
                    onTap: () {},
                    onChanged: (v) {},
                    suffix: Icon(Icons.person),
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter password';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
*/

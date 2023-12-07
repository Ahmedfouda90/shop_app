import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shope_states.dart';
import 'package:shop_app/custom_widgets/custom_widgets.dart';
import 'package:shop_app/layers/shop_layers/prooducts.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CategoriesModel? categoriesModel =
            ShopCubit.get(context).categoriesModel;

        return categoriesModel != null|| categoriesModel!.data == null?Scaffold(
            body: ListView.separated(
                itemBuilder: (context, index) {
                  if (index < categoriesModel.data!.data!.length) {
                    // Check if the index is within the bounds of the data list
                    return categoriiesItems(categoriesModel.data!.data![index]);
                  } else {
                    // Handle the case when the index is out of bounds
                    return Container(
                      width: 50,
                        height: 50,
                      color: Colors.red,
                    );
                  }
                },
                separatorBuilder: (context, index) => Divider(
                      height: 5,
                      color: Colors.blue,
                    ),
                itemCount: categoriesModel.data!.data!.length)):const Center(
                  child: CircularProgressIndicator(
          color: Colors.red,
        ),
                );
      },
    );
  }
}
Widget categoriiesItems(DataModel dataModel) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              dataModel.image!,
            ),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10,),
          customText(
              text: dataModel.name!,
              textColor: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );

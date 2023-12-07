import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shope_states.dart';
import 'package:shop_app/custom_widgets/custom_widgets.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

// import 'carousel';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ShopCubit.get(context).homeModel != null &&
                      ShopCubit.get(context).categoriesModel != null
              ? productsBuilder(
                  ShopCubit.get(context)
                      .homeModel!, ShopCubit.get(context).categoriesModel!,context
                )
              : const Center(
                  child: CircularProgressIndicator(
                        backgroundColor: Colors.red, color: Colors.green),
                ),
        );
      },
    );
  }
}

Widget productsBuilder(
  HomeModel? model,
   CategoriesModel? categoriesModel,context
) {
  if (model == null || model.data == null || model.data!.banners.isEmpty) {
    print('error productsBuilder');
    // Handle the case when the data is null or empty
    return Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    ); // Or any other appropriate widget
  }
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data!.banners
              .map((e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ))
              .toList(),
          options: CarouselOptions(
              viewportFraction: 1,
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              scrollDirection: Axis.horizontal),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: 'Categories',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        categoryItems(categoriesModel.data!.data![index]),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                    itemCount: categoriesModel!.data!.data!.length),
              ),
              SizedBox(
                height: 20,
              ),
              customText(
                text: 'New Products',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        if (model.data!.products != null && model.data!.products.isNotEmpty)
          ClipRRect(
            clipBehavior: Clip.none,
            child: GridView.count(
              clipBehavior: Clip.none,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1 / 1.7,
              children: List.generate(model.data!.products.length,
                  (index) => gridProduct(model.data!.products[index],context)),
            ),
          )
      ],
    ),
  );
}

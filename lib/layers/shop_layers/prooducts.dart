import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shope_states.dart';
import 'package:shop_app/custom_widgets/custom_widgets.dart';
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
          body: state is! ShopLoadingState ||
                  ShopCubit.get(context).homeModel != null
              ? productsBuilder(ShopCubit.get(context).homeModel!)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}

Widget productsBuilder(HomeModel? model) {
  if (model == null || model.data == null || model.data!.banners.isEmpty) {
    // Handle the case when the data is null or empty
    return Center(
      child: CircularProgressIndicator(),
    ); // Or any other appropriate widget
  }
  return SingleChildScrollView(
    child: Column(
      children: [
        CarouselSlider(
          items: model!.data!.banners
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
          height: 20,
        ),
        if (model.data!.products != null)
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
                  (index) => gridProduct(model.data!.products[index])),
            ),
          )
      ],
    ),
  );
}

Widget gridProduct(ProductModel model) {
  if (model.image == null) {
    // Handle the case when the image is null
    return Center(
      child: CircularProgressIndicator(),
    ); // Or any other appropriate widget
  }
  return Column(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: double.infinity,
            fit: BoxFit.cover,
            height: 200,
          ),
          if (model.discount != 0)
            Container(
              // height: 15,
              // width: 50,
              color: Colors.red,
              child: const Text(
                'DISCOUNT',
                style: TextStyle(color: Colors.white, fontSize: 8),
              ),
            )
        ],
      ),
      customText(
        maxLines: 2,
        text: model.name,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText(
              textColor: Colors.red,
              maxLines: 3,
              text: '${model.price.round()}',
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            SizedBox(width: 10,),
            if (model.discount != 0)
              customText(
                textColor: Colors.grey,
                maxLines: 3,
                text: '${model.oldPrice.round()}',
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border,size: 20,))
          ],
        ),
      ),
    ],
  );
}

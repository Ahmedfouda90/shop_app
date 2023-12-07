import 'package:flutter/material.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

Widget obBoarding(BoardingModel model) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: Image.asset('${model.image}')),
        const SizedBox(
          height: 100,
        ),
        customText(
            fontSize: 20, fontWeight: FontWeight.w600, text: '${model.title}'),
        const SizedBox(
          height: 30,
        ),
        customText(
            fontSize: 20, fontWeight: FontWeight.w600, text: '${model.body}'),
      ],
    );

Widget customText(
        {final double? fontSize,
        final Color textColor = Colors.black,
        final String? text,
        final int? maxLines,
        final FontWeight fontWeight = FontWeight.normal}) =>
    Text(
      '${text}',
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
      textAlign: TextAlign.center,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );

Widget gridProduct(ProductModel model,context) {
  if (model.image == null) {
    // Handle the case when the image is null
    return Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
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
            SizedBox(
              width: 10,
            ),
            if (model.discount != 0)
              customText(
                textColor: Colors.grey,
                maxLines: 3,
                text: '${model.oldPrice.round()}',
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            Spacer(),
            GestureDetector(
              onTap: (){
              ShopCubit.get(context).changeFavorite(model.id!);
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: (ShopCubit.get(context).favourite[model.id] ?? true)
                    ? Colors.deepOrange
                    : Colors.green,
                child: Center(
                  child: Icon(
                    Icons.favorite_border,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget categoryItems(DataModel dataModel) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
            dataModel.image!,
          ),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(.8),
          child: customText(
              text: dataModel.name!,
              textColor: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        )
      ],
    );

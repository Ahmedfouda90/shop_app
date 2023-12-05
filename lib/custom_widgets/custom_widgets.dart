import 'package:flutter/material.dart';

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
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );

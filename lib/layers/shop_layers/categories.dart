import 'package:flutter/material.dart';
import 'package:shop_app/custom_widgets/custom_widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: customText(
            fontSize: 18,
            textColor: Colors.black54,
            fontWeight: FontWeight.w700,
            text: 'products screen'
        ),
      ),
    );
  }
}

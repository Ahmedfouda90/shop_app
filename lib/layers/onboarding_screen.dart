import 'package:flutter/material.dart';
import 'package:shop_app/custom_widgets/custom_widgets.dart';
import 'package:shop_app/layers/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/mobile-app-onboarding.jpg',
        title: 'on boarding 1',
        body: 'body1'),
    BoardingModel(
        image: 'assets/images/mobile-app-onboarding1.jpg',
        title: 'on boarding 2',
        body: 'body2'),
    BoardingModel(
        image: 'assets/images/mobile-app-onboarding2.jpg',
        title: 'on boarding 3',
        body: 'body3'),
  ];

  var pageController = PageController();

  int? currentIndex;

  bool? isLast = false;
    void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:           GestureDetector(
          child: Text('skip'),
          onTap: () {
            submit();
          },
        )
        ,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
              ),
              Expanded(
                child: PageView.builder(
                    onPageChanged: (index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                        print('last');
                      } else {
                        setState(() {
                          isLast = false;
                        });
                        print('not last');
                      }
                    },
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        obBoarding(boarding[index]),
                    itemCount: boarding.length),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 10,
                        dotColor: Colors.grey),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast!) {
                       submit();
                      } else {
                        pageController.nextPage(
                            duration: Duration(microseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

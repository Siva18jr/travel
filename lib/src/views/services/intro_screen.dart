import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/custom_fonts.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("firstInstall", false).then((value){

      Navigator.pushNamed(context, RoutesName.homeActivity);

    });

  }

  Widget _buildImage(String assetName, [double width = 350]) {

    return Image.asset(
        'assets/images/$assetName',
        width: width
    );

  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700
      ),
      bodyTextStyle: TextStyle(
          fontSize: 19.0
      ),
      bodyPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return PopScope(
      canPop: false,
      child: IntroductionScreen(
        key: introKey,
        allowImplicitScrolling: true,
        globalBackgroundColor: AppColors.whiteColor,
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        back: const Icon(
            Icons.arrow_back,
          color: AppColors.whiteColor,
        ),
        next: const Text(
            'Next',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor
            )
        ),
        done: const Text(
            'Finish',
            style: TextStyle(
                fontWeight: FontWeight.w600,
              color: AppColors.whiteColor
            )
        ),
        skip: Container(
          padding: const EdgeInsets.only(
              left: 18
          ),
          height: (screenHeight / 6) - 30,
          child: const Center(
              child: Text(
                  'Skip',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor
                  )
              )
          ),
        ),
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(0, 0, 0, 0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator:  const BoxDecoration(
            color: AppColors.appPrimaryColor,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)
            )
        ),
        pages: [
          PageViewModel(
            titleWidget: _buildImage('intro_one.png'),
            bodyWidget: const Padding(
              padding: EdgeInsets.only(
                  top: 15
              ),
              child: Column(
                children: [
                  Text(
                      "Beautiful Travel info's",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: CustomFonts.gilroyBold,
                      color: AppColors.denimBlueColor
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Look at the chill and adventures places\nand visit them happily...",
                    style: TextStyle(
                      color: AppColors.greyColor100,
                        fontFamily: CustomFonts.gilroyBlack
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            decoration: pageDecoration.copyWith(
              contentMargin: const EdgeInsets.symmetric(
                  horizontal: 8
              ),
              fullScreen: true,
              bodyFlex: 5,
              safeArea: 100,
            ),
          ),
          PageViewModel(
            titleWidget: _buildImage('intro_two.png'),
            bodyWidget: const Padding(
              padding: EdgeInsets.only(
                  top: 15
              ),
              child: Column(
                children: [
                  Text(
                    "Make Memories",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: CustomFonts.gilroyBold,
                        color: AppColors.denimBlueColor
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Visit the beautiful places every month\nand create memories",
                    style: TextStyle(
                        color: AppColors.greyColor100,
                      fontFamily: CustomFonts.gilroyBlack
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            decoration: pageDecoration.copyWith(
              contentMargin: const EdgeInsets.symmetric(horizontal: 8),
              fullScreen: true,
              bodyFlex: 5,
              safeArea: 100,
            ),
          ),
          PageViewModel(
            titleWidget: _buildImage('intro_three.png'),
            // title: "Fresh cooking essentials",
            bodyWidget: Padding(
              padding: const EdgeInsets.only(
                  top: 15
              ),
              child: Column(
                children: [
                  const Text(
                    "Quick and Easy",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: CustomFonts.gilroyBold,
                        color: AppColors.denimBlueColor
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: screenWidth - 45,
                    child: const Text(
                      'Now enjoy the free experience of \ngetting clear info of places.',
                      style: TextStyle(
                          color: AppColors.greyColor100,
                          fontFamily: CustomFonts.gilroyBlack
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            decoration: pageDecoration.copyWith(
              contentMargin: const EdgeInsets.symmetric(horizontal: 8),
              fullScreen: true,
              bodyFlex: 5,
              safeArea: 100,
            ),
          ),
        ],
      ),
    );

  }

}
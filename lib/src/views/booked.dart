import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:levitate/src/model/provider_state/booking_placed.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:provider/provider.dart';

class Booked extends StatefulWidget {

  final String bookingAmount;
  final String hotel;
  final String peoples;

  const Booked({super.key, required this.bookingAmount, required this.hotel, required this.peoples});

  @override
  State<Booked> createState() => _BookedState();
}

class _BookedState extends State<Booked> {

  final ConfettiController _controller = ConfettiController();

  @override
  void initState() {

    super.initState();

    Future<dynamic>.delayed(const Duration(seconds: 1), ()=> _controller.play());

    Future<dynamic>.delayed(const Duration(seconds: 15), ()=> Navigator.pushNamed(context, RoutesName.homeActivity));

  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    Future<dynamic>.delayed(const Duration(seconds: 5), ()=> _controller.stop());

    return PopScope(
      onPopInvoked: (val){

        WidgetsBinding.instance.addPostFrameCallback((_) {

          Navigator.pushNamed(context, RoutesName.homeActivity);

        });

      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pushNamed(context, RoutesName.homeActivity),
            child: const Icon(
              Icons.arrow_back
            ),
          )
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Consumer<BookingPlaced>(
                builder: (BuildContext context, BookingPlaced value, _){

                  Future<dynamic>.delayed(const Duration(seconds: 2), ()=> value.setIsBookingPlaced(true));

                  return Scaffold(
                      body: value.isBookingPlaced == true ?
                      FadeIn(
                        duration: const Duration(seconds: 2),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: screenHeight / 6,
                                  color: AppColors.greenColor
                              ),
                              SizedBox(
                                  height: screenHeight * 0.01
                              ),
                              Text(
                                  'Booked SuccessFully for ${widget.peoples}people\nat ${widget.hotel}',
                                  style: const TextStyle(
                                      color: AppColors.appPrimaryColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                textAlign: TextAlign.center
                              )
                            ],
                          ),
                        ),
                      ) :
                      Center(
                        child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SlideInLeft(
                                  duration: const Duration(seconds: 2),
                                  child: SvgPicture.asset(
                                    'assets/images/flight_take_off.svg',
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.appPrimaryColor,
                                        BlendMode.srcIn
                                    ),
                                    width: screenWidth * 0.1,
                                    height: screenHeight * 0.1,
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                  );

                }
            ),
            ConfettiWidget(
              confettiController: _controller,
              blastDirection: pi / 2,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){},
          child: Center(
            child: Text(
              '₹${widget.bookingAmount}'
            )
          )
        )
      )
    );

  }

}
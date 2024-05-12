import 'dart:io';

import 'package:checkout_screen_ui/checkout_page/checkout_page.dart';
import 'package:checkout_screen_ui/models/price_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levitate/src/model/api_models/booking_model.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:levitate/src/view_model/booking_view_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class Booking extends StatefulWidget {

  final String bookingAmount;
  final String hotel;
  final String peoples;
  final String date;

  const Booking({super.key, required this.bookingAmount, required this.hotel, required this.peoples, required this.date});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  final Razorpay _razorpay = Razorpay();
  final Uuid _uuid = const Uuid();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final BookingViewModel _bookingViewModel = BookingViewModel();

  // Future<void> _openPayment() async{
  //
  //   Map<String,dynamic> options = <String,dynamic>{
  //     'key': 'rzp_test_1DP5mmOlF5G5ag',
  //     'amount': int.parse(widget.bookingAmount) * 100,
  //     'name': 'Levitate',
  //     'description': 'pay for booking',
  //     'retry': <String,dynamic>{'enabled': true, 'max_count': 1},
  //     'send_sms_hash': true,
  //     'prefill': <String,dynamic>{
  //       'contact': '8888888888',
  //       'email': 'test@razorpay.com'
  //     },
  //     'external': <String,dynamic>{
  //       'wallets': <String>['paytm']
  //     }
  //   };
  //
  //   try{
  //
  //     _razorpay.open(options);
  //
  //   }catch(e){
  //
  //     log(e.toString());
  //
  //   }
  //
  // }

  @override
  void initState() {

    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

  }

  @override
  void dispose() {

    super.dispose();
    _razorpay.clear();

  }

  @override
  Widget build(BuildContext context) {

    final List<PriceItem> priceItems = [
      PriceItem(name: widget.hotel, quantity: int.parse(widget.peoples), itemCostCents: int.parse(widget.bookingAmount) * 100),
      PriceItem(name: 'Agent Fee', quantity: 1,  itemCostCents: 8500),
    ];

    return Scaffold(
      body: CheckoutPage(
       data: CheckoutData(
         priceItems: priceItems,
         taxRate: 0.07, // 7% tax rate
         payToName: 'Levitate',
         displayNativePay: true,
         onNativePay: (checkoutResults) => Utils.toastMessage(
             message: 'Currently not available',
             bgColor: AppColors.redColor
         ),
         isApple: Platform.isIOS,
         onCardPay: (paymentInfo, checkoutResults){

           final Map<String,dynamic> data = BookingDataModel(
             uId: _firebaseAuth.currentUser!.uid,
             name: paymentInfo.name,
             email: paymentInfo.email,
             hotelName: widget.hotel,
             personsCount: widget.peoples,
             bookingAmount : widget.bookingAmount,
             totalAmount: (checkoutResults.totalCostCents / 100).toString(),
             days: widget.date,
             daysCount: '1',
             paidOn: DateTime.now().toString(),
             paymentId: _uuid.v4()
           ).toJson();

           _bookingViewModel.postBookingDetailsApi(_uuid.v4(), data).then((value){

             Navigator.pushNamed(context, RoutesName.bookedActivity, arguments: <String>[widget.bookingAmount, widget.hotel, widget.peoples]);
             Utils.snackBar(
                 message: 'Hotel booked',
                 context: context
             );

           }).onError((error, stackTrace){

             Utils.snackBar(
                 message: 'Error with Payment',
                 context: context
             );

           });

           // log('${paymentInfo.name}-${paymentInfo.phone}-${paymentInfo.email}-${paymentInfo.country}');

         } ,
         onBack: ()=> Navigator.of(context).pop()
       ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: ()=> _openPayment('100'),
      //   child: Icon(
      //     Icons.currency_rupee
      //   )
      // ),
      // bottomNavigationBar: SlideAction(
      //   borderRadius: 12,
      //   elevation: 0,
      //   innerColor: Colors.amber,
      //   outerColor: Colors.amber.shade100,
      //   sliderButtonIcon: const Icon(
      //     Icons.currency_rupee,
      //   ),
      //   text: "Slide to Pay ₹${widget.bookingAmount}",
      //   sliderRotate: false,
      //   textStyle: const TextStyle(
      //       color: AppColors.blackColor,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20
      //   ),
      //   onSubmit: () => _openPayment()
      // ),
    );

  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {

    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.code}");

  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {

    showAlertDialog(context, "Payment success", "${response.paymentId}");
    Navigator.pushNamed(context, RoutesName.bookedActivity, arguments: <String>[widget.bookingAmount, widget.hotel, widget.peoples]);
    Utils.snackBar(
        message: 'Hotel booked',
        context: context
    );

  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {

    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");

  }

  void showAlertDialog(BuildContext context, String title, String message) {

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/status.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:levitate/src/view_model/booking_view_model.dart';
import 'package:provider/provider.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {

  final BookingViewModel _bookingViewModel = BookingViewModel();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {

    super.initState();
    _bookingViewModel.fetchBookedDataList(
        _firebaseAuth.currentUser != null ?
        _firebaseAuth.currentUser!.uid.toString() : "-1"
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            fontSize: 15
          )
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<BookingViewModel>(
        create: (BuildContext context) => _bookingViewModel,
        child: Consumer<BookingViewModel>(
          builder: (BuildContext context, BookingViewModel value, _){

            switch(value.bookedDataList.status){

              case Status.LOADING:
                return const CircularProgressIndicator();

              case Status.COMPLETED:
                return value.bookedDataList.data!.isEmpty ?
                    const Center(
                      child: Text(
                        "No Booking History Found"
                      )
                    ) :
                  ListView.builder(
                    itemCount: value.bookedDataList.data!.length,
                    itemBuilder: (BuildContext context, int index){

                      List<String> dateArray = value.bookedDataList.data![index].days.toString().split(" ");

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(
                                value.bookedDataList.data![index].hotelName.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            subtitle: Text(
                                'Paid ${value.bookedDataList.data![index].totalAmount} for ${value.bookedDataList.data![index].personsCount}'
                            ),
                            trailing: Text(
                                Utils.convertDateFormat(dateArray[0])
                            )
                          )
                        )
                      );

                    }
                );

              case Status.ERROR:
                return  const Center(
                    child: Text(
                        "No Booking History Found"
                    )
                );

              default:
                return Container();

            }

          }
        )
      )
    );

  }

}
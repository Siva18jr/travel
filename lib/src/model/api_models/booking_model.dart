class BookingDataModel {

  String? uId;
  String? name;
  String? email;
  String? hotelName;
  String? personsCount;
  String? bookingAmount;
  String? totalAmount;
  String? days;
  String? daysCount;
  String? paidOn;
  String? paymentId;

  BookingDataModel(
      {this.uId,
        this.name,
        this.email,
        this.hotelName,
        this.personsCount,
        this.bookingAmount,
        this.totalAmount,
        this.days,
        this.daysCount,
        this.paidOn,
        this.paymentId});

  BookingDataModel.fromJson(Map<String, dynamic> json) {

    uId = json['u_id'];
    name = json['name'];
    email = json['email'];
    hotelName = json['hotel_name'];
    personsCount = json['persons_count'];
    bookingAmount = json['booking_amount'];
    totalAmount = json['total_amount'];
    days = json['days'];
    daysCount = json['days_count'];
    paidOn = json['paid_on'];
    paymentId = json['payment_id'];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{};
    data['u_id'] = uId;
    data['name'] = name;
    data['email'] = email;
    data['hotel_name'] = hotelName;
    data['persons_count'] = personsCount;
    data['booking_amount'] = bookingAmount;
    data['total_amount'] = totalAmount;
    data['days'] = days;
    data['days_count'] = daysCount;
    data['paid_on'] = paidOn;
    data['payment_id'] = paymentId;
    return data;

  }

}
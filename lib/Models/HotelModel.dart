class HotelBooking {
  int hotelDetailID;
  String guestName;
  String contactNumber;
  String checkInDate;
  HotelBooking(
      {required this.hotelDetailID,
      required this.guestName,
      required this.contactNumber,
      required this.checkInDate});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "HotelDetailID": hotelDetailID,
      "GuestName": guestName.trim(),
      "ContactNumber": contactNumber.trim(),
      "CheckInDate": checkInDate.trim()
    };
    return map;
  }
}

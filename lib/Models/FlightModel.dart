class SearchFlightData {
  String from;
  String to;

  SearchFlightData({required this.from, required this.to});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> req = {'From': from.trim(), 'To': to.trim()};
    return req;
  }
}

class FlightBookingRequestModel {
  int packageDetailID;

  String bookedForDate;
  String address;
  String contactNo;
  int passportNo;
  String nationality;
  FlightBookingRequestModel({
    required this.packageDetailID,
    required this.bookedForDate,
    required this.address,
    required this.contactNo,
    required this.passportNo,
    required this.nationality,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "PackageDetailID": packageDetailID,
      "BookedForDate": bookedForDate.trim(),
      "Address": address.trim(),
      "ContactNo": contactNo.trim(),
      "PassportNumber": passportNo,
      "Nationality": nationality.trim()
    };
    return map;
  }
}

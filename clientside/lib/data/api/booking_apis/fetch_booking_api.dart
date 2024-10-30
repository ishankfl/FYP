// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:bookme/data/model/book_related_models/booking_model.dart';
import 'package:http/http.dart' as http;
import 'package:bookme/constant/constant_export.dart';

import '../../model/book_related_models/update_bookin_model.dart';
// import '../../model/model_export.dart';

class BookingApiProvider {
  Future<List<BookModel>> fetchBookingData({
    required String token,
  }) async {
    try {
      var request = await http.get(
        Uri.parse("${ServerUrl.ipaddress()}booking/api/booking/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "text/plain",
          "Authorization":
              "Bearer $token", // Change "Authentication" to "Authorization"
        },
      ).timeout(const Duration(seconds: 10));
      print(request.body);
      print(request.statusCode);

      if (request.statusCode == 200) {
        List<BookModel> data = List.from(jsonDecode(request.body)['data'])
            .map((e) => BookModel.fromMap(e))
            .toList();
        return data;
      } else if (request.statusCode == 401) {
        BookModel model = BookModel();
        model.error = '1';
        model.message = 'Token is expired';

        return [BookModel.initError("Token is expired")];
        // emit()
      } else {
        return [BookModel.initError("Invalid Email or Password")];
      }
    } on TimeoutException {
      return [BookModel.initError("Please Check you wifi")];
    } catch (err) {
      print(err);
      return [BookModel.initError("Connection Issue")];
    }
  }

  Future<List<BookModel>> bookService({
    required String longitude,
    required String latitude,
    required String service,
    required String provider,
    // ignore: non_constant_identifier_names
    required String start_date_time,
    required String expectedHours,
    required String token,
    required String location,
    required address,
  }) async {
    print("detail");
    print(longitude);
    print(latitude);
    print(service);
    print(provider); 
    print(start_date_time);
    print(expectedHours);
    print(token);
    print(location);
    try {
      var request = await http.post(
          Uri.parse("${ServerUrl.ipaddress()}booking/api/booking/"),
          headers: {
            "Accept": "application/json",
            // "Content-Type": "text/plain",
            "Authorization":
                "Bearer $token", // Change "Authentication" to "Authorization"
          },
          body: {
            'provider': provider,
            'booking_date': start_date_time,
            'expected_hours': expectedHours,
            'longitude': longitude,
            'latitude': latitude,
            'token': token,
            'location': location,
            'address': address,
            'service': service
          }).timeout(const Duration(seconds: 10));
      print("in booking afterrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      print(request.body);
      print(request.statusCode);

      if (request.statusCode == 200) {
        List<BookModel> data = List.from(jsonDecode(request.body)['data'])
            .map((e) => BookModel.fromMap(e))
            .toList();
        return data;
        // return BookModel.fromMap(jsonDecode(response.b ody));
      } else if (request.statusCode == 401) {
        BookModel model = BookModel();
        model.error = '1';
        model.message = 'Token is expired';

        return [BookModel.initError("Token is expired")];
        // emit()
      } else {
        return [BookModel.initError("Invalid Email or Password")];
      }
    } on TimeoutException {
      return [BookModel.initError("Please Check you wifi")];
    } catch (err) {
      print(err);
      return [BookModel.initError("Connection Issue")];
    }
  }

  Future<List<BookingUpdateModel>> cancelBook({
    required String bookId,
    required String token,
  }) async {
    try {
      var request = await http.post(
          Uri.parse("${ServerUrl.ipaddress()}booking/api/cancelbook/"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          body: {
            'book_id': bookId,
          }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        print(request.body);
        return [BookingUpdateModel.fromMap(jsonDecode(request.body))];

        // return data;
        // return BookModel.fromMap(jsonDecode(response.b ody));
      } else {
        return [
          BookingUpdateModel.initError(jsonDecode(request.body)['message'])
        ];
      }
    } on TimeoutException {
      return [BookingUpdateModel.initError("Please Check you wifi")];
    } catch (err) {
      return [BookingUpdateModel.initError("Connection Issue")];
    }
  }

  Future<List<BookingUpdateModel>> acceptBooking({
    required String bookId,
    required String token,
  }) async {
    try {
      var request = await http.post(
          Uri.parse("${ServerUrl.ipaddress()}booking/api/accept_request/"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          body: {
            'book_id': bookId,
          }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        print(request.body);
        return [BookingUpdateModel.fromMap(jsonDecode(request.body))];

        // return data;
        // return BookModel.fromMap(jsonDecode(response.b ody));
      } else {
        return [
          BookingUpdateModel.initError(jsonDecode(request.body)['message'])
        ];
      }
    } on TimeoutException {
      return [BookingUpdateModel.initError("Please Check you wifi")];
    } catch (err) {
      return [BookingUpdateModel.initError("Connection Issue")];
    }
  }

  Future<List<BookingUpdateModel>> rescheduleBooking(
      {required String rescheduleTime,
      required String expectedHours,
      required String token,
      required String bookId}) async {
    try {
      var request = await http.post(
          Uri.parse("${ServerUrl.ipaddress()}booking/api/reschedule/"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          body: {
            'book_id': bookId,
            'expected_hours': expectedHours,
            'booking_date': rescheduleTime,
          }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        print(request.body);
        return [BookingUpdateModel.fromMap(jsonDecode(request.body))];

        // return data;
        // return BookModel.fromMap(jsonDecode(response.b ody));
      } else {
        return [
          BookingUpdateModel.initError(jsonDecode(request.body)['message'])
        ];
      }
    } on TimeoutException {
      return [BookingUpdateModel.initError("Please Check you wifi")];
    } catch (err) {
      print(err);
      return [BookingUpdateModel.initError("Connection Issue")];
    }
  }

  Future<List<BookingUpdateModel>> makeCompleteBooking(
      {required String bookId, required String token}) async {
    try {
      var request = await http.post(
          Uri.parse("${ServerUrl.ipaddress()}booking/api/makecomplete/"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          body: {
            'book_id': bookId,
          }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        print(request.body);
        return [BookingUpdateModel.fromMap(jsonDecode(request.body))];

        // return data;
        // return BookModel.fromMap(jsonDecode(response.b ody));
      } else {
        return [
          BookingUpdateModel.initError(jsonDecode(request.body)['message'])
        ];
      }
    } on TimeoutException {
      return [BookingUpdateModel.initError("Please Check you wifi")];
    } catch (err) {
      print(err);
      return [BookingUpdateModel.initError("Connection Issue")];
    }
  }
}

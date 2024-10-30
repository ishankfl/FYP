import 'package:bookme/data/api/loginsignupapi/login_api.dart';
import 'package:bookme/data/model/book_related_models/booking_model.dart';
import 'package:bookme/data/model/book_related_models/update_bookin_model.dart';
// import 'package:bookme/data/model/login_model.dart';
import 'package:bookme/data/model/model_export.dart';

import '../api/booking_apis/fetch_booking_api.dart';

class BookingRepository {
  final fetchBookingApi = BookingApiProvider();
  Future<List<BookModel>> fetchBooking({required String token}) {
    return fetchBookingApi.fetchBookingData(token: token);
  }

  Future<List<BookModel>> bookService(
      {required String service,
      required String provider,
      required String start_date_time,
      required String expectedHours,
      required String longitude,
      required String latitude,
      required String token,
      required String location,
      required String address}) {
    return fetchBookingApi.bookService(
        address: address,
        expectedHours: expectedHours,
        provider: provider,
        start_date_time: start_date_time,
        location: location,
        token: token,
        longitude: longitude,
        latitude: latitude,
        service: service);
  }

  Future<List<BookingUpdateModel>> cancelBook(
      {required String token, required String bookId}) {
    return fetchBookingApi.cancelBook(token: token, bookId: bookId);
  }

  Future<List<BookingUpdateModel>> acceptBook(
      {required String token, required String bookId}) {
    return fetchBookingApi.acceptBooking(token: token, bookId: bookId);
  }

  Future<List<BookingUpdateModel>> rescheduleBooking(
      {required String token,
      required String bookId,
      required String startDateTime,
      required String expectedHours}) {
    return fetchBookingApi.rescheduleBooking(
        token: token,
        bookId: bookId,
        rescheduleTime: startDateTime,
        expectedHours: expectedHours);
  }

  Future<List<BookingUpdateModel>> makeComplete(
      {required String token, required String bookId}) {
    return fetchBookingApi.makeCompleteBooking(
      token: token,
      bookId: bookId,
    );
  }
}

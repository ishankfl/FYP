import 'package:bookme/data/api/chat/chat_api.dart';
import 'package:bookme/data/api/loginsignupapi/login_api.dart';
import 'package:bookme/data/model/book_related_models/booking_model.dart';
import 'package:bookme/data/model/book_related_models/update_bookin_model.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/data/model/user_model.dart';

class ChatUserListRepo {
  final api = ChatApiProvider();
  Future<List<UserModel>> fetchBooking({required String token}) {
    return api.fetchChatUser(token: token);
  }

  Future<List<ChatModel>> individualChat(
      {required String token, required String toId}) {
    return api.individualChat(token: token, toId: toId);
  }
}

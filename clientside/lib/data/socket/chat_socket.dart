import 'package:web_socket_channel/web_socket_channel.dart';

class SocketChannel {
  static WebSocketChannel messageSocket() {
    return WebSocketChannel.connect(
      Uri.parse('ws://192.168.1.71:8000/ws/personalChat/2/1/'),
    );
  }
}

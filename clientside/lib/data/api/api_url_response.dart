import 'package:bookme/data/api/api_export.dart';
import 'package:http/http.dart' as http;

Future<Response> urlResponse(String url) async {
  return await http
      .get(
        Uri.parse('${ServerUrl.ipaddress()}$url'),
      )
      .timeout(const Duration(seconds: 10));
}

import 'package:dictionary/logic/global_state.dart';
import 'package:http/http.dart' as http;

GlobalState _store = GlobalState.instance;

Future<String> fetchAlbum() async {
  var url = Uri.parse(
      'https://owlbot.info/api/v4/dictionary/${_store.get().toString()}');
  print(_store.get());
  print(url.toString());
  http.Response response = await http.get(url, headers: {
    "Authorization": "Token c7fd48840f0f1581b3d57de487b4c6d36f2b7f57"
  });
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    print(response.body);
    print(response.statusCode);
    throw Exception(response.statusCode.toString());
  }
}

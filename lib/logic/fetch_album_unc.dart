import 'package:dictionary/logic/global_state.dart';
import 'package:dictionary/logic/uncjson.dart';
import 'package:http/http.dart' as http;

GlobalState _store = GlobalState.instance;

Future<String> fetchAlbum() async {
  var url = Uri.parse(
      'https://unscramble.deta.dev/unscramble/${_store.get().toString()}');
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception(response.statusCode.toString());
  }
}

Future<Map<String, List<String>>> loadWords() async {
  String? album = await fetchAlbum();

  Welcome words = welcomeFromJson(album);

  List<String>? foundWords = words.unscrambledWords!;
  print(foundWords);
  List<String>? _foundWords3 = [];
  List<String>? _foundWords4 = [];
  List<String>? _foundWords5 = [];
  List<String>? _foundWords6 = [];
  List<String>? _foundWords7 = [];

  for (var i in foundWords) {
    if (i.length == 3) {
      _foundWords3.add(i);
    } else if (i.length == 4) {
      _foundWords4.add(i);
    } else if (i.length == 5) {
      _foundWords5.add(i);
    } else if (i.length == 6) {
      _foundWords6.add(i);
    } else if (i.length == 7) {
      _foundWords7.add(i);
    }
  }
  return {
    'threeWords': _foundWords3,
    'fourWords': _foundWords4,
    'fiveWords': _foundWords5,
    'sixWords': _foundWords6,
    'sevenWords': _foundWords7,
    'allWords': foundWords,
  };
}

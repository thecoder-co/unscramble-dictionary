import 'package:dictionary/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Unscramble extends StatefulWidget {
  Unscramble({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  _UnscrambleState createState() => _UnscrambleState();
}

class _UnscrambleState extends State<Unscramble> {
  late Future<Map<String?, List<String?>?>?>? futureWords;
  @override
  void initState() {
    super.initState();
    futureWords = loadWords();
  }

  GlobalState _store = GlobalState.instance;

  Future<String>? loadAsset() async {
    return await rootBundle.loadString('assets/texts/words_alpha.txt');
  }

  Future<Map<String, List<String>>> loadWords() async {
    String? word = _store.get();
    List _toList(String lily) {
      List a = [];
      for (var i = 0; i < lily.length; i++) {
        a.add(lily[i]);
      }

      return a;
    }

    int freql(var w, List lst) {
      int count = 0;
      for (var i = 0; i < lst.length; i++) {
        if (lst[i] == w) {
          count += 1;
        }
      }
      return count;
    }

    bool isin(String lily, String ylil) {
      List a = _toList(lily);
      List b = _toList(ylil);
      for (var i = 0; i < a.length; i++) {
        if (!b.contains(a[i])) {
          return false;
        }
      }
      for (var i = 0; i < a.length; i++) {
        if (freql(a[i], a) > freql(b[i], b)) {
          return false;
        }
      }
      return true;
    }

    List<String>? foundWords = [];
    String? fileContent = await loadAsset();
    List? wordList = fileContent!.split('\n');
    List? necessaryWords = [];

    for (String i in wordList) {
      List lst = Iterable<int>.generate(word!.length + 1).toList();
      if (lst.contains(i.length)) {
        necessaryWords.add(i);
      }
    }

    for (var j in necessaryWords) {
      if (isin(j, word!)) {
        foundWords.add(j);
      }
    }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.height / 2
                      : MediaQuery.of(context).size.height / 3,
              color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? MediaQuery.of(context).size.height / 3
                        : MediaQuery.of(context).size.height / 4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width -
                                    (MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? MediaQuery.of(context).size.height /
                                            3 /
                                            3
                                        : MediaQuery.of(context).size.height /
                                            4 /
                                            3) -
                                    50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_store.get().toString().substring(0, 1).toUpperCase() + _store.get().toString().substring(1, _store.get().toString().length)}',
                                      style: GoogleFonts.getFont(
                                        'Special Elite',
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01 *
                                                  10
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01 *
                                                  12.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    SelectableText(
                                      '${_store.get().toString().substring(0, 1).toUpperCase() + _store.get().toString().substring(1, _store.get().toString().length)}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      cursorColor: Colors.blue[900],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String _word = '';

                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        title: Text('Search'),
                                        content: TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Search',
                                          ),
                                          autocorrect: true,
                                          autofocus: true,
                                          keyboardType: TextInputType.text,
                                          onSubmitted: (word) {
                                            setState(() {
                                              _word = word;
                                              _store.set(_word);
                                            });
                                            Navigator.pushNamed(
                                                context, '/dictionary');
                                          },
                                          onChanged: (word) {
                                            setState(() {
                                              _word = word;
                                              _store.set(_word);
                                            });
                                          },
                                        ),
                                        actions: [
                                          FlatButton(
                                            textColor: Colors.blue,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('Cancel'),
                                          ),
                                          FlatButton(
                                            textColor: Colors.blue,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(
                                                  context, '/dictionary');
                                            },
                                            child: Text('Search'),
                                          ),
                                          FlatButton(
                                            textColor: Colors.blue,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(
                                                  context, '/unscramble');
                                            },
                                            child: Text('Unscramble'),
                                          ),
                                        ], // actions
                                      );
                                    }),
                                icon: Icon(Icons.search),
                                color: Colors.white,
                                highlightColor: Colors.blue[700],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? MediaQuery.of(context).size.height / 3
                        : MediaQuery.of(context).size.height / 4,
                  ),
                  Container(
                    child: FutureBuilder(
                      future: futureWords,
                      initialData: {
                        'threeWords': [],
                        'fourWords': [],
                        'fiveWords': [],
                        'sixWords': [],
                        'sevenWords': [],
                        'allWords': [],
                      },
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        print(snapshot.data);
                        List _keys = [
                          'threeWords',
                          'fourWords',
                          'fiveWords',
                          'sixWords',
                          'sevenWords',
                          'allWords',
                        ];
                        return Wrap(
                          runSpacing: 50,
                          spacing: 50,
                          children: List.generate(
                            6,
                            (index) => Container(
                              alignment: Alignment.topCenter,
                              width: 350,
                              height: 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 10,
                                    blurRadius: 17,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: ListView.separated(
                                  itemCount:
                                      snapshot.data![_keys[index]].length!,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider();
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    return Center(
                                      child: SelectableText(
                                        snapshot.data![_keys[index]][index1]!,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width / 1.2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

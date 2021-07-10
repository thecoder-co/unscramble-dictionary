import 'package:dictionary/global_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Dict extends StatefulWidget {
  Dict({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _DictState createState() => _DictState();
}

class _DictState extends State<Dict> {
  GlobalState _store = GlobalState.instance;
  late Future<String> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                                child: Text(
                                  '${_store.get().toString().substring(0, 1).toUpperCase() + _store.get().toString().substring(1, _store.get().toString().length)}',
                                  style: GoogleFonts.getFont(
                                    'Special Elite',
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context)
                                                  .orientation ==
                                              Orientation.landscape
                                          ? MediaQuery.of(context).size.width *
                                              0.01 *
                                              10
                                          : MediaQuery.of(context).size.width *
                                              0.01 *
                                              12.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FutureBuilder(
                                future: futureAlbum,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    final welcome =
                                        welcomeFromJson(snapshot.data!);
                                    if (welcome.pronunciation != null) {
                                      return Text(
                                        welcome.pronunciation!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01 *
                                                  2
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01 *
                                                  4,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
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
                                            _word = word;

                                            _store.set(_word);
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
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 17,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FutureBuilder<String>(
                        future: futureAlbum,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final welcome = welcomeFromJson(snapshot.data!);

                            return ListView.separated(
                                itemBuilder: (context, index) => index == 0
                                    ? SelectableText(
                                        welcome.word!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? 17
                                              : 15,
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectableText(
                                            welcome
                                                .definitions![index - 1].type!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.landscape
                                                  ? 15
                                                  : 13,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 25,
                                              ),
                                              Flexible(
                                                child: SelectableText(
                                                  '$index. ${welcome.definitions![index - 1].definition!}',
                                                  style: TextStyle(
                                                    fontSize: MediaQuery.of(
                                                                    context)
                                                                .orientation ==
                                                            Orientation
                                                                .landscape
                                                        ? 15
                                                        : 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          welcome.definitions![index - 1]
                                                      .example !=
                                                  null
                                              ? Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    Flexible(
                                                      child: SelectableText(
                                                        '1. ${welcome.definitions![index - 1].example!}'
                                                            .replaceAll(
                                                                '<b>', '')
                                                            .replaceAll(
                                                                '</b>', ''),
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .orientation ==
                                                                  Orientation
                                                                      .landscape
                                                              ? 15
                                                              : 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 30,
                                    ),
                                itemCount: welcome.definitions!.length + 1);
                          } else if (snapshot.hasError) {
                            return Text("Word not found");
                          }

                          // By default, show a loading spinner.
                          return SizedBox(
                            child: CircularProgressIndicator(
                              strokeWidth: 20,
                            ),
                            height: 200.0,
                            width: 200.0,
                          );
                        },
                      ),
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

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.definitions,
    this.word,
    this.pronunciation,
  });

  List<Definition>? definitions;
  String? word;
  String? pronunciation;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        definitions: List<Definition>.from(
            json["definitions"].map((x) => Definition.fromJson(x))),
        word: json["word"],
        pronunciation: json["pronunciation"],
      );

  Map<String, dynamic> toJson() => {
        "definitions": List<dynamic>.from(definitions!.map((x) => x.toJson())),
        "word": word,
        "pronunciation": pronunciation,
      };
}

class Definition {
  Definition({
    this.type,
    this.definition,
    this.example,
    this.imageUrl,
    this.emoji,
  });

  String? type;
  String? definition;
  dynamic example;
  String? imageUrl;
  dynamic emoji;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        type: json["type"],
        definition: json["definition"],
        example: json["example"],
        imageUrl: json["image_url"],
        emoji: json["emoji"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "definition": definition,
        "example": example,
        "image_url": imageUrl,
        "emoji": emoji,
      };
}

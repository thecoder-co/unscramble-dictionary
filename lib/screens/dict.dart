import 'package:dictionary/components/header.dart';
import 'package:dictionary/logic/fetch_album_dict.dart';
import 'package:dictionary/logic/global_state.dart';
import 'package:dictionary/logic/dictjson.dart';
import 'package:flutter/material.dart';

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
  late Future<String> futureAlbum;
  late Welcome welcome;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  GlobalState _store = GlobalState.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Header(
              header:
                  '${_store.get().toString().substring(0, 1).toUpperCase() + _store.get().toString().substring(1, _store.get().toString().length)}',
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
                                                        '1. ${welcome.definitions![index - 1].example!}',
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
                          return Center(
                            child: SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width / 1.2) *
                                      0.7,
                              width: (MediaQuery.of(context).size.width / 1.2) *
                                  0.7,
                              child: CircularProgressIndicator(
                                strokeWidth: 20,
                              ),
                            ),
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

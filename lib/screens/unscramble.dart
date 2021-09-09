import 'package:dictionary/components/header.dart';
import 'package:dictionary/components/unc_complete.dart';
import 'package:dictionary/components/unc_error.dart';
import 'package:dictionary/components/unc_loading.dart';
import 'package:dictionary/logic/fetch_album_unc.dart';
import 'package:dictionary/logic/global_state.dart';
import 'package:flutter/material.dart';

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
  late Future<Map<String, List<String>>> futureWords;
  @override
  void initState() {
    super.initState();
    futureWords = loadWords();
  }

  GlobalState _store = GlobalState.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
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
                    child: FutureBuilder(
                      future: futureWords,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Complete(snapshot: snapshot);
                        } else if (snapshot.hasError) {
                          return Error();
                        } else {
                          return Loading();
                        }
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

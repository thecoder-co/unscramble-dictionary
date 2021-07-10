import 'package:dictionary/global_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalState _store = GlobalState.instance;
  late String _word;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.height / 6
                        : MediaQuery.of(context).size.height / 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Dictionary',
                  style: GoogleFonts.getFont(
                    'Special Elite',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MediaQuery.of(context).size.width * 0.01 * 10
                          : MediaQuery.of(context).size.width * 0.01 * 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 75
                      : 25,
                  50,
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 75
                      : 25,
                  50,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _word = value;
                      });
                      _store.set(_word.toLowerCase());
                    },
                    onSubmitted: (value) {
                      setState(() {
                        _word = value;
                      });
                      _store.set(_word.toLowerCase());
                    },
                    autofocus: true,
                    cursorRadius: Radius.circular(5),
                    cursorWidth: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 5
                        : 3,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 50
                          : 35,
                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.blue[700],
                        border: InputBorder.none),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 2,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.blue[700],
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                        MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? EdgeInsets.fromLTRB(40, 10, 40, 10)
                            : EdgeInsets.fromLTRB(30, 8, 30, 8),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500),
                          side: BorderSide(color: Colors.blue[700]!),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/dictionary');
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 40
                            : 30,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.blue[700],
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                        MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? EdgeInsets.fromLTRB(40, 10, 40, 10)
                            : EdgeInsets.fromLTRB(30, 8, 30, 8),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500.0),
                          side: BorderSide(color: Colors.blue[700]!),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/unscramble');
                    },
                    child: Text(
                      'Unscramble',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 40
                            : 30,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

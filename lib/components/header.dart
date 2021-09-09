import 'package:dictionary/components/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({Key? key, this.pronunciation, this.header}) : super(key: key);

  final String? pronunciation;
  final String? header;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.height / 2
          : MediaQuery.of(context).size.height / 3,
      color: Colors.blue,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: MediaQuery.of(context).orientation == Orientation.landscape
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
                                ? MediaQuery.of(context).size.height / 3 / 3
                                : MediaQuery.of(context).size.height / 4 / 3) -
                            50,
                        child: Text(
                          header!,
                          style: GoogleFonts.getFont(
                            'Special Elite',
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).orientation ==
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
                              return Search();
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
    );
  }
}

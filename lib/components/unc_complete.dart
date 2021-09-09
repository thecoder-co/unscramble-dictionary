import 'package:dictionary/logic/global_state.dart';
import 'package:flutter/material.dart';

class Complete extends StatelessWidget {
  const Complete({Key? key, this.snapshot}) : super(key: key);

  final dynamic snapshot;

  @override
  Widget build(BuildContext context) {
    final List _keys = [
      'threeWords',
      'fourWords',
      'fiveWords',
      'sixWords',
      'sevenWords',
      'allWords',
    ];
    GlobalState _store = GlobalState.instance;
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
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              itemCount: snapshot.data![_keys[index]].length!,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int index1) {
                return Center(
                    child: Container(
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {},
                    child: SelectableText(
                      snapshot.data![_keys[index]][index1]!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onLongPress: () {
                      _store.set(
                          snapshot.data![_keys[index]][index1]!.toLowerCase());
                      Navigator.pushNamed(context, '/dictionary');
                    },
                  ),
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}

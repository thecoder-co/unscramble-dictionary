import 'package:dictionary/logic/global_state.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalState _store = GlobalState.instance;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
          _store.set(word);
          Navigator.pushNamed(context, '/dictionary');
        },
        onChanged: (word) {
          _store.set(word);
        },
      ),
      actions: [
        FlatButton(
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        FlatButton(
          textColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/dictionary');
          },
          child: Text('Search'),
        ),
        FlatButton(
          textColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/unscramble');
          },
          child: Text('Unscramble'),
        ),
      ], // actions
    );
  }
}

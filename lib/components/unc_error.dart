import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Text('error'),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/add_note_screen.dart';

class FloatingActionButtonWithText extends StatelessWidget {
  final bool show;
  FloatingActionButtonWithText({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text always visible
          if (show)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                'Add New Tasks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          // Floating Action Button
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Add_creen(),
              ));
            },
            backgroundColor: Colors.green,
            child: Icon(Icons.add, size: 30),
          ),
        ],
      ),
    );
  }
}

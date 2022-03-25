import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  List images;
  NewPage({Key? key, required this.images}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新界面'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (cntext, index) {
          var data = widget.images[index];
          return Container(
            height: 300,
            width: 200,
            child: Image.memory(
              data,
              height: 300,
              fit: BoxFit.contain,
            ),
          );
        },
        itemCount: widget.images.length,
      ),
    );
  }
}

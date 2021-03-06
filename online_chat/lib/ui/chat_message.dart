import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(this.data, this.mine);

  final Map<String, dynamic> data;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    data.keys.forEach((f) {
      print(f);
    });
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(children: <Widget>[
        !mine ?
        Padding(
          child: CircleAvatar(
            backgroundImage: NetworkImage(data['senderPhotoUrl']),
          ),
          padding: EdgeInsets.only(right: 16),
        ) : Container(),
        Expanded(
          child: Column(
            crossAxisAlignment: mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              data['imgUrl'] != null
                  ? Image.network(
                      data['imgUrl'],
                      width: 250,
                    )
                  : Text(
                      data['text'],
                      textAlign: mine ? TextAlign.end : TextAlign.start,
                      style: TextStyle(fontSize: 18),
                    ),
              Text(
                data['senderName'],
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        mine ?
        Padding(
          child: CircleAvatar(
            backgroundImage: NetworkImage(data['senderPhotoUrl']),
          ),
          padding: EdgeInsets.only(left: 16),
        ) : Container(),
      ]),
    );
  }
}

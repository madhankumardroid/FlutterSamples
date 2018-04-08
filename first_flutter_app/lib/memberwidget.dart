import 'package:flutter/material.dart';
import 'member.dart';

class MemberState extends State<MemberWidget> {
  final Member member;

  MemberState(this.member);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(member.login),
        ),
        body: new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Column(children: <Widget>[//In order layout the views vertically, we need to use Column
              new Image.network(member.avatarUrl),
              new IconButton(
                  icon: new Icon(Icons.arrow_back,
                      color: Colors.pinkAccent, size: 48.0),
                  onPressed: () {
                    Navigator.pop(context);//Pop this screen from the stack
                  }),
              new RaisedButton(
                  child: new Text('PRESS ME'),
                  color: Colors.purple,
                  textColor: Colors.white,
                  elevation: 4.0,
                  onPressed: () {
                    _showOKScreen(context);
                  })
            ])));
  }

  /// Shows a Screen that displays OK and NOT OK buttons
  _showOKScreen(BuildContext context) async {
    bool value = await Navigator
        .of(context)
        .push(new MaterialPageRoute<bool>(builder: (BuildContext context) {//You can replace the bool type in MaterialPageRoute<bool> to any other type that you want in the result.
      return new Padding(
        padding: const EdgeInsets.all(32.0),
        child: new Column(
          children: <Widget>[
            new GestureDetector(
                child: new Text('OK'),
                onTap: () {
                  Navigator.of(context).pop(true);//Routes can return values as like onActivityResult.
                }),
            new GestureDetector(
                child: new Text('NOT OK'),
                onTap: () {
                  Navigator.of(context).pop(false);
                })
          ],
        ),
      );
    }));

    var alert = new AlertDialog(
      content: new Text((value != null && value)
          ? "OK was pressed"
          : "NOT OK or BACK was pressed"),
      actions: <Widget>[
        new FlatButton(
            child: new Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();//Pop this screen from the stack
            })
      ],
    );

    showDialog(context: context, child: alert);
  }
}

class MemberWidget extends StatefulWidget {
  final Member member;

  MemberWidget(this.member) {
    if (member == null) {
      throw new ArgumentError("member of MemberWidget cannot be null. "
          "Received: '$member'");
    }
  }

  @override
  createState() => new MemberState(member);
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'member.dart';
import 'memberwidget.dart';
import 'strings.dart';
import 'dart:convert';

class FirstFlutterState extends State<FirstStateFulWidget> {
  //_ at the beginning make the members private to this class.
//  var _members = []; //Declaring an empty list
  var _members = <Member>[]; //A list of Member objects
  final _biggerFont = const TextStyle(fontSize: 18.0); //Creating text style

  @override
  void initState() {
    //It calls loadData when the state is initialized
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    //A Scaffold is a container for material design widgets. It acts as the root of a widget hierarchy.
    return new Scaffold(
        //Create an app bar
        appBar: new AppBar(title: new Text(Strings.appTitle)),
        //Create a body with list view which acts as a RecyclerView in Android, UITableView in iOS
        body: new ListView.builder(
            itemCount: _members.length,
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd)
                return new Divider(); //To add a divider between list items
              final index = position ~/ 2;
              return _buildRow(index);
            }));
  }

  /**
   * Create a new list item
   */
  Widget _buildRow(int i) {
    return new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new ListTile(
          title: new Text(
            "${ _members[i].login }",
            style: _biggerFont,
          ),
          leading: new CircleAvatar(
            //This makes the avatar image to show before the title
            backgroundColor: Colors.pinkAccent,
            backgroundImage: new NetworkImage(_members[i].avatarUrl),
          ),
          onTap: () {
            _pushMember(_members[i]);
          },
        ));
  }

  ///Load data from the network
  _loadData() async {
    //async keyword tells that it is an asynchronous method
    String dataURL =
        "https://api.github.com/orgs/google/members"; //Got members from Google
    http.Response response =
        await http.get(dataURL); //await indicates it is a blocking call.
    setState(() {
      //setState runs synchronously in the main thread after the response is received in the above statement.

      final membersJSON = jsonDecode(response
          .body); //Took each member in the response and add it to the _members list as Dart Map type by default
      for (var memberJSON in membersJSON) {
        final member =
            new Member(memberJSON["login"], memberJSON["avatar_url"]);
        _members.add(member);
      }
    });
  }

  _pushMember(Member member) {
    /*
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) => new MemberWidget(member)
        )
    );*/

    Navigator.of(context).push(new PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (BuildContext context, _, __) {
          return new MemberWidget(member);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new RotationTransition(
                turns: new Tween(begin: 0.0, end: 1.0).animate(animation),
                child: child),
          );
        }));
  }
}

//The widget which acts as a main container
class FirstStateFulWidget extends StatefulWidget {
  createState() => new FirstFlutterState();
}

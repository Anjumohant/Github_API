import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:github_profile/template/Card.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

void main() {
  runApp(GitHub_Profile());
}
class GitHub_Profile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GitHub Profile",
      home: GitHubAPI(),
    );
  }

}
class GitHubAPI extends StatefulWidget{

  @override
  State createState() => new GithubAPIState();

}
class GithubAPIState extends State<GitHubAPI> with TickerProviderStateMixin{
  final List<ProfileCard> _card = <ProfileCard>[];
  final TextEditingController _textController = TextEditingController();
  var resBody;
  bool searching =  false,api_no_limit = false;
  late String user;
  Future _getUser(String text) async{
    setState(() {
      searching = true;
    });
    user = text;
    _textController.clear();
    String url = "https://api.github.com/users/"+text;
    var res = await http
        .get(Uri.parse(Uri.encodeFull(url)), headers: {"Authorization": "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"});
    setState(() {
      resBody = json.decode(res.body);
    });
    if(resBody['avatar_url'] !=  null) {
      ProfileCard card = ProfileCard(
        user:user,
        text: resBody['name'],
        image: resBody['avatar_url'],
        public_repos: resBody['public_repos'],
        following: resBody['following'],
        followers:resBody['followers'],
        animationController: AnimationController(
          duration:  Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      setState(() {
        _card.insert(0, card);
      });
      print(_card.length);
      card.animationController.forward();
    }else{
      api_no_limit = true;
    }
    print("after id");
    searching = false;
  }
  void dispose() {
    for (ProfileCard message in _card) {
      message.animationController.dispose();
    }
    super.dispose();
  }
  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _getUser,
                decoration:
                const InputDecoration.collapsed(hintText: "Enter Github Username"),
              ),
            ),
            Container(
                margin:  const EdgeInsets.symmetric(horizontal: 4.0),
                child:  IconButton(
                    icon:  const Icon(Icons.search),
                    onPressed: () => _getUser(_textController.text)
                )
            ),
          ]),
        )
    );
  }
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:  AppBar(
            title: const Text("Github API"),
            elevation: 4.0
        ),
        body:  Column(
            children: <Widget>[
               Container(
                decoration:  BoxDecoration(
                    color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
               const Divider(height: 2.0),
              loading(),
              Flexible(
                  child:  ListView.builder(
                    padding:  const EdgeInsets.all(8.0),
                    itemBuilder: (_, int index) => _card[index],
                    itemCount: _card.length,
                  )
              ),
            ]
        )
    );
  }
  Widget loading(){
    if(searching){
      return  Container(
        height: 60.0,
        child: const Center(
            child: CircularProgressIndicator()
        ),
      );
    }else if(api_no_limit) {
      return  Card(
        child:  Container(
            height: 80.0,
            color: Colors.red,
            child: const Center(
              child:  Text(
                "API LIMIT EXCEEDED",
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22.0
                ),
              ),
            )
        ),
      );
    }else{
      return  Container();
    }
  }
}
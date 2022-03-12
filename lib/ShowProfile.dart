import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_profile/template/Repo.dart';
import 'package:github_profile/template/User.dart';
import 'package:http/http.dart' as http;
import 'package:github_profile/template/Card.dart';
class ShowProfile extends StatefulWidget{
  final String username,user;
  const ShowProfile({required this.username,required this.user});
  @override
  State<StatefulWidget> createState() {
    return ProfileState(username:username,user:user);
  }
}
class ProfileState extends State<ShowProfile>{
  bool repo_loading = true;
  bool repo_data = false;

  String username,user;
  ProfileState({required this.username,required this.user}){
    this.username = username;
  }
  String base_url = "https://api.github.com/users/";
  String getURL(){
    return base_url+user+"/";
  }
  var ResBody;
  List<Repo> _repo = [];
   List<User> _followers =[];
  List<User> _following =[];
  getRepo() async{
    var res = await http.get(Uri.parse(getURL()+"repos"), headers: {"Accept": "application/json"});
    ResBody = json.decode(res.body);
    setState(() {
      for(var data in ResBody){
        _repo.add(
            Repo(
                data['name'],
                data['description'],
                data['stargazers_count'],
                data['forks_count'],
                data['language']
            ));
        repo_data = true;
      }
    });
    repo_loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home:  DefaultTabController(
        length: 2,
        child:  Scaffold(
          appBar: AppBar(
              title: Text(username),
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                   Tab(child:  Text("Profile Details")),
                   Tab(child: Text("Repository")),
  ]

              )
          ),
          body: TabBarView(
            children: [
               Center(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[

                    ],
                  )
              ),
               Container(
                  child: _Repo_data()
              ),


            ],
          ),
        ),
      ),
    );

  }
  @override
  void initState() {

    super.initState();
    getRepo();

  }
  Widget _Repo_data() {
    if(repo_loading){
      return const Center(
        child:  CircularProgressIndicator(),
      );
    }else if(!repo_data){
      return  Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("$user have No Repo")
            ]
        ),
      );
    }else{
      return  Column(
        children: <Widget>[
           Flexible(
              child:  ListView.builder(
                padding:  EdgeInsets.all(8.0),
                itemBuilder: (_, int index) => _repo[index],
                itemCount: _repo.length,
              )
          )
        ],
      );
    }
  }
}
import 'package:flutter/material.dart';

import '../ShowProfile.dart';


class ProfileCard extends StatelessWidget {
  ProfileCard({required this.user,required this.text,required this.image ,required this.public_repos,required this.following,required this.followers,required this.animationController});

  final String text;
  final String user;
  final String image;
  final int public_repos;
  final int followers;
  final int following;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.linear,
        ),
        axisAlignment: 0.0,
        child:  Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child:RaisedButton(
              color: Colors.white,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowProfile(username:this.text,user:this.user)));
              },
              child:  Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                margin: const EdgeInsets.only(right: 5.0),
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right:16.0),
                      child:  Image.network(image,width: 100.0,height: 100.0,),
                    ),
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              text,

                          ),
                           Padding(padding: EdgeInsets.only(bottom: 30.0)),
                          Text('Public Repo : $public_repos'),
                          Padding(padding: EdgeInsets.only(bottom: 6.0)),
                          Column(
                            children: <Widget>[
                               Text('Followers : $followers'),
                               Padding(padding: EdgeInsets.only(right: 15.0)),
                               Text('Following : $following')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        )
    );
  }
}

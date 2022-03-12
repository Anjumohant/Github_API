import 'package:flutter/material.dart';
import 'package:github_profile/ShowProfile.dart';
class User extends StatelessWidget{
  final String text;
  final String image;
  User({required this.text,required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: RaisedButton(
          color: Colors.white,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowProfile(username:"Github API",user:this.text)));
          },
          child:  Container(
              height: 80.0,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              margin: const EdgeInsets.symmetric(vertical: 5.0,),
              child:  Row(
                children: <Widget>[
                  Container(
                    child: Image.network(image,height: 60.0,width: 60.0,),
                    margin: const EdgeInsets.only(right: 10.0),
                  ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                        Text(text,style: const TextStyle(fontSize: 22.0),),
                     ],
                   ),
                ],
              )
          ),
        )
    );
  }


}
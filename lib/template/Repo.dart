
import 'package:flutter/material.dart';

class Repo extends StatelessWidget{
  String name,description,language;
  final int stargazers_count,forks_count;
  Repo(this.name, this.description, this.stargazers_count, this.forks_count,
      this.language){
    if(this.description == null){
      this.description = "No Description";
    }
    if(this.language == null){
      this.language == "No Language";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child:  Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0,),
          child: Row(
            children: <Widget>[
               Container(
                child:  CircleAvatar(child: Text(name[0].toUpperCase(),style: const TextStyle(fontSize: 42.0),)),
                width: 80.0,
                height: 80.0,
                margin: const EdgeInsets.only(right: 10.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name,style: TextStyle(fontSize: 20.0),maxLines: 12,),
                   Text("Language : $language"),
//                    new Text(description,maxLines: 12,),
                  Text("Star : $stargazers_count"),
                  Text("Fork : $forks_count"),
                ],
              ),
            ],
          )
      ),
    );
  }
  }

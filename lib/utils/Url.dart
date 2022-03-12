class Url{
  final String end_point ="https://api.github.com/users/";
  final String username;
  Url({required this.username});

  String getUrl(){
    return end_point+username;
  }
}
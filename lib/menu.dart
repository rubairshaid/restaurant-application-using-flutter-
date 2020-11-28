
class Menu {
  int id ; 
  int restid;
  String name ; 
  String descr;
  int price ;
  String image ;
  int rating;
  bool favarite = false;
  bool ordered = false ; 
  String resturant ; 
  int cnt =0;

  Menu({this.id , this.restid , this.name , this.descr , this.price , this.image , this.rating ,this.resturant });

  factory Menu.fromJson(dynamic jsonMenu){
    return Menu(
      id: jsonMenu['id'],
      restid: jsonMenu['rest_id'],
      name: jsonMenu['name'],
      descr: jsonMenu['descr'],
      price: jsonMenu['price'],
      image: 'http://appback.ppu.edu/static/' + jsonMenu['image'],
      rating: 2, // this must change (i did this because rating has null value)
      resturant: "ruba",
    );
  }
  void setResturant(String restname)=>this.resturant = restname;
}
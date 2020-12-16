import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talabat/loading.dart';
import 'menu.dart';


void main() {
  runApp(ChangeNotifierProvider(
    create: (context)=> MenuProvider(),
    child: MyApp(),

  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading(),
    );
  }
}


class MenuProvider extends ChangeNotifier{

  List<Menu> orderedMenu = [];
  List<Menu> fav =[];
  int totalPrice =0;

  void addfav(Menu menu){
    fav.add(menu);
    print ([fav]);
    notifyListeners();
  }
  void removefav(Menu menu){
    fav.remove(menu);
    notifyListeners();
  }

    void addOrder(Menu menu){
    orderedMenu.add(menu);
    print ([orderedMenu]);
    notifyListeners();
  }

   void removeOrder(Menu menu){
    totalPrice -= menu.cnt * menu.price;
    orderedMenu.remove(menu);
    notifyListeners();
  }

  void initialprice(int price ){
    orderedMenu.forEach((element) {totalPrice += element.price;});
  }

  void addprice(int price ){
    totalPrice+=price;
    notifyListeners();
  }
  void clearData(){
    orderedMenu.forEach((element) {element.cnt=0; element.ordered=false;});
    orderedMenu.clear();
    totalPrice=0;
    notifyListeners();
  }
  List<Menu> getFav() => fav;
  List<Menu> getOrdered() => orderedMenu;
  int getPrice() => totalPrice;
  
}

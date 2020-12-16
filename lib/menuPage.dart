
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'menu.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:rating_bar/rating_bar.dart';

class MenuPage extends StatefulWidget {
  final List<Menu> snap;
  MenuPage(this.snap);

  @override
  _MenuPageState createState() => _MenuPageState(snap);
}



class _MenuPageState extends State<MenuPage> {

  List<Menu> snap;
  
  _MenuPageState(this.snap);

  Future<List<Menu>> resMenu ; 
//string rest name , int rest id
  // Future<List<Menu>> fetchMenu() async{

  //   List<Menu> returnedMenu =[];
  //   http.Response httpRes = await http.get ('http://appback.ppu.edu/menus/$resId');
  //   if (httpRes.statusCode == 200)
  //   {
  //     var jsonStr = jsonDecode(httpRes.body) as List;
  //     //returnedMenu = jsonStr.map((element)=> Menu.fromJson(element)).toList();
  //     for (int i=0 ;i<jsonStr.length;i++)
  //     {
  //       Menu m = Menu.fromJson(jsonStr[i]);
  //       returnedMenu.add(m);
  //       m.setResturant(resName);
  //     }
      
  //   }
  //   return returnedMenu;

  // }
 
 @override
  void initState() {
    super.initState();
   // resMenu = fetchMenu();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          //future: resMenu,
          builder: (context , snapshot){
            if (snap.isNotEmpty)
            {
              //List<Menu> snap = snapshot.data;
              return Expanded(
                child: Container(
                  color: Colors.orange[100],
                  child: ListView.builder(
                    itemCount: snap.length ,
                    itemBuilder: (context , int index )
                    {
                      return Container(
                        margin: EdgeInsets.fromLTRB(5,1,5,1),
                        height: 150,
                        child: Card(
                          color: Colors.orangeAccent[900],
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width:2 ,color: Colors.blue[50],),
                            borderRadius: BorderRadius.all(Radius.circular(10),),),
                          child: Container(
                            padding: EdgeInsets.all(3),
                            child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      //padding: EdgeInsets.all(3),
                                      margin: EdgeInsets.fromLTRB(7, 5, 10, 5),
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        child: Image.network(snap[index].image , fit: BoxFit.fill,),
                                        borderRadius: BorderRadius.circular(12),
                                        )
                                      ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snap[index].name , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),),
                                          AutoSizeText(snap[index].descr ,style :TextStyle(fontSize: 12,)),
                                          Text('price :${snap[index].price}'),
                                            Padding(
                                              padding: EdgeInsets.all(2),
                                              child: RatingBar.readOnly(
                                                  initialRating: snap[index].rating.toDouble(),//may error appear here after filling rating field
                                                  isHalfAllowed: true,
                                                  halfFilledIcon: Icons.star_half,
                                                  filledIcon: Icons.star,
                                                  emptyIcon: Icons.star_border,
                                                  size: 20,
                                                ),
                                              ),
                                          ],
                                        ),
                                    ),
                                    Consumer<MenuProvider>
                                    (builder: (context , fav , child){
                                      return 
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FlatButton(
                                            onPressed: (){
                                              snap[index].ordered?
                                              Provider.of<MenuProvider>(context , listen: false).removeOrder(snap[index])
                                              :Provider.of<MenuProvider>(context , listen: false).addOrder(snap[index]);
                                              setState(() {
                                                snap[index].ordered = !snap[index].ordered;               
                                              });
                                            }, 
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(width: 2, color: Colors.white),
                                              color: Colors.grey[300]),
                                              child: Icon(snap[index].ordered?Icons.done : Icons.add , color: Colors.black,),
                                              ),
                                            ),
                                            FlatButton(
                                                  onPressed: (){
                                                    snap[index].favarite?
                                                    Provider.of<MenuProvider>(context, listen: false).removefav(snap[index])
                                                    :Provider.of<MenuProvider>(context, listen: false).addfav(snap[index]);
                                                    setState(() { 
                                                    });
                                                    snap[index].favarite = !snap[index].favarite;
                                                  },
                                                  child: snap[index].favarite? 
                                                  Icon( Icons.star, color: Colors.yellow ,size: 32,): Icon(Icons.star_border ,size: 32),
                                                ),
                                            
                                        ],
                                      );
                                    }
                                    ),
                                  ],
                                ),
                          ),
                        )
                      );
                    }
                   ),
                )
                );
            }
            else
              return Container(
                margin: EdgeInsets.only(top: 50),
                child: SpinKitFoldingCube(
                            color: Colors.blue,
                            size: 50.0,
                          ),
              );
          }
          ),
      ],
    );
  }
}

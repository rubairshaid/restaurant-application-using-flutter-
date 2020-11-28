import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';
import 'main.dart';
import 'menu.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orangeAccent,
              leading: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    size: 30,
                  )),
              title: Text("Favorite menus",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
              centerTitle: true,
            ),
            body: Consumer<MenuProvider>(builder: (context, fav, child) {
              List<Menu> favItems = Provider.of<MenuProvider>(context, listen: false).getFav();
              return ListView.builder(
                  itemCount: Provider.of<MenuProvider>(context, listen: false).getFav().length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: EdgeInsets.fromLTRB(5,1,5,1),
                        child: Card(
                          color: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width:2 ,color: Colors.blue[50],), 
                            borderRadius: BorderRadius.all(Radius.circular(10),),),
                          child: Container(
                            padding: EdgeInsets.all(3),
                            child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5, 3, 7, 3),
                                      padding: EdgeInsets.all(10),
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        child: Image.network(favItems[index].image , fit: BoxFit.fill,),
                                        borderRadius: BorderRadius.circular(12),
                                        )
                                      ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(favItems[index].name , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),),
                                          Text('price :${favItems[index].price}'),
                                            Padding(
                                              padding: EdgeInsets.all(2),
                                              child: RatingBar.readOnly(
                                                  initialRating: favItems[index].rating.toDouble(),//may error appear here after filling rating field
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
                                              favItems[index].ordered?
                                              Provider.of<MenuProvider>(context , listen: false).removeOrder(favItems[index])
                                              :Provider.of<MenuProvider>(context , listen: false).addOrder(favItems[index]);
                                              setState(() {
                                                favItems[index].ordered = !favItems[index].ordered;               
                                              });
                                            }, 
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(width: 2, color: Colors.white),
                                              color: Colors.grey[300]),
                                              child: Icon(favItems[index].ordered?Icons.done : Icons.add , color: Colors.black,),
                                              ),
                                            ),
                                            FlatButton(
                                                  onPressed: (){
                                                    favItems[index].favarite = false;
                                                    Provider.of<MenuProvider>(context, listen: false).removefav(favItems[index]);
                                                    setState(() {});
                                                  },
                                                  child: Icon(Icons.delete, size: 30, color: Colors.grey,),
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
                  });
            })));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';

import 'main.dart';
import 'menu.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_backspace,
              size: 30,
              color: Colors.white,
            )),
        title: Text(
          "Order",
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Consumer<MenuProvider>(
        builder: (context, orderedMenu, child) {
          List<Menu> orderedItems =
              Provider.of<MenuProvider>(context, listen: false).getOrdered();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: Provider.of<MenuProvider>(context, listen: false)
                        .getOrdered()
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                          child: Card(
                            color: Colors.orangeAccent[900],
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2,
                                color: Colors.blue[50],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(5, 3, 7, 3),
                                      padding: EdgeInsets.all(10),
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        child: Image.network(
                                          orderedItems[index].image,
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            orderedItems[index].resturant +
                                                " resturant",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          orderedItems[index].name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            'price :${orderedItems[index].price}'),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              color: Colors.blue,
                                              icon:
                                                  Icon(Icons.horizontal_rule),
                                              onPressed: () {
                                                if (orderedItems[index].cnt -
                                                        1 >=
                                                    0) {
                                                  orderedItems[index].cnt -= 1;
                                                  Provider.of<MenuProvider>(
                                                          context,
                                                          listen: false)
                                                      .addprice(-1 *
                                                          orderedItems[index]
                                                              .price);
                                                  setState(() {});
                                                }
                                              }),
                                          Text('${orderedItems[index].cnt}'),
                                          IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () {
                                                orderedItems[index].cnt += 1;
                                                Provider.of<MenuProvider>(
                                                        context,
                                                        listen: false)
                                                    .addprice(
                                                        orderedItems[index]
                                                            .price);
                                                setState(() {});
                                              }),
                                        ],
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          orderedItems[index].ordered = false;
                                          Provider.of<MenuProvider>(context,
                                                  listen: false)
                                              .removeOrder(orderedItems[index]);
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                    "Total price is: " +
                        Provider.of<MenuProvider>(context, listen: false)
                            .getPrice()
                            .toString(),
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              FlatButton(
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12)),
                  color: Colors.orangeAccent,
                  onPressed: () {
                    Provider.of<MenuProvider>(context, listen: false)
                        .clearData();
                    setState(() {});
                  },
                  child: Text("Confirm order",
                      style: TextStyle(color: Colors.white))),
            ],
          );
        },
      ),
    ));
  }
}

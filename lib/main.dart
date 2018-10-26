import 'package:flutter/material.dart';
import 'package:hello_flutter/shopping_cart.dart';

//void main(){
//  runApp(new MaterialApp(
//    title: 'Shopping App',
//    home: new ShoppingList(
//      products: <Product>[
//        new Product(name: 'Eggs'),
//        new Product(name: 'Flour'),
//        new Product(name: 'Chocolate chips'),
//        new Product(name: 'Orange'),
//        new Product(name: 'Apple')
//      ],
//    ),
//  ));
//}


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  Widget buildButtonColumn(BuildContext context, IconData icon, String label, onTap){
    Color color = Theme.of(context).primaryColor;

    return new GestureDetector(
      onTap: onTap,
      child: new Column(
        mainAxisSize:  MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: new Text(
                  label,
                  style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: color)
              )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleSectionText = new Expanded(child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: new Text('Oeschinen Lake Campground', style: new TextStyle(fontWeight: FontWeight.bold)),
        ),
        new Text('Kandersteg, Switzerland', style: new TextStyle(color: Colors.grey[500]))
      ],
    ));


    Widget imageSection = new Image.asset(
        'images/lake.jpg',
        height: 240.0,
        fit: BoxFit.cover
    );

    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(children: <Widget>[
        titleSectionText,
        new Icon(Icons.star, color: Colors.red[500]),
        new Text('41')
      ]),
    );


    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(context, Icons.call, 'CALL', (){
            print('CALL');
          }),
          buildButtonColumn(context, Icons.near_me, 'ROUTE', (){
            print('ROUTE');
          }),
          buildButtonColumn(context, Icons.share, 'SHARE', (){
            print('SHARE');
          })
        ],
      ),
    );


    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
          '''
          Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
          ''',
        softWrap: true,
      ),
    );

    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(primaryColor: Colors.white),
      home: new Scaffold(
        body: new ListView(children: <Widget>[
          imageSection,
          titleSection,
          buttonSection,
          textSection
        ]),
      )
    );
  }
}

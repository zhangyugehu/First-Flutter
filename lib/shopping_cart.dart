import 'package:flutter/material.dart';

class Product{
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingCartItem extends StatelessWidget{
  ShoppingCartItem({Product product, this.inCart, this.onCartChanged})
      :product = product, super(key: new ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context){
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context){
    if(!inCart) return null;
    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: (){
        onCartChanged(product, inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget{
  ShoppingList({Key key, this.products}):super(key: key);
  final List<Product> products;
  @override
  _ShoppingListState createState(){
    print('ShoppingList createState');
    return new _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList>{
  Set<Product> _shoppingCart = new Set<Product>();

  void _handleCartChanged(Product product, bool inCart){
    setState(() {
      if(inCart){
        _shoppingCart.remove(product);
      }else{
        _shoppingCart.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('Shopping Cart')),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product){
          return new ShoppingCartItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      )
    );
  }
}

//void main(){
//  runApp(new MaterialApp(
//    title: 'Shopping App',
//    home: new ShoppingList(
//      products: [
//        new Product(name: 'Eggs'),
//        new Product(name: 'Flour'),
//        new Product(name: 'Chocolate chips'),
//        new Product(name: 'Orange'),
//        new Product(name: 'Apple')
//      ],
//    ),
//  ));
//}
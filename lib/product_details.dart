import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'model/product_list_model.dart';
import 'model/cart_model.dart';
//import 'package:gctask/product_details.dart';
import 'shopping_cart.dart';
import 'checkout.dart';
import 'dart:convert';

class ProductDetailsPage extends StatefulWidget {
  final String name;
  final String title;
  final int price;
  final int discount;
  final String image;
  final String des;

  const ProductDetailsPage({Key? key,required this.title,required this.name, required this.image, required this.price,required this.discount,required this.des,}) : super(key: key);
 
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  int cartInc = 0;
  //List arrData = [];

  getdatas() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var json = pref.getString('dataKey')!;
    setState(() {
    final jsonMap = jsonDecode(json);
    List<CartModel> temp = (jsonMap as List)
        .map((itemWord) => CartModel.fromJson(itemWord))
        .toList();
    
      cartInc = temp.length;
      arrData = temp;
    });

  }

  shappingCartCount(name,discount)async{
    // SharedPreferences pref = await SharedPreferences.getInstance();
    bool isAdded = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    List cartCheckList = [];
    for(var check in arrData){
      cartCheckList.add(check.name);  
    }
    for(var item in cartCheckList){
      if(item==name){
        isAdded = true;
        break;
      }else{
        isAdded = false;
      }
    }
    if(isAdded == true){
      // Fluttertoast.showToast(msg: 'Item already in the cart!', toastLength: Toast.LENGTH_LONG,backgroundColor:Colors.red);
    }else{
      cartInc=cartInc+1;
      CartModel addCarts = CartModel(
      name : name,
      discount: discount,
      qty: cartInc,
      );
      arrData.add(addCarts);
      String json = jsonEncode(arrData);
      pref.setString('dataKey', json);
      }
  }

  @override
  void initState() {
    getdatas();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Center(
          child:Column(
            children:const [
              Text('Product',style:TextStyle(color: Colors.black)),
            ],
          )
        ),
        iconTheme:const IconThemeData(
            color: Colors.black, //change your color here
          ),
        actions: [
          IconButton(
              padding: const EdgeInsets.fromLTRB(0,0,10,0),
              constraints: const BoxConstraints(),
              icon: _customShoppingCart(cartInc),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ShoppingCartPage()));
            }),
          ],
      ),
      body: Column(
        children: [
          Container(
            padding:const EdgeInsets.symmetric(horizontal: 0,vertical: 2),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Image.network(widget.image),
          ),
          Container(
            padding:const EdgeInsets.fromLTRB(12,0,0,5),
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Row(
              children: [
                Text('৳${widget.discount}',style:const TextStyle(color: Colors.blue,fontSize: 26,fontWeight: FontWeight.bold),),
                const SizedBox(width: 17,),
                 Text.rich(TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '৳${widget.price}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                      ],
                  ),
                  ),
              ],
            ),
          ),
          Container(
            padding:const EdgeInsets.fromLTRB(12,0,0,0),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(widget.name,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                const SizedBox(height: 6,),
                Text(widget.title,style:const TextStyle(color:Colors.grey,fontSize: 14,)),
              ]
            )
          ),
          Container(
            padding:const EdgeInsets.fromLTRB(12,0,12,0),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                const Text('Short Description',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                const SizedBox(height: 6,),
                Text(widget.des,style: const TextStyle(fontSize: 15,),),
              ]
            )
          ),
          
        ],
      ),
      bottomNavigationBar: Stack(
        //overflow: Overflow.visible,
        alignment: const FractionalOffset(.5, 1.0),
        children: [
          Container(
            width:MediaQuery.of(context).size.width,
            height: 60,
            color: Colors.white,
            child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child:Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    height: 125,
                    alignment: Alignment.center,
                    color: Colors.black12,         
                    //width:MediaQuery.of(context).size.width/2,
                    padding:const EdgeInsets.all(1),
                    child: const Text('Add to Cart',style: TextStyle(fontSize: 17,color:Colors.blueAccent),),
                ),
                  onPressed: (){
                    setState(() {
                      shappingCartCount(widget.name,widget.discount);
                    });
                    
                    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomNavigationBarPage()), (Route<dynamic> route) => false);
                  },
                ),
              TextButton(
                  child:Container(
                    color: Colors.blueAccent,
                    height: 125,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width/2.2,
                    padding:const EdgeInsets.all(1),
                    child: const Text('Bye Now',style: TextStyle(fontSize: 17,color:Colors.white),),
                ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CheckoutPage()));

                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _customShoppingCart(int count) {
    return Stack(
      children: <Widget>[
        const Icon(Icons.shopping_cart_outlined, color: Colors.black),
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints:const BoxConstraints(
              minWidth: 14,
              minHeight: 14,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style:const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}

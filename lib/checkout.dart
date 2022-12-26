import 'package:flutter/material.dart';
import 'shopping_cart.dart';
import 'model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CheckoutPage extends StatefulWidget {
   const CheckoutPage({Key? key}) : super(key: key);
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int cartInc = 0;
double _totalPrice = 0;

void _countTotalPrice()async{
    _totalPrice = 0;
    for(int i=0;i<arrData.length;i++){
      _totalPrice += arrData[i].discount * arrData[i].qty;  
    }
    // if(_getCouponDiscount != null){
    //   _totalPrice = _totalPrice - _getCouponDiscount;
    // }else{
    //   _totalPrice = _totalPrice;
    // }

}
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
    // ignore: avoid_print
  print(arrData);
  }

  @override
  void initState() {
    getdatas();
    _countTotalPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme:const IconThemeData(
            color: Colors.black, //change your color here
        ),
        title:  Center(
          child:Column(
            children:const [
              Text('Checkout',style:TextStyle(color: Colors.black)),
            ],
          )
         
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.fromLTRB(0,0,10,0),
              constraints: const BoxConstraints(),
              icon: _customShoppingCart(arrData.length),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ShoppingCartPage()));
            }),
          ],
      ),
      body: Column(
        children: [
          Container(
            width:MediaQuery.of(context).size.width,
            padding:const EdgeInsets.all(10),
              child:const Text('Shipping Information Form',style: TextStyle(fontSize: 18,),),
          ), 
           Container(
            width:MediaQuery.of(context).size.width,
            padding:const EdgeInsets.all(10),
            child: const TextField(
              
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
                    width: MediaQuery.of(context).size.width/2.4,
                    height: 135,
                    alignment: Alignment.center,
                    color: Colors.black12,         
                    //width:MediaQuery.of(context).size.width/2,
                    padding:const EdgeInsets.all(1),
                    child: Column(
                      children: [
                        const Text('Total Payable',style: TextStyle(fontSize: 15,color:Colors.grey),),
                        Text('৳'+(_totalPrice-15).toString(),style:const TextStyle(fontSize: 15,color:Colors.grey),),
                      ],
                    )

                ),
                  onPressed: (){
                    setState(() {
                     // shappingCartCount(widget.name,widget.discount);
                    });
                    
                    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomNavigationBarPage()), (Route<dynamic> route) => false);
                  },
                ),
              TextButton(
                  child:Container(
                    color: Colors.blueAccent,
                    height: 135,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width/2,
                    padding:const EdgeInsets.all(1),
                    child: const Text('Confirmation',style: TextStyle(fontSize: 17,color:Colors.white),),
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

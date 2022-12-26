import 'package:flutter/material.dart';
import 'model/product_list_model.dart';
import 'checkout.dart';
import 'model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ShoppingCartPage extends StatefulWidget {
   const ShoppingCartPage({Key? key}) : super(key: key);
  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

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
              Text('My Cart',style:TextStyle(color: Colors.black)),
            ],
          )
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.fromLTRB(0,0,10,0),
              constraints: const BoxConstraints(),
              icon: _customShoppingCart(arrData.length),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingCartPage()));
            }),
          ],
      ),
      body: Container(
        padding:const EdgeInsets.symmetric(vertical: 2),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
          Row(
            children:[
              Divider(height: 0, color: Colors.grey[400]),
              const Icon(Icons.pie_chart_outline_outlined),
              Container(
                width:MediaQuery.of(context).size.width/1.2,
                padding:const EdgeInsets.all(10),
                  child:const Text('Medicines',style: TextStyle(fontSize: 19),),
              ),  
              Divider(height: 0, color: Colors.grey[400]),
            ]
          ),
          Row(
            children:[ 
              Container(
                width:MediaQuery.of(context).size.width/3.1,
                padding:const EdgeInsets.all(10),
                  child:const Text('Type-Item',style: TextStyle(fontSize: 13,color: Colors.grey),),
              ), 
              Container(
                width:MediaQuery.of(context).size.width/3.1,
                padding:const EdgeInsets.all(10),
                  child:const Text('QTY',style: TextStyle(fontSize: 13,color: Colors.grey),),
              ),  
              Container(
                width:MediaQuery.of(context).size.width/3.1,
                padding:const EdgeInsets.all(10),
                  child:const Text('Price(Tk.)',style: TextStyle(fontSize: 13,color: Colors.grey),),
              ), 
            ]
          ),
            for (var item in arrData) 
              Row(
                children: [
                Container(
                width:MediaQuery.of(context).size.width/3.1,
                padding:const EdgeInsets.all(10),
                  child: Text(item.name,style:const TextStyle(fontSize: 13,),),
                ), 
                Container(
                width:MediaQuery.of(context).size.width/3.1,
                padding:const EdgeInsets.all(10),
                  child: Text(item.qty.toString(),style:const TextStyle(fontSize: 15,),),
                ), 
                Container(
                width:MediaQuery.of(context).size.width/3.1,
                padding:const EdgeInsets.all(10),
                  child: Text(item.discount.toString(),style:const TextStyle(fontSize: 15,),),
                ), 
                ],
              ),
               Divider(height: 0, color: Colors.grey[400]),
              Row(
                children:[
                  Divider(height: 0, color: Colors.grey[400]),
                  Container(
                    width:MediaQuery.of(context).size.width/1.5,
                    padding:const EdgeInsets.all(10),
                      child:const Text('Total',style: TextStyle(fontSize: 14),),
                  ),  
                  //const Text('df'),
                   Text('৳'+_totalPrice.toString()),
                  Divider(height: 0, color: Colors.grey[400]),
                ]
              ),
              Container(
                width:MediaQuery.of(context).size.width,
                padding:const EdgeInsets.all(10),
                  child: Text('Order Sammury-'+(arrData.length.toString())+' items',style: const TextStyle(fontSize: 17,color: Colors.grey),),
              ),
              Row(
              children:[ 
                Container(
                  width:MediaQuery.of(context).size.width/2,
                  padding:const EdgeInsets.all(10),
                    child:const Text('Grand Total',style: TextStyle(fontSize: 15,color: Colors.grey),),
                ), 
                Container(
                  width:MediaQuery.of(context).size.width/2,
                  padding:const EdgeInsets.all(10),
                    child: Text('৳'+_totalPrice.toString(),style:const TextStyle(fontSize: 15,color: Colors.grey),),
                ), 
              ]
            ),  
            Row(
              children:[ 
                Container(
                  width:MediaQuery.of(context).size.width/2,
                  padding:const EdgeInsets.all(10),
                    child:const Text('Promo',style: TextStyle(fontSize: 15,color: Colors.grey),),
                ), 
                Container(
                  width:MediaQuery.of(context).size.width/3,
                  padding:const EdgeInsets.all(10),
                    child: TextButton(child:const Text('Apply Promo'),onPressed: () => {_showMyDialog()},),
                ), 
              ]
            ),  
            Row(
              children:[ 
                Container(
                  width:MediaQuery.of(context).size.width/2,
                  padding:const EdgeInsets.all(10),
                    child:const Text('Save',style: TextStyle(fontSize: 15,color: Colors.grey),),
                ), 
                Container(
                  width:MediaQuery.of(context).size.width/2,
                  padding:const EdgeInsets.all(10),
                    child: Text('৳'+15.toString(),style:const TextStyle(fontSize: 15,color: Colors.grey),),
                ), 
              ]
            ),  
            Row(
              children:[ 
                Container(
                  width:MediaQuery.of(context).size.width/2,
                  padding:const EdgeInsets.all(10),
                    child:const Text('Total Payable',style: TextStyle(fontSize: 16,color: Colors.black),),
                ), 
                Container(
                  width:MediaQuery.of(context).size.width/2,
                  padding:const EdgeInsets.all(10),
                    child: Text('৳'+(_totalPrice-15).toString(),style:const TextStyle(fontSize: 16,color: Colors.black),),
                ), 
              ]
            ),  
          ],
          
        ),
        
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
                    child: const Text('Checkout',style: TextStyle(fontSize: 17,color:Colors.white),),
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
  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Apply Coupon'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('25% Discount Applied !'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
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

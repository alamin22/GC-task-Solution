import 'package:flutter/material.dart';
import 'model/product_list_model.dart';
import 'product_details.dart';
import 'model/cart_model.dart';
import 'shopping_cart.dart';

class ProductListPage extends StatefulWidget {
   const ProductListPage({Key? key}) : super(key: key);
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Center(
          child:Column(
            children:const [
              Text('Medicine',style:TextStyle(color: Colors.black)),
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
      body: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            return 
            TextButton(
            child:ListTile(
                trailing: TextButton(
                  onPressed: () => {

                  },
                  child: const Text('add to cart',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                title: Text(productList[index].name,style: const TextStyle(fontSize: 17,)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5,),
                    Text(productList[index].title,style: const TextStyle(fontSize: 12,)),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                          Text('৳${productList[index].discount}',style: const TextStyle(color: Colors.blue,fontSize: 15,fontWeight:FontWeight.bold),),
                          const SizedBox(width: 15,),
                          Text.rich(TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '৳${productList[index].price}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                        ),
                        )
                      ],
                    )
                  ],
                )
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(name: productList[index].name,title: productList[index].title,price: productList[index].price,discount: productList[index].discount,image: productList[index].image,des:productList[index].des)));
            },
            );
          }
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

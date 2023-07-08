import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/model/product.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:online_store/view/common%20widget/snackbar.dart';

class ProductDetails extends ConsumerWidget {
  final Product product;

  ProductDetails({required this.product});

  @override
  Widget build(BuildContext context, ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2C2830),
        title: Text('Product Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.3,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff2C2830).withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(3, -1))
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Description', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.sp),),
                          Row(
                            children: [
                              Text('Rating: '),
                              Text('${product.rating.rate.toString()}/5', style: TextStyle(fontSize: 11.sp,),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      Text(product.description, textAlign: TextAlign.left,)
                    ],
                  ),
                  ElevatedButton.icon(
                      onPressed: (){
                        final response = ref.read(cartProvider.notifier).add(product);
                        if(response == 'added to cart list'){
                          SnackShow.showSuccess(context, 'Added to your cart list');
                        }else if(response == 'this item is already in cart list'){
                          SnackShow.showFailure(context, 'This item is already in your cart list');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2C2830),
                        minimumSize: Size(double.infinity, 45.h)
                  ),
                    icon : Icon(Icons.add_shopping_cart_outlined),
                    label: Align(
                        alignment: Alignment.center,
                        child: Text('Add to Cart',style: TextStyle(fontSize: 14.sp),)),)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(product.title,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Price'),
                        Text('Rs ${product.price.toString()}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Container(
                        height: 160.h,
                        width: 180.w,
                        child: Hero(
                            tag: 'image-${product.id}',
                            child: Image.network(product.image,)))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

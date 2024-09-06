import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductsDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductsDetailsPage({super.key, required this.product});

  @override
  State<ProductsDetailsPage> createState() => _ProductsDetailsPageState();
}

class _ProductsDetailsPageState extends State<ProductsDetailsPage> {
  int selectedSize = 0;

  void onPressed() {
    if (selectedSize != 0) {
      context.read<CartProvider>().addProduct(
        {
          "id": widget.product["id"],
          "title": widget.product["title"],
          "price": widget.product["price"],
          "imageURL": widget.product["imageURL"],
          "company": widget.product["company"],
          "sizes": selectedSize,
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product added scucessfuly")));
      // print(cart);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please select size")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              widget.product["title"] as String,
              style: Theme.of(context).textTheme.titleLarge,
              
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.product["imageURL"] as String,
              height: 150,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 241, 249, 1),
              borderRadius: BorderRadius.circular(
                40,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$${widget.product["price"].toString()}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product["sizes"] as List).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                selectedSize = (widget.product["sizes"] as List)
                                    .elementAt(index);
                              },
                            );
                          },
                          child: Chip(
                            backgroundColor: (widget.product["sizes"] as List)
                                        .elementAt(index) ==
                                    selectedSize
                                ? Theme.of(context).primaryColor
                                : const Color.fromRGBO(245, 241, 249, 1),
                            label: Text((widget.product["sizes"] as List)
                                .elementAt(index)
                                .toString()),
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      fixedSize: const Size(350, 50),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_basket,
                          size: 30,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

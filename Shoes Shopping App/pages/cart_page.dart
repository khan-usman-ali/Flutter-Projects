import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/provider/cart_provider.dart';
// import 'package:flutter_shopping_app/global_variables.dart';
// import 'package:flutter_shopping_app/global_variables.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Cart")),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Delete Product",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: Text(
                        "Are you sure you want to delete the product",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context
                                .read<CartProvider>()
                                .removeProduct(cartItem);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                size: 35,
                color: Colors.red,
              ),
            ),
            title: Text(
              cartItem["title"] as String,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text(
              "Sizes: ${cartItem["sizes"].toString()}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                cartItem["imageURL"] as String,
              ),
              radius: 35,
            ),
          );
        },
      ),
    );
  }
}

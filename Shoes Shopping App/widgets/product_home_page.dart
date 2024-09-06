import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/widgets/display_products.dart';
import 'package:flutter_shopping_app/global_variables.dart';
import 'package:flutter_shopping_app/pages/products_details_page.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  Set<String> brandNames = {
    "All",
    "Addidas",
    "Nike",
    "Bata",
    "Service",
  };

  late String selectedBrandName;

  @override
  void initState() {
    super.initState();
    selectedBrandName = brandNames.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(223, 209, 209, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Shoes\nCollection",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: brandNames.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBrandName = brandNames.elementAt(index);
                          });
                        },
                        child: Chip(
                          label: Text(
                            brandNames.elementAt(index),
                          ),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          side: const BorderSide(
                            color: Color.fromRGBO(
                              245,
                              247,
                              249,
                              1,
                            ),
                          ),
                          backgroundColor:
                              brandNames.elementAt(index) == selectedBrandName
                                  ? Theme.of(context).primaryColor
                                  : const Color.fromRGBO(
                                      245,
                                      247,
                                      249,
                                      1,
                                    ),
                          labelPadding: const EdgeInsets.all(
                            10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
               
                    if (constraints.maxWidth > 1050) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.65,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return ProductsDetailsPage(product: product);
                                },
                              ));
                            },
                            child: DisplayProducts(
                              title: product['title'] as String,
                              price: product["price"] as double,
                              images: product["imageURL"] as String,
                              color: index.isEven
                                  ? const Color.fromRGBO(216, 240, 252, 1)
                                  : const Color.fromRGBO(
                                      245,
                                      247,
                                      249,
                                      1,
                                    ),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductsDetailsPage(
                                        product: product);
                                  },
                                ),
                              );
                            },
                            child: DisplayProducts(
                              title: product['title'] as String,
                              price: product["price"] as double,
                              images: product["imageURL"] as String,
                              color: index.isEven
                                  ? const Color.fromRGBO(216, 240, 252, 1)
                                  : const Color.fromRGBO(
                                      245,
                                      247,
                                      249,
                                      1,
                                    ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

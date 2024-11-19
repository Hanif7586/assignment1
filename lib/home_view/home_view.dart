import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../product_details_view/productdetailsview.dart';
import '../widget/color.dart';
import 'ProductProvider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchProducts(); // Trigger data fetching
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Products',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
        backgroundColor:primaryColor
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (productProvider.error.isNotEmpty) {
            return Center(child: Text(productProvider.error));
          }

          if (productProvider.products.isEmpty) {
            return Center(child: Text('No products available'));
          }

          var products = productProvider.products;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 2 / 2.5, // Adjust the size of the grid items
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to ProductDetailsView when the card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsView(
                          product: product, // Pass the product to the details screen
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Card(
                            child: Image.network(
                              product['thumbnail'],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        // Title and price below the thumbnail
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1, // Restrict to a single line
                                overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 4),
                              Text(
                                '\$${product['price']}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

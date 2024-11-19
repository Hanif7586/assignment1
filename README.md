Assignment 1
Flutter Product List App
A Flutter application that fetches product data (name, image, and price) from the DummyJSON Products API using the http package.

Features
Fetch and display product data using the http package.
Show product details including:
Name
Image
Price
User-friendly and responsive UI.
API Endpoint
Endpoint: https://dummyjson.com/products

![WhatsApp Image 2024-11-19 at 02 31 44_0b4d00d0](https://github.com/user-attachments/assets/cd28138e-9372-42d1-a810-4201900c78c4)


Example JSON Response:
json
Copy code
{
  "products": [
    {
      "id": 1,
      "title": "iPhone 9",
      "price": 549,
      "thumbnail": "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
    }
    ...
  ]
}
Dependencies
Add the http package to your pubspec.yaml file:

yaml
Copy code
dependencies:  
  flutter:  
    sdk: flutter  

  http: ^0.15.0  

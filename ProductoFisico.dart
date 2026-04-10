import 'Producto.dart';

class Productofisico extends Producto {
  String payment_type;
  Productofisico(String name, double price, this.payment_type) : super(name, price);
}

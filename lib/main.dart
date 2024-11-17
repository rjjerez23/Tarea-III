import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const InventoryDashboard());
}

class InventoryDashboard extends StatelessWidget {
  const InventoryDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
      theme: ThemeData(
        primaryColor: Colors.teal,
        hintColor: Colors.tealAccent,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Roboto', color: Colors.grey[800]),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final List<Map<String, String>> recentOrders = List.generate(10, (index) {
    final random = Random();
    
    final orderNumber = (random.nextInt(900000) + 100000).toString();
    final products = [
      'iPhone 16 Pro Max',
      'Samsung Galaxy Z Flip 5',
      'MacBook Pro 16"',
      'Dell XPS 13',
      'Sony WH-1000XM5',
      'Canon EOS R6',
      'Apple Watch Ultra 2',
      'Samsung Galaxy Tab S9',
      'Google Pixel 8 Pro',
      'LG OLED TV C2',
    ];
    final product = products[random.nextInt(products.length)];
    final price = 'RD\$ ${random.nextInt(80001) + 10000}';

    return {
      'order': 'Orden: $orderNumber',
      'product': 'Producto: $product',
      'price': 'Precio: $price',
    };
  });

  final List<Map<String, String>> lowStockAlerts = [
    {'product': 'Mouse Logitech M720', 'stock': '5'},
    {'product': 'Monitor Dell 24"', 'stock': '2'},
    {'product': 'Teclado Mecánico RGB', 'stock': '3'},
  ];

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Dashboard'),
        backgroundColor: Colors.teal,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSummaryCard(
                      'Productos en Stock', '120', Colors.green, Icons.check_circle),
                  _buildSummaryCard(
                      'Productos Agotados', '15', Colors.red, Icons.error),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSummaryCard('Órdenes Pendientes', '25', Colors.orange,
                      Icons.hourglass_empty),
                  _buildSummaryCard(
                      'Inventario Total', '450', Colors.blue, Icons.storage),
                ],
              ),
              const SizedBox(height: 32),
              _buildSectionHeader('Alertas de Inventario Bajo'),
              ...lowStockAlerts.map(
                (alert) => Card(
                  color: Colors.red[50],
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.warning, color: Colors.red, size: 30),
                    title: Text(alert['product']!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Stock: ${alert['stock']} unidades'),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildSectionHeader('Órdenes Recientes'),
              ...recentOrders
                  .map(
                    (order) => Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.receipt_long,
                            color: Colors.tealAccent, size: 30),
                        title: Text(order['order']!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order['product']!),
                            Text(order['price']!),
                          ],
                        ),
                      ),
                    ),
                  )
                  ,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal[800],
        ),
      ),
    );
  }
}

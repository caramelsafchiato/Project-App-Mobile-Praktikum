import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('D4 TI Vokasi'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // Supaya tidak error saat layar penuh
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text('You have pushed the button this many times:'),
              Text(
                '0', // Contoh nilai counter statis
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 20),

              // a & e. Container Biru (Sama persis dengan contoh foto)
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Container 1',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // a & e. Container Hijau (Sama persis dengan contoh foto)
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Container 2',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // b. Contoh Row (Horizontal)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 50, height: 50, color: Colors.red),
                  const SizedBox(width: 10),
                  Container(width: 50, height: 50, color: Colors.orange),
                ],
              ),

              const SizedBox(height: 20),

              // c. Contoh Stack (Bertumpuk)
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 100, height: 100, color: Colors.amber),
                  const Icon(Icons.star, size: 50, color: Colors.white),
                ],
              ),

              const SizedBox(height: 20),

              // d. Contoh ListView Horizontal
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(5, (index) => 
                    Container(
                      width: 80, 
                      margin: const EdgeInsets.all(5), 
                      color: Colors.purple[100],
                      child: Center(child: Text('Item $index')),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
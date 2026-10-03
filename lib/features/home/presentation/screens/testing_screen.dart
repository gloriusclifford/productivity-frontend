import 'package:flutter/material.dart';
import 'package:productivity_app_frontend/core/widgets/AddJournalDialog.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Screen'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Halaman Preview / Testing',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Memanggil dialog saat tombol diklik
                  showDialog(
                    context: context,
                    builder: (context) => const AddJournalDialog(),
                  );
                },
                child: const Text('Buka Add Journal Dialog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
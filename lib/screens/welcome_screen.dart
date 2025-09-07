import 'package:flutter/material.dart';
import 'package:tasky/screens/Home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 42,
                    width: 42,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Tasky",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(height: 108),
              Text(
                'Welcome To Tasky',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),

              Text(
                'Your Productivity Journey Starts Here',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 24),
              Image(
                image: AssetImage("assets/images/welcome.png"),
                width: 215,
                height: 200,
              ),
              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: Text(
                  'Full Name',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "e.g. Sarah Khalid",
                  hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey[500]!),
                  ),
                ),
              ),

              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF15BB6C),
                  fixedSize: Size(340, 40),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  "Let's Get Started",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

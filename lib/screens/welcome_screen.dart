import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/screens/main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});
  final controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: widget.formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 55,
                        width: 55,
                      ),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium
                      ),
                    ],
                  ),
                  SizedBox(height: 108),
                  Text(
                    'Welcome To Tasky',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: 8),

                  Text(
                    'Your Productivity Journey Starts Here',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 16,
                    )
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: widget.controller,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "e.g. Sarah Khalid",
                    ),
                    
                    style: Theme.of(context).textTheme.labelMedium,
                  ),

                  SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF15B86C),
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (widget.formKey.currentState!.validate()) {
                        
                        await PreferencesManager().setString(
                          "username",
                          widget.controller.text,
                        );
                         Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainScreen();
                          },
                        ),
                      );
                      }
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
        ),
      ),
    );
  }
}

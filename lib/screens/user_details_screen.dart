import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  String userName;
  String motivationQuote;

  UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late TextEditingController userNameController;
  late TextEditingController motivationQuotController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController = TextEditingController(text: widget.userName);

     motivationQuotController = TextEditingController(text: widget.motivationQuote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                title: "User Name",
                controller: userNameController,
                hintText: "Enter your name",
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              CustomTextFormField(
                title: "Motivation Quote",
                controller: motivationQuotController,
                hintText: "Enter your motivation quote",
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return "Please enter your motivation quote";
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(onPressed: () async{
                if(formKey.currentState!.validate()){
                  final pref = await SharedPreferences.getInstance();
                  await pref.setString("username", userNameController.text);
                  await pref.setString("motivation_quote", motivationQuotController.text);
                  Navigator.pop(context,true);
                }


              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
              ),
              child: Text("Save Changes"))

            ],
          ),
        ),
      ),
    );
  }
}

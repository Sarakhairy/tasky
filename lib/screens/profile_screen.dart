import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Default";
  bool isDarkMode = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("username") ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do Tasks"), centerTitle: true),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/avatar.png"),
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.grey[300]!, width: 2),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  "One task at a time. One step closer.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Profile Info", style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("User Details", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.person_outline),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            SizedBox(height: 24),
            Divider(thickness: 1, color: Colors.grey[300]),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Dark Mode", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.dark_mode_outlined),
              trailing: Switch(
                activeTrackColor: Color(0xFF15B86C),
                inactiveTrackColor: Colors.white,
                value: isDarkMode,
                onChanged: (val) {
                  isDarkMode = val;
                  setState(() {
                    
                  });
                },
              ),
            ),
            SizedBox(height: 24),
            Divider(thickness: 1, color: Colors.grey[300]),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Log Out", style: TextStyle(fontSize: 16)),
              leading: Icon(Icons.logout_outlined),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

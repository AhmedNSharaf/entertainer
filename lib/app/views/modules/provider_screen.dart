import 'package:enter_tainer/app/views/modules/my_profile/setting/logout_utils.dart';
import 'package:flutter/material.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ProviderScreen'),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/provider');
                showLogoutDialog(context);
              },
              child: Container(
                height: 50,
                width: 80,
                color: Colors.blue,
                child: Center(child: Text('log out')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

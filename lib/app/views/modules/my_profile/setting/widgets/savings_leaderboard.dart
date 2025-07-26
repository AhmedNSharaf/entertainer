import 'package:enter_tainer/app/views/modules/my_profile/setting/widgets/text_button_row.dart';
import 'package:flutter/material.dart';

class SavingsLeaderBoard extends StatelessWidget {
  const SavingsLeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),

      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            TextButtonRow(
              title: 'لوحة صدارة المدخرات',
              buttonText: 'إدارة الأعضاء',
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('😊', style: TextStyle(fontSize: 35)),
                  SizedBox(width: 8),
                  Text(
                    'أنت',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    'دولار أمريكي 0',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

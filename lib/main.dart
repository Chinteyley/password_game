import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Secret Asor',
      home: LandingPage(),
    );
  }
}
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secret Asor'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'តើអ្នកចង់ដឹងពីរបៀបបង្កើតពាក្យសម្ងាត់ដែលរឹងមាំ និងមានសុវត្ថិភាពជាងមុនដែរឬទេ? \nDo you want to know how to create a stronger and secured password?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the password game or any other page you want to show next.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasswordGame()),
                );
              },
              child: Text('ចុចត្រង់នេះ \nClick Here'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              )
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Created by',
              style: TextStyle(
                fontFamily: 'Helvetica',
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 1),
            Image.asset('assets/ctey.png', height: 64, width: 64),
          ],
        ),
        ),
    );
  }
}

class PasswordGame extends StatefulWidget {
  const PasswordGame({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secret Asor'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Do you want to know how to create a stronger and secured password?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the password game or any other page you want to show next.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasswordGame()),
                );
              },
              child: Text('Click Here'),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        height: 50,
        child: const Center(
          child: Text(
            'Created by CTEY',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
  _PasswordGameState createState() => _PasswordGameState();
}

class _PasswordGameState extends State<PasswordGame> {
  final TextEditingController _passwordController = TextEditingController();
  int level = 1;
  bool isPasswordStrong = false;
  bool allLevelsCompleted = false;

  final Map<int, String> levelTexts = {
    1: 'បង្កើតពាក្យសម្ញាត់មានយ៉ាងហោចណាស់ ៨តួ។ \nCreate a Strong Password with at least 8 characters',
    2: 'បង្កើតពាក្យសម្ញាត់មានយ៉ាងហោចណាស់ ៨តួ រួមមាន អក្សរតូច ១ និងអក្សរធំ ១។ \nCreate a Strong Password with at least 8 characters, one uppercase and one lowercase letter',
    3: 'បង្កើតពាក្យសម្ញាត់មានយ៉ាងហោចណាស់ ៨តួ រួមមាន អក្សរតូច ១ និងអក្សរធំ ១ លាយជាមួយលេខ។ \nCreate a Strong Password with at least 8 characters, one uppercase, one lowercase letter, and one number',
    4: 'បង្កើតពាក្យសម្ញាត់មានយ៉ាងហោចណាស់ ១០តួ រួមមាន អក្សរតូច ១ អក្សរធំ ១ លាយជាមួយលេខ និងតួរពិសេសមួយ។ \nCreate a Strong Password with at least 10 characters, one uppercase, one lowercase letter, one number, and one special character (!@#\$%^&*(),.?":{}|<>)',
  };

  void checkPasswordStrength(String password) {
    final requiredLength = _getRequiredLengthForLevel(level);

    if (password.length >= requiredLength && _isStrongPassword(password, level)) {
      setState(() {
        isPasswordStrong = true;
      });
    } else {
      setState(() {
        isPasswordStrong = false;
      });
    }
  }

  int _getRequiredLengthForLevel(int level) {
    switch (level) {
      case 1:
        return 8;
      case 2:
      case 3:
      case 4:
        return 10;
      default:
        return 8; // Default required length.
    }
  }

  bool _isStrongPassword(String password, int level) {
    switch (level) {
      case 1:
        return password.length >= 8;
      case 2:
        return password.length >= 8 &&
            password.contains(RegExp(r'[A-Z]')) &&
            password.contains(RegExp(r'[a-z]'));
      case 3:
        return password.length >= 8 &&
            password.contains(RegExp(r'[A-Z]')) &&
            password.contains(RegExp(r'[a-z]')) &&
            password.contains(RegExp(r'[0-9]'));
      case 4:
        return password.length >= 10 &&
            password.contains(RegExp(r'[A-Z]')) &&
            password.contains(RegExp(r'[a-z]')) &&
            password.contains(RegExp(r'[0-9]')) &&
            password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      default:
        return false;
    }
  }

  void _onVerifyClicked() {
    if (isPasswordStrong) {
      if (level < 4) {
        setState(() {
          level++;
          _passwordController.clear();
          isPasswordStrong = false;
        });
      } else {
        setState(() {
          allLevelsCompleted = true;
        });

        // Navigate to the end page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => EndPage()),
        );
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secret Asor - Level $level'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500), // Animation duration
              child: Text(
                levelTexts[level] ?? 'Invalid level',
                key: ValueKey<int>(level), // Key to identify different texts
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: TextField(
                  controller: _passwordController,
                  onChanged: (value) {
                    setState(() {
                      checkPasswordStrength(value);
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 20),
            isPasswordStrong
                ? Text(
              'ពាក្យសម្ញាត់របស់អ្នកគឺខ្លាំង! \n(Password is strong!)',
              style: TextStyle(color: Colors.green),
            )
                : Text(
              'ពាក្យសម្ញាត់របស់អ្នកគឺខ្សោយ សូមព្យាយាមម្តងទៀត! \n(Password is too weak. Try again!)',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onVerifyClicked,
              child: Text('ផ្ទៀងផ្ទាត់\nVerify'),
            ),
          ],
        ),
      ),
    );
  }
}

class EndPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulations'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'សូមអបអរសាទរ ឥឡូវអ្នកបានយល់ដឹងច្បាស់អំពីការបង្កើតពាក្យសម្ងាត់ដែលរឹងមាំ និងមានសុវត្ថិភាព។ \nCongratulations, Now you know how to create a stronger and secured password.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

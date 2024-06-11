import 'package:flutter/material.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/webHomepage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key, required this.logo});
  final String logo;

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      body: Center(
        // widthFactor: 20
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(widget.logo, width: 100, height: 100),
              Title(
                  color: Colors.black,
                  child: Text(
                    'First, enter your email',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 30.0 : 40.0),
                  )),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('We suggest using the '),
                  Text(
                    'email address you use at work.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: "name@work-email.com",
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  fixedSize: Size.fromWidth(isSmallScreen ? 340 : 400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  backgroundColor: const Color.fromARGB(255, 82, 1, 102),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => isSmallScreen
                            ? const MyHomePage(title: 'MI2')
                            : const Webhomepage(title: 'MI2')),
                  );
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

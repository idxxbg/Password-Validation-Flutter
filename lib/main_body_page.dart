import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class MainBodyPage extends StatefulWidget {
  const MainBodyPage({super.key});

  @override
  State<MainBodyPage> createState() => _MainBodyPageState();
}

class _MainBodyPageState extends State<MainBodyPage> {
  bool isSuccess = false;
  bool _obscuretext1 = false;
  bool _obscuretext2 = false;
  TextEditingController passcontroller = TextEditingController();
  TextEditingController repasscontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    passcontroller.addListener(_validatepass);
    repasscontroller.addListener(_validatepass);
  }

  void obsc1() {
    setState(() {
      _obscuretext1 = !_obscuretext1;
    });
  }

  void obsc2() {
    setState(() {
      _obscuretext2 = !_obscuretext2;
    });
  }

  Future<void> _validatepass() async {
    if (passcontroller.text != "" &&
        passcontroller.text == repasscontroller.text) {
      setState(() {
        isSuccess = true;
      });
    } else {
      isSuccess = false;
    }
    await isSuccess;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: isSuccess
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DonePage()),
                );
              },
              child: const Icon(Icons.arrow_right_alt),
            )
          : null,
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.3,
                  child: isSuccess
                      ? Lottie.network(
                          "https://lottie.host/45404cae-9e90-4136-9992-d1af7f217d95/GfWBC86CL4.json",
                          animate: true,
                        )
                      : Lottie.network(
                          "https://lottie.host/45404cae-9e90-4136-9992-d1af7f217d95/GfWBC86CL4.json",
                          animate: false,
                        ),
                ),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.7 - AppBar().preferredSize.height,
                  child: Column(
                    children: [
                      myTextField('Nhap mat khau', Colors.pink, passcontroller,
                          TextInputType.text, _obscuretext2, obsc2),
                      const Divider(),
                      FlutterPwValidator(
                          uppercaseCharCount: 1,
                          lowercaseCharCount: 1,
                          numericCharCount: 1,
                          specialCharCount: 1,
                          width: 350,
                          height: screenHeight * 0.2,
                          minLength: 8,
                          onSuccess: () {
                            setState(() {
                              // isSuccess = true;/
                            });
                          },
                          onFail: () {
                            setState(() {
                              // isSuccess = false;
                            });
                          },
                          controller: passcontroller),
                      myTextField(
                        'Nhap lai mat khau',
                        Colors.pink,
                        repasscontroller,
                        TextInputType.text,
                        _obscuretext1,
                        obsc1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container myTextField(
  String hint,
  Color color,
  TextEditingController controller,
  TextInputType type,
  bool obscuretext,
  VoidCallback obsc,
) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 10,
    ),
    child: TextFormField(
      obscureText: obscuretext,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field cannot be empty';
        }
        return null;
      },
      keyboardType: type,

      // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(regexp))],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 22,
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black45,
          fontSize: 19,
        ),
        suffixIcon: IconButton(
          onPressed: obsc,
          icon: Icon(obscuretext
              ? Icons.visibility_off_outlined
              : Icons.visibility_rounded),
          color: color,
        ),
      ),
    ),
  );
}

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: Center(
        child: Lottie.network(
            width: MediaQuery.of(context).size.width * 0.5,
            'https://lottie.host/c1b5cf1e-c696-476f-bb90-94c6a8aeae49/nbPPsIFDAk.json'),
      ),
    );
  }
}

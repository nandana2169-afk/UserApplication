import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen({super.key});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  final TextEditingController otpController = TextEditingController();

  Timer? timer;
  int secondsRemaining = 52; // ✅ added

  @override
  void initState() {
    super.initState();
    startTimer(); // ✅ added
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void verifyOtp(String otp) {
    debugPrint("Verifying OTP: $otp");
  }

  @override
  void dispose() {
    otpController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
           
            children: [
              const SizedBox(height: 50),

              Image.asset('assets/otpimage.png', height: 200),

              const SizedBox(height: 30),

              Align(alignment: Alignment.centerLeft,
                child: const Text(
                  'OTP Verification',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Enter the verification code we just sent to your number +91*******21',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 30),

              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: otpController,
                keyboardType: TextInputType.number,
             
                textStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) {
                  if (value.length == 6) {
                    verifyOtp(value);
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeColor: Colors.black,
                  inactiveColor: Colors.blueGrey,
                  selectedColor: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              // 🔴 RED TIMER TEXT (added back)
              Center(
                child: Text(
                  '$secondsRemaining sec',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 30),

             
                  Align(alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\t Get OTP?  ',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        children: [
                          TextSpan(
                            text: 'Resend',
                            style: TextStyle(color: Colors.blue, fontSize: 15,decoration: TextDecoration.underline),
                          ),
                                   
                                 ] ),
                                  ),
                  ), 
                  SizedBox(height: 20,),
                  SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child:Text('Verify',style: TextStyle(color: Colors.white,fontSize: 18),)
            ))] )  ,
          ),
        
      
    ));
  }
}

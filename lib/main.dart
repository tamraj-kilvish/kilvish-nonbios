import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kilvish',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentStep = 0;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildPhoneStep();
      case 1:
        return _buildOTPStep();
      case 2:
        return _buildUsernameStep();
      default:
        return Container();
    }
  }

  Widget _buildPhoneStep() {
    return Column(
      children: [
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Enter Phone Number',
            hintText: '+91 XXXXX XXXXX',
          ),
        ),
      ],
    );
  }

  Widget _buildOTPStep() {
    return Column(
      children: [
        TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Enter OTP',
            hintText: 'Enter 6-digit OTP',
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameStep() {
    return Column(
      children: [
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(
            labelText: 'Choose Username',
            hintText: 'Enter your preferred username',
          ),
        ),
      ],
    );
  }

  void _nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kilvish'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Kilvish in 3 steps',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            LinearProgressIndicator(
              value: (currentStep + 1) / 3,
            ),
            const SizedBox(height: 16),
            _buildStepIndicator(),
            const SizedBox(height: 32),
            _buildCurrentStep(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep > 0)
                  ElevatedButton(
                    onPressed: _previousStep,
                    child: const Text('Back'),
                  )
                else
                  const SizedBox(),
                ElevatedButton(
                  onPressed: currentStep == 2 ? () {} : _nextStep,
                  child: Text(currentStep == 2 ? 'Submit' : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStepCircle(0, 'Phone'),
        _buildStepLine(0),
        _buildStepCircle(1, 'OTP'),
        _buildStepLine(1),
        _buildStepCircle(2, 'Username'),
      ],
    );
  }

  Widget _buildStepCircle(int step, String label) {
    bool isActive = currentStep >= step;
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${step + 1}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int step) {
    return Expanded(
      child: Container(
        height: 2,
        color: currentStep > step ? Colors.blue : Colors.grey,
      ),
    );
  }
}

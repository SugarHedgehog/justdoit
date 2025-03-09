import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a time-consuming task (e.g., loading data) for the splash screen.
    // Replace this with your actual data loading logic.
    Future.delayed(
      const Duration(seconds: 2),() {
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(
        "https://sun9-43.userapi.com/s/v1/ig2/VkMG5yIWsVJEjWEPBwL08c2hCu82e618st7f6vtQdO_AvsHomzRmxQ-4BXEr2JEVc5Jj6p-jKsTHCljYqcdsY7yY.jpg?quality=95&as=32x48,48x72,72x108,108x162,160x239,240x359,360x539,480x718,540x808,640x958,720x1077,1080x1616,1179x1764&from=bu&cs=539x807",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
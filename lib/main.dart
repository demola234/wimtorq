import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onARKitViewCreated(ARKitController arkitController) {
      this.arkitController = arkitController;
      final node = ARKitNode(
        geometry: ARKitSphere(radius: 0.1),
        position: Vector3(0, 0, -0.5),
      );
      this.arkitController.add(node);
    }

    return MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: const Text('ARKit in Flutter')),
            body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated)));
  }
}

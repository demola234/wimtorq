import 'dart:async';
import 'package:vector_math/vector_math_64.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import '../utils/image_assets.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({Key? key}) : super(key: key);

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  /// Initialize the ARKitController and Timer for rotation
  late ARKitController arkitController;
  late Timer timer;

  @override
  void dispose() {
    timer.cancel();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ARKitSceneView(onARKitViewCreated: onARKitViewCreated);
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

/// This creates the spheres material and raps the image on the sphere
    final materialSphere = ARKitMaterial(
      lightingModelName: ARKitLightingModel.lambert,
      diffuse: ARKitMaterialProperty.image(ImagesAsset.arImage),
    );

    /// This initializes the created spheres material and also the size of the sphere
    final sphere = ARKitSphere(
      materials: [materialSphere],
      radius: 0.2,
    );

    /// This initializes the geometry, position and angle in which the sphere is placed
    final node = ARKitNode(
      geometry: sphere,
      position: Vector3(0, 0, -0.5),
      eulerAngles: Vector3.zero(),
    );
    this.arkitController.add(node);

    /// This sets a timer and a rotation pattern of the sphere
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final rotation = node.eulerAngles;
      rotation.x += 0.01;
      node.eulerAngles = rotation;
    });
  }
}

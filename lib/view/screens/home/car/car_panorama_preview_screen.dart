import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class PanoramaPreviewScreen extends StatelessWidget {
  const PanoramaPreviewScreen({
    required this.imageUrl,
    super.key,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PanoramaViewer(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}

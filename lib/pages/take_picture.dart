import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {

  late CameraController _cameraController;
  late Future<void> _initCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.camera, 
      ResolutionPreset.medium
    );
    _initCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400, height: 400,
            child: FutureBuilder<void>(
              future: _initCameraControllerFuture, 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CameraPreview(_cameraController,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.circle_outlined,
                                size: 100,
                              ),
                              onPressed: () async {
                                try {
                                  await _initCameraControllerFuture;
                                  final image = await _cameraController.takePicture();
                                            
                                  if (!context.mounted) return;
                                            
                                  return Navigator.pop(context, image.path);
                                } catch (e) {
                                  print(e);
                                }
                              }, 
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.white));
                }
              }
            ),
          ),
        ),
      ),
    );
  }
}


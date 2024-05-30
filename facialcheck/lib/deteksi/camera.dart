import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';

import 'package:facialcheck/model/deteksi_model.dart';
import 'package:facialcheck/deteksi/preview.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  void _initCamera() async {
    _cameraController = CameraController(widget.cameras![0], ResolutionPreset.high);
    await _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _takePicture() async {
    try {
      if (!_cameraController.value.isInitialized) {
        return;
      }
      XFile picture = await _cameraController.takePicture();
      ApiResponse apiResponse = await _uploadPicture(picture);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(picture: picture, apiResponse: apiResponse),
        ),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<ApiResponse> _uploadPicture(XFile picture) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://kikischwarzer-facialparalysis.hf.space/screening'));
      request.files.add(await http.MultipartFile.fromPath('file', picture.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic>? responseData = json.decode(responseString);
        if (responseData != null) {
          return ApiResponse.fromJson(responseData);
        } else {
          print('Error: responseData is null');
          return ApiResponse(
            prediction: 'Error: responseData is null',
            percentage: '0',
            imagePath: '',
            fileName: '',
          );
        }
      } else {
        print('Failed to upload picture. Status code: ${response.statusCode}');
        return ApiResponse(
          prediction: 'Error: status code ${response.statusCode}',
          percentage: '0',
          imagePath: '',
          fileName: '',
        );
      }
    } catch (e) {
      print('Error uploading picture: $e');
      return ApiResponse(
        prediction: 'Error uploading picture',
        percentage: '0',
        imagePath: '',
        fileName: '',
      );
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Camera Page', style: TextStyle(color: Color(0xff545454)),),
        iconTheme: IconThemeData(color: Color(0xff545454)),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _cameraController.value.isInitialized
                ? CameraPreview(_cameraController)
                : Center(child: CircularProgressIndicator()),
          ),
          Center(
            child: Lottie.asset(
              "assets/animation/scan.json",
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.9,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _takePicture,
        child: Icon(Icons.camera, color: Colors.black,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

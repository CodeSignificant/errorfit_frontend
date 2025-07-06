// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../config/styles/app_colors.dart';
// import '../../config/styles/font_styles.dart';
// import '../buttons/anim_button.dart';
// import '../buttons/svg_icon_button.dart';
// import '../resources/actions.dart';
// import 'dotted_line.dart';
//
// class CameraCaptureController extends GetxController {
//   CameraController? cameraControl;
//   final isCameraInitialized = false.obs;
//   late List<CameraDescription> _cameras;
//
//   final Rx<XFile?> selectedImage = Rx<XFile?>(null);
//
//   init() {
//     _initCamera();
//   }
//
//   Future<void> _initCamera() async {
//     // Request permissions
//     await Permission.camera.request();
//
//     if (await Permission.camera.isGranted) {
//       _cameras = await availableCameras();
//       if (_cameras.isNotEmpty) {
//         cameraControl = CameraController(_cameras[0], ResolutionPreset.medium);
//         await cameraControl!.initialize();
//         isCameraInitialized.value = true;
//       }
//     } else {
//       openAppSettings();
//     }
//   }
//
//   void onCloseClick() {
//     Get.back();
//   }
//
//   Future<void> onCaptureImageClick() async {
//     if (!cameraControl!.value.isInitialized ||
//         cameraControl!.value.isTakingPicture) {
//       return;
//     }
//
//     final XFile file = await cameraControl!.takePicture();
//     selectedImage.value = file;
//     // widget.onImageCaptured(File(file.path));
//     // Get.back();
//   }
// }
//
// showCameraCapture({required Function(XFile file) onImageCaptured}) {
//   Get.bottomSheet(
//     CameraCaptureSheet(onImageCaptured: onImageCaptured),
//     isDismissible: false,
//     isScrollControlled: true,
//     enableDrag: false,
//     backgroundColor: AppColors.transparent,
//     exitBottomSheetDuration: Duration.zero,
//     enterBottomSheetDuration: Duration.zero,
//     barrierColor: AppColors.transparent,
//   );
// }
//
// class CameraCaptureSheet extends StatefulWidget {
//   final Function(XFile file) onImageCaptured;
//
//   const CameraCaptureSheet({super.key, required this.onImageCaptured});
//
//   @override
//   State<CameraCaptureSheet> createState() => _CameraCaptureSheetState();
// }
//
// class _CameraCaptureSheetState extends State<CameraCaptureSheet> {
//   final control = CameraCaptureController();
//
//   @override
//   void initState() {
//     control.init();
//     super.initState();
//   }
//   @override
//   void dispose() {
//     control.cameraControl?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(height: kStatusBarHeight + 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SvgIconButton(
//                 path: "ic_close",
//                 color: AppColors.white,
//                 onClick: control.onCloseClick,
//               ),
//               const SizedBox(width: 14),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 14.0),
//             child: Text("Add Document", style: FontStyles.s20White6),
//           ),
//           const SizedBox(height: 4),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 14.0),
//             child: Text(
//               "Capture the bill and Document",
//               style: FontStyles.s14MGrey,
//             ),
//           ),
//           const SizedBox(height: 26),
//           Expanded(
//             child: Obx(() {
//               return control.isCameraInitialized.value
//                   ? Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14.0),
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: CameraPreview(control.cameraControl!),
//                           ),
//                         ),
//
//                         Positioned.fill(
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: DottedLine(
//                               dotWidth: 26,
//                               strokeWidth: 3,
//                               color: AppColors.secondary,
//                               child: SizedBox(
//                                 height: double.infinity,
//                                 width: double.infinity,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                   : Center(
//                     child: const CircularProgressIndicator(color: Colors.white),
//                   );
//             }),
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               const SizedBox(width: 36),
//               Obx(() {
//                 if (control.selectedImage.value == null) return SizedBox();
//                 return Image.file(
//                   File(control.selectedImage.value!.path),
//                   height: 100,
//                   width: 48,
//                 );
//               }),
//               const Spacer(),
//               AnimButton(
//                 onClick: control.onCaptureImageClick,
//                 child: Container(
//                   width: 72,
//                   height: 72,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white, width: 3),
//                   ),
//                   child: Center(
//                     child: Icon(
//                       Icons.camera_alt,
//                       size: 28,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               Obx(() {
//                 if (control.selectedImage.value == null) return SizedBox();
//                 return SvgIconButton(
//                   path: "ic_tick",
//                   color: AppColors.green,
//                   size: 46,
//                   onClick: _onDoneClick,
//                 );
//               }),
//               const SizedBox(width: 36),
//             ],
//           ),
//           SizedBox(height: kBottomBarHeight + 8),
//         ],
//       ),
//     );
//   }
//
//   void _onDoneClick() {
//     if (control.selectedImage.value == null) return;
//     widget.onImageCaptured(control.selectedImage.value!);
//     Get.back();
//   }
// }

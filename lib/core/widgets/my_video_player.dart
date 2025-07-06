// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class MyVideoPlayer extends StatefulWidget {
//   final String videoUrlOrAsset;
//
//   const MyVideoPlayer({
//     super.key,
//     required this.videoUrlOrAsset
//   });
//
//   @override
//   State<MyVideoPlayer> createState() => _MyVideoPlayerState();
// }
//
// class _MyVideoPlayerState extends State<MyVideoPlayer> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = VideoPlayerController.asset(widget.videoUrlOrAsset);
//
//     _controller.initialize().then((_) {
//       setState(() {});
//       _controller.setLooping(true);
//       _controller.play();
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _controller.value.isInitialized
//           ? SizedBox.expand(
//         child: FittedBox(
//           fit: BoxFit.cover,
//           child: SizedBox(
//             width: _controller.value.size.width,
//             height: _controller.value.size.height,
//             child: VideoPlayer(_controller),
//           ),
//         ),
//       )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }

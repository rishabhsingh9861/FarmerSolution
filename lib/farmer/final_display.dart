import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_solution/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FinalDisplay extends StatefulWidget {
  const FinalDisplay(
      {super.key,
      this.email,
      this.imageUrl,
      this.videourl,
      this.writefinal,
      this.crop,
      this.state});
  final String? email;
  final String? imageUrl;
  final String? videourl;
  final String? writefinal;
  final String? crop;
  final String? state;

  @override
  State<FinalDisplay> createState() => _FinalDisplayState();
}

class _FinalDisplayState extends State<FinalDisplay> {
  String name = '';
  String district = '';
  String taluka = '';
  String village = '';
  int pincode = 0;
  String probdocumentid = '';
  Timestamp timestamp = Timestamp.now();

  Future<void> addUserDetails(
      String photourl,
      String problem,
      String videourl,
      String states,
      String crops,
      String emailid,
      String name,
      String district,
      String taluka,
      String village,
      int pincode) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.email)
        .collection('Photos')
        .doc()
        .set({
      'Photo Url': photourl,
      'Problem': problem,
      'Video Url': videourl,
      'State': states,
      'Crop': crops,
      'Email': emailid,
      'Name': name,
      'District': district,
      'Taluka': taluka,
      'Village': village,
      'Pincode': pincode,
    });
  }

  Future<void> addProblemToExpert(
      String photourl,
      String problem,
      String videourl,
      String states,
      String crops,
      String district,
      String emailid,
      String name,
      String taluka,
      String village,
      Timestamp time,
      int pincode) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection(widget.state.toString())
        .add({
      'Photo Url': photourl,
      'Problem': problem,
      'Video Url': videourl,
      'State': states,
      'Crop': crops,
      'District': district,
      'Email': emailid,
      'Name': name,
      'Taluka': taluka,
      'Village': village,
      'Time': time,
      'Pincode': pincode,
    });
    probdocumentid = documentReference.id;
  }

  Widget defaultimage(String? imgurl) {
    if (imgurl == null) {
      return Image.asset(
        'assets/icons/default-icon.png',
        color: Colors.black,
      );
    } else {
      return Image.network(
        imgurl,
      );
    }
  }

  Widget defaultvideo(String vidurl) {
    if (vidurl.isEmpty) {
      return SizedBox(
        height: 150,
        width: 150,
        child: Image.asset(
          'assets/icons/default-video.png',
          color: Colors.black,
        ),
      );
    } else {
      return Videoplayer(url: vidurl.toString());
    }
  }

  void adddata() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.email)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      name = userData['Name'];
      district = userData['District'];
      taluka = userData['Taluka'];
      village = userData['Village'];
      pincode = userData['Pincode'];
    }
  }

  @override
  void initState() {
    adddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
        centerTitle: true,
        title: const Text(
          'कृषि समाधान',
          style: textsty,
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const BackButton(
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                height: 250,
                width: 250,
                child: defaultimage(widget.imageUrl),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(child: defaultvideo(widget.videourl.toString())),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 350,
              width: 350,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(),
                      top: BorderSide(),
                      left: BorderSide(),
                      right: BorderSide())),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'State: ${widget.state}',
                        style: textst,
                      ),
                      Text(
                        'Crop: ${widget.crop}',
                        style: textst,
                      ),
                      const Text(
                        'Problem:',
                        style: textst,
                      ),
                      Text(
                        widget.writefinal.toString(),
                        style: textst,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  addUserDetails(
                      widget.imageUrl.toString(),
                      widget.writefinal.toString(),
                      widget.videourl.toString(),
                      widget.state.toString(),
                      widget.crop.toString(),
                      widget.email.toString(),
                      name.toString(),
                      district.toString(),
                      taluka.toString(),
                      village.toString(),
                      int.parse(pincode.toString()));

                  addProblemToExpert(
                          widget.imageUrl.toString(),
                          widget.writefinal.toString(),
                          widget.videourl.toString(),
                          widget.state.toString(),
                          widget.crop.toString(),
                          district.toString(),
                          widget.email.toString(),
                          name.toString(),
                          taluka.toString(),
                          village.toString(),
                          timestamp,
                          int.parse(pincode.toString()))
                      .then((value) => showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Text('Problem Sent Sucessfully'),
                                );
                              }).then((value) {
                            int count = 1;
                            Navigator.of(context).popUntil((_) => count-- < 0);
                          }));
                },
                child: Text(
                  'submit'.tr,
                  style: textsty,
                ))
          ],
        ),
      ),
    );
  }
}

class Videoplayer extends StatefulWidget {
  const Videoplayer({super.key, this.url});
  final String? url;

  @override
  State<Videoplayer> createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.url.toString()))
          ..addListener(() => setState(() {}))
          ..setLooping(false)
          ..initialize().then((value) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;

    return Column(
      children: [
        VideoplayerWidget(controller: controller),
        const SizedBox(
          height: 15,
        ),
        if (controller.value.isInitialized)
          IconButton(
              onPressed: () => controller.setVolume(isMuted ? 1 : 0),
              icon: Icon(
                isMuted ? Icons.volume_mute : Icons.volume_up,
                color: Colors.grey,
              ))
      ],
    );
  }
}

class VideoplayerWidget extends StatelessWidget {
  const VideoplayerWidget({super.key, this.controller});
  final VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) =>
      controller != null && controller!.value.isInitialized
          ? SizedBox(
              height: 350,
              child: buildvideo(),
            )
          : const SizedBox(
              height: 350,
              child: Center(
                child: CircularProgressIndicator(),
              ));

  Widget buildvideo() => Stack(
        children: <Widget>[
          builvideoPlayer(),
          Positioned.fill(child: BasicOverlay(controller: controller)),
        ],
      );

  Widget builvideoPlayer() => AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: VideoPlayer(controller!));
}

class BasicOverlay extends StatelessWidget {
  const BasicOverlay({super.key, this.controller});
  final VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller!.value.isPlaying
              ? controller!.pause()
              : controller!.play();
        },
        child: Stack(
          children: [
            buildPlay(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            )
          ],
        ),
      );

  Widget buildIndicator() =>
      VideoProgressIndicator(controller!, allowScrubbing: true);

  Widget buildPlay() => controller!.value.isPlaying
      ? Container()
      : AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: const Icon(
              Icons.play_arrow,
              color: Colors.grey,
              size: 50,
            ),
          ),
        );
}

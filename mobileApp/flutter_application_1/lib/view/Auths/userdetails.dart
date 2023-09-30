import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/components/setuptextfields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:flutter_application_1/services/firestore/userdetails.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final UserDetails _userDetails = UserDetails();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    addresscontroller.dispose();
    phonenumbercontroller.dispose();
    dobcontroller.dispose();
  }

  final picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;

  PlatformFile? _video;
  File? _videoo;
  Future selectvideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      _video = result.files.first;

      _videoo = File(_video!.path!);
      print(_video!.path);
      _videoPlayerController = VideoPlayerController.file(_videoo!)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController!.play();
        });
      setState(() {});
    } else {
      print("No Video Selected");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height * 0.35,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Container(
                  height: height * 0.3,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(225, 0, 187, 134),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(175),
                      )),
                ),
                Align(
                    heightFactor: 1.6,
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        selectvideo();
                      },
                      child: Container(
                        height: height * 0.3,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60)),
                        child: _video != null
                            ? _videoPlayerController!.value.isInitialized
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: AspectRatio(
                                            aspectRatio: _videoPlayerController!
                                                .value.aspectRatio,
                                            child: VideoPlayer(
                                                _videoPlayerController!),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                            : const Icon(
                                Icons.video_camera_front,
                                color: Color.fromARGB(225, 0, 187, 134),
                                size: 50,
                              ),
                      ),
                    )),
                Align(
                    heightFactor: 5,
                    alignment: Alignment.center,
                    child: Text(
                      "Set up your profile",
                      style: GoogleFonts.satisfy(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
            Text(
              "Upload a video of your face with every angle",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[600]),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SetupTextField(
              controller: firstnamecontroller,
              text: 'First Name',
              icon: Icons.first_page,
            ),
            SetupTextField(
              controller: lastnamecontroller,
              text: 'Last Name',
              icon: Icons.last_page,
            ),
            SetupTextField(
              controller: phonenumbercontroller,
              text: 'Phone Number',
              icon: Icons.phone,
            ),
            SetupTextField(
              controller: addresscontroller,
              text: 'Address',
              icon: Icons.location_city,
            ),
            SetupTextField(
              controller: dobcontroller,
              suffixtext: 'YYYY/MM/DD',
              text: 'DOB',
              icon: Icons.calendar_month,
            ),
            RoundBtn(
              text: "Upload  ",
              height: height * 0.07,
              width: width * 0.25,
              ontap: () {
                _userDetails.adduserdetails(
                    context,
                    firstnamecontroller.text,
                    lastnamecontroller.text,
                    addresscontroller.text,
                    phonenumbercontroller.text,
                    dobcontroller.text);

                _userDetails.uploadvideo(
                    context, _videoo, firstnamecontroller.text);
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/resources/jitsi_meet_methods.dart';
import 'package:gsms_mobileapp_swd/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Meeting'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeMeetingButton(
                  onPressed: createNewMeeting,
                  text: 'New Meeting',
                  icon: Icons.videocam,
                ),

                /*HomeMeetingButton(
                onPressed: () {},
                text: 'Schedule',
                icon: Icons.calendar_today,
              ),
              HomeMeetingButton(
                onPressed: () {},
                text: 'Share Screen',
                icon: Icons.arrow_upward_rounded,
              ),*/
              ],
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Create/Join Meetings with just a click!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

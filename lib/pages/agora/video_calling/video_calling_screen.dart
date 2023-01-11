import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swift_care/constants/colors.dart';

const appId = "4f76f2c4bed1457b893f2c0cbab3299f";
const token = "007eJxTYLBd5lm9b1mmWAlLpa2miFv78faAqiJ1j5YDoZs3iu+fE6fAYJJmbpZmlGySlJpiaGJqnmRhaQzkGiQnJSYZG1laprHt3ZbcEMjIMDUzhZmRAQJBfE6GktTiEufE4lQjBgYAP6gfUQ==";
const channel = "testCase2";

class VideoCallingScreen extends StatefulWidget {
  const VideoCallingScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallingScreen> createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  bool isVideoEnable = true;
  bool isAudioEnable = true;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onRejoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );

    print('@@@@@@@@@@ in');

  }

  @override
  Widget build(BuildContext context) {
    Size med = MediaQuery.of(context).size;
    print('_remoteUid ::: $_remoteUid');
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _remoteUid != null
              ? Center(
                  child: _remoteVideo(),
                )
              : const SizedBox(),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: _remoteUid != null && _remoteUid !=0 ? 150 : med.width,
              height: _remoteUid != null && _remoteUid !=0 ? 250 : med.height,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
      /*Stack(
        children: <Widget>[
          _localUserJoined
              ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                )
              : const CircularProgressIndicator(),
          isVideoEnable
              ? SizedBox.shrink()
              : BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    height: med.height,
                    width: med.width,
                  ),
                ),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: med.height * 0.2,
                ),
                Text(
                  'Omer Loshee',
                  style: TextStyle(
                    color: lCardColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Wait for remote user to join',
                    style: TextStyle(
                      color: lCardColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),*/
      bottomNavigationBar: Container(
        width: med.width,
        height: med.height * 0.115,
        decoration: BoxDecoration(
          color: appColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon:
                  Icon(Icons.flip_camera_ios_sharp, color: fadeBlue, size: 28),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.videocam_off,
                  color: isVideoEnable ? fadeBlue : Colors.grey.shade400,
                  size: 28),
              onPressed: () {
                if (isVideoEnable) {
                  _engine.disableVideo();
                  setState(() {
                    isVideoEnable = false;
                  });
                } else {
                  _engine.enableVideo();
                  setState(() {
                    isVideoEnable = true;
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.mic_off,
                  color: isAudioEnable ? fadeBlue : Colors.grey.shade400,
                  size: 28),
              onPressed: () {
                if (isAudioEnable) {
                  _engine.disableAudio();
                  setState(() {
                    isAudioEnable = false;
                  });
                } else {
                  _engine.enableAudio();
                  setState(() {
                    isAudioEnable = true;
                  });
                }
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.call_end, color: fadeBlue, size: 28),
                onPressed: () {
                  _engine.leaveChannel();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}

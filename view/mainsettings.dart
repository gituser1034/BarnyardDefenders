import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';

// Mohammad + omed

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _volume = 0.5;
  bool _notifications = true;
  User? _user; // Firebase user

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _initializeAudioPlayer();
    _getUser();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        // Handle notification click
      },
    );
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Change this to your channel ID
      'Your Channel Name', // Change this to your channel name
      // Change this to your channel description
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Login Successful',
      'You have successfully logged in!',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> _getUser() async {
    // Check if a user is already signed in
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  Future<void> _signIn() async {
    try {
      // Replace this with your specific authentication logic
      // For example, you can use signInWithEmailAndPassword, signInAnonymously, etc.
      UserCredential userCredential =
      await FirebaseAuth.instance.signInAnonymously();
      setState(() {
        _user = userCredential.user;
      });

      // Play background music
      _audioPlayer.play('assets/music/Powerful-Trap-(chosic.com).mp3' as Source);

      // Show notification after successful login
      await _showNotification();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _signOut() async {
    try {
      // Replace this with your specific sign-out logic
      await FirebaseAuth.instance.signOut();
      setState(() {
        _user = null;
      });

      // Stop background music on logout
      _audioPlayer.stop();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _initializeAudioPlayer() async {
    // Initialize audio player settings if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Account'),
            leading: Icon(Icons.person),
            subtitle: _user != null
                ? Text(
                'Logged in as ${_user!.isAnonymous ? 'Guest' : _user!.email}')
                : null,
            onTap: _user == null ? _signIn : null,
          ),
          if (_user != null)
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),
              onTap: _signOut,
            ),
          Divider(),          ListTile(
            title: Text('Volume'),
            subtitle: Slider(
              value: _volume,
              onChanged: (newVolume) {
                setState(() {
                  _volume = newVolume;
                });
              },
              min: 0,
              max: 1,
              divisions: 10,
              label: '${(_volume * 100).round()}',
            ),
          ),
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(
              value: _notifications,
              onChanged: (newValue) {
                setState(() {
                  _notifications = newValue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

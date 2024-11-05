import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/auth_controller.dart';
import '../../shared/theme.dart';
import '../../views/app_bar/default_app_bar.dart';
import 'chart_model.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({super.key});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {

  TextEditingController promprController = TextEditingController();

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello,", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. how r u?", messageType: "sender"),
    ChatMessage(messageContent: "eh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  late List<ChatMessageApi> messagesApi;
  String ConversationId="";
  bool chatmessageprogress=true;
  bool sendloader=false;

  @override
  void initState() {
    createConversation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Chat Screen',
        actions: [

        ],
      ),
      body: chatmessageprogress? Center(
        child: CircularProgressIndicator(
          color: appthemecolor2, // Replace with your color
        ),
      ):Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: receiverMsg,
                  ),
                  padding: const EdgeInsets.fromLTRB(20,8,20,8),
                  child: const Text("Hello! How can I help you?",
                      style: TextStyle(fontSize: 14)),
                ),
              ),
              Expanded(
                child: messagesApi.isNotEmpty
                    ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: messagesApi.length,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 4),
                      child: Align(
                        alignment: messagesApi[index].converesationId == ConversationId
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: messagesApi[index].converesationId == ConversationId
                                ? senderMsg
                                : Colors.grey.shade200,
                          ),
                          padding: const EdgeInsets.fromLTRB(20,8,20,8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(messagesApi[index].text,
                                  style: const TextStyle(fontSize: 14)),
                              Text(messagesApi[index].createdAt.substring(0,messagesApi[index].createdAt.length-8),
                                  style: const TextStyle(fontSize: 7)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
                  : Container(),
              ),
              const SizedBox(height: 40),
            ],
          ),
          Positioned(
            bottom: 1,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 5, bottom: 5, top: 10),
              height: 50,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: promprController,
                      decoration: const InputDecoration(
                        hintText: "Enter your message...",
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                  sendloader?SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: appthemecolor2, // Replace with your color
                      ),
                    ),
                  ):FloatingActionButton(
                    onPressed: () {
                      if (promprController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Message is Empty"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        setState(() {
                          sendloader = true;
                          createMessage();
                        });
                      }
                    },
                    backgroundColor: Colors.white, // Replace with your color
                    elevation: 0,
                    child:  Icon(Icons.send, color: appthemecolor2, size: 25),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> createConversation() async {
    try{
      final SharedPreferences tokenprefs = await SharedPreferences.getInstance();
      Map<String, dynamic> requestBody = {
        "userId": AuthController.to.user!.userId,
        "groupTitle": AuthController.to.user!.userId
      };
      // Convert the JSON body to a string
      String requestBodyJson = json.encode(requestBody);
      String url = "https://api.sparewares.com/conservation/create-conservation";
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${tokenprefs.getString('accessToken')}"
        },
        body: requestBodyJson,
      );
        String mlconvertdata = utf8.decode(response.bodyBytes);
        if (mlconvertdata != "") {
          if (jsonDecode(mlconvertdata) != null ) {
            var results = jsonDecode(mlconvertdata);
            var status = results['status'];
            if(status==true)
            {
              getconservationuser();
            }
            else
            {

            }
          }
        }
    }
    catch(err){
      print(err);
    }
    return "Successfully";
  }

  Future<String> getconservationuser() async {
    try{
      final SharedPreferences tokenprefs = await SharedPreferences.getInstance();
      String url = "https://api.sparewares.com/conservation/get-conservation-user";
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${tokenprefs.getString('accessToken')}"
        },
      );
      setState(() {
        String mlconvertdata = utf8.decode(response.bodyBytes);
        if (mlconvertdata != "") {
          if (jsonDecode(mlconvertdata) != null ) {
            var results = jsonDecode(mlconvertdata);
            ConversationId = results['conversation'][0]['_id'];
            getMessage();
          }
        }
      });
      //11_progressBarActive2 = false;
    }
    catch(err){
      print(err);
    }
    return "Successfully";
  }

  Future<String> createMessage() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> requestBody = {
        "sender": AuthController.to.user!.userId,
        "text": promprController.text,
        "converesationId": ConversationId
      };
      // Convert the JSON body to a string
      String requestBodyJson = json.encode(requestBody);
      String url = "https://api.sparewares.com/message/create-message";
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
         //"Authorization": "Bearer ${prefs.getString('accessToken')}"
        },
        body: requestBodyJson,
      );
      setState(() {
        promprController.clear();
        String mlconvertdata = utf8.decode(response.bodyBytes);
        if (mlconvertdata != "") {
          if (jsonDecode(mlconvertdata) != null ) {
            var results = jsonDecode(mlconvertdata);
            getMessage();
          }
        }
      });
    }
    catch(err){
      print(err);
    }
    return "Successfully";
  }

  Future<String> getMessage() async {
    try{
      String url = "https://api.sparewares.com/message/get-message/$ConversationId";
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      setState(() {
        String mlconvertdata = utf8.decode(response.bodyBytes);
        if (mlconvertdata != "") {
          if (jsonDecode(mlconvertdata) != null ) {
            var results = jsonDecode(mlconvertdata);
            var chatdat = results['message'] as List;
            messagesApi = chatdat.map((taskJson) => ChatMessageApi.fromJson(taskJson)).toList();
            chatmessageprogress=false;
            sendloader=false;
          }
          else
            {
              setState(() {
                chatmessageprogress=false;
              });
            }
        }
      });
      //11_progressBarActive2 = false;
    }
    catch(err){
      print(err);
    }
    return "Successfully";
  }
}

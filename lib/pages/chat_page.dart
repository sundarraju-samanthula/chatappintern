
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // <– You can skip pubspec by using network JSON instead
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/authentication/auth.dart';
import 'package:chatapp/chat/chat_services.dart';
import 'package:chatapp/components/char_bubble.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController _messageController = TextEditingController();
  final ChatServices _chatService = ChatServices();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      await _chatService.sendMessage(
        receiverID,
        _messageController.text.trim(),
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final myUID = _authService.getCurrentUser()!.uid;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4460F7), Color(0xFF8338EC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(theme),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: _buildMessageList(myUID),
                ),
              ),
              _buildUserInput(theme),
            ],
          ),
        ),
      ),
    );
  }

  // Top App Bar
  Widget _buildAppBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.purple, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              receiverEmail,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chat Message List with Lottie in Middle if Empty
  Widget _buildMessageList(String myUID) {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(receiverID, myUID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Lottie.network(
              "https://assets6.lottiefiles.com/packages/lf20_jcikwtux.json", // ✅ No need to add to pubspec.yaml
              width: 200,
              height: 200,
              repeat: true,
            ),
          );
        }
        return ListView.builder(
          reverse: false,
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            bool isMe = data['senderID'] == myUID;
            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: ChatBubble(message: data['message'], isCurrentUser: isMe),
            );
          },
        );
      },
    );
  }

  // Message Input Field
  Widget _buildUserInput(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                fillColor: Colors.grey.shade200,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: sendMessage,
            child: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

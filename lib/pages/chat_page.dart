// // import 'package:chatapp/authentication/auth.dart';
// // import 'package:chatapp/chat/chat_services.dart';
// // import 'package:chatapp/components/char_bubble.dart';
// // import 'package:chatapp/components/text_field.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';

// // class ChatPage extends StatelessWidget {
// //   final String receiverEmail;
// //   final String receiverID;

// //   ChatPage({super.key, required this.receiverEmail, required this.receiverID});

// //   // text controller
// //   final TextEditingController _messageController = TextEditingController();

// //   // chat & auth services
// //   final ChatServices _chatService = ChatServices();
// //   final AuthService _authService = AuthService();

// //   // send message
// //   void sendMessage() async {
// //     // if there is something inside the textfield
// //     if (_messageController.text.isNotEmpty) {
// //       // send the message
// //       await _chatService.sendMessage(receiverID, _messageController.text);
// //       _messageController.clear();
// //     }
// //     // ... missing code for clearing text field and scrolling
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(receiverEmail),
// //         backgroundColor: Colors.transparent,
// //         foregroundColor: Colors.grey,
// //         elevation: 0,
// //       ), // AppBar
// //       body: Column(
// //         children: [
// //           // display all messages
// //           Expanded(child: _buildMessageList()), // Expanded
// //           // user input
// //           _buildUserInput(),
// //         ],
// //       ), // Column
// //     ); // Scaffold
// //   }

// //   // build message item
// //   Widget _buildMessageItem(DocumentSnapshot doc) {
// //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

// //     // is current user
// //     bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

// //     // align message to the right if sender is the current user, otherwise left
// //     var alignment = isCurrentUser
// //         ? Alignment.centerRight
// //         : Alignment.centerLeft;

// //     return Container(
// //       alignment: alignment,
// //       child: Column(
// //         crossAxisAlignment: isCurrentUser
// //             ? CrossAxisAlignment.end
// //             : CrossAxisAlignment.start,
// //         children: [
// //           ChatBubble(
// //             message: data["message"],
// //             isCurrentUser: isCurrentUser,
// //           ), // ChatBubble
// //         ],
// //       ), // Column
// //     ); // Container
// //   }

// //   // build message list
// //   Widget _buildMessageList() {
// //     String senderID = _authService.getCurrentUser()!.uid;
// //     return StreamBuilder(
// //       stream: _chatService.getMessages(receiverID, senderID),
// //       builder: (context, snapshot) {
// //         // errors
// //         if (snapshot.hasError) {
// //           return const Text("Error");
// //         }

// //         // loading
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Text("Loading...");
// //         }

// //         // return list view
// //         return ListView(
// //           children: snapshot.data!.docs
// //               .map((doc) => _buildMessageItem(doc))
// //               .toList(),
// //         ); // ListView
// //       },
// //     ); // StreamBuilder
// //   }

// //   // build message input
// //   Widget _buildUserInput() {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 50.0),
// //       child: Row(
// //         children: [
// //           // textfield should take up most of the space
// //           Expanded(
// //             child: MyTextField(
// //               controller: _messageController,
// //               hintText: "Type a message",
// //               obscureText: false,
// //               prefixIcon: Icons.message,
// //             ), // MyTextField
// //           ), // Expanded
// //           // send button
// //           Container(
// //             decoration: const BoxDecoration(
// //               color: Colors.green,
// //               shape: BoxShape.circle,
// //             ), // BoxDecoration
// //             margin: const EdgeInsets.only(right: 25),
// //             child: IconButton(
// //               onPressed: sendMessage,
// //               icon: const Icon(Icons.arrow_upward, color: Colors.white), // Icon
// //             ), // IconButton
// //           ), // Container
// //         ],
// //       ), // Row
// //     ); // Padding
// //   }
// // }
// import 'package:chatapp/components/char_bubble.dart';
// import 'package:flutter/material.dart';
// import 'package:chatapp/authentication/auth.dart';
// import 'package:chatapp/chat/chat_services.dart';
// //import 'package:chatapp/components/chat_bubble.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatPage extends StatelessWidget {
//   final String receiverEmail;
//   final String receiverID;

//   ChatPage({super.key, required this.receiverEmail, required this.receiverID});

//   final TextEditingController _messageController = TextEditingController();
//   final ChatServices _chatService = ChatServices();
//   final AuthService _authService = AuthService();

//   void sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       await _chatService.sendMessage(receiverID, _messageController.text);
//       _messageController.clear();
//       // consider scrolling list to bottom
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final myUID = _authService.getCurrentUser()!.uid;

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Container(

//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF4460F7), Color(0xFF8338EC)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // AppBar section
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                   vertical: 12.0,
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 22,
//                       backgroundColor: theme.colorScheme.onPrimary.withOpacity(
//                         0.4,
//                       ),
//                       child: Icon(
//                         Icons.person,
//                         size: 26,
//                         color: theme.colorScheme.primary,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         receiverEmail,
//                         style: TextStyle(
//                           color: theme.colorScheme.onPrimary,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         Icons.logout,
//                         color: theme.colorScheme.onPrimary,
//                       ),
//                       onPressed: () {
//                         // Provide logout logic or back navigation
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 8),

//               // Message list container
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.background,
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(24),
//                       topRight: Radius.circular(24),
//                     ),
//                   ),
//                   child: _buildMessageList(myUID),
//                 ),
//               ),

//               // User input area
//               _buildUserInput(theme),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageList(String myUID) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _chatService.getMessages(receiverID, myUID),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Center(child: Text("Error loading messages"));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final docs = snapshot.data!.docs;
//         return ListView.builder(
//           reverse: true,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final doc = docs[index];
//             final data = doc.data() as Map<String, dynamic>;
//             final bool isMe = data['senderID'] == myUID;
//             return Align(
//               alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//               child: ChatBubble(message: data["message"], isCurrentUser: isMe),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildUserInput(ThemeData theme) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               style: TextStyle(color: theme.colorScheme.onSurface),
//               decoration: InputDecoration(
//                 hintText: "Type a message",
//                 hintStyle: TextStyle(
//                   color: theme.colorScheme.onSurface.withOpacity(0.6),
//                 ),
//                 prefixIcon: Icon(
//                   Icons.message,
//                   color: theme.colorScheme.primary,
//                 ),
//                 filled: true,
//                 fillColor: theme.colorScheme.background,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(24),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 0,
//                   horizontal: 16,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           InkWell(
//             onTap: sendMessage,
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.primary,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.send, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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

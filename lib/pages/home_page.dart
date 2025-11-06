import 'package:flutter/material.dart';
import 'package:chatapp/authentication/auth.dart';
import 'package:chatapp/components/user_tile.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/chat/chat_services.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService _authService = AuthService();
  final ChatServices _chatService = ChatServices();
  void logout() {
    // get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  // Future<void> _logout(BuildContext context) async {
  //   await _authService.signOut();
  //   Navigator.pushReplacementNamed(context, '/login');
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
              // Header section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chats",
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(onPressed: logout, icon: Icon(Icons.logout)),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.logout,
                    //     color: theme.colorScheme.onPrimary,
                    //   ),
                    //   onPressed: () => _logout(context),
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Sub-heading or welcome message
              Text(
                "Find your friends and start chatting",
                style: TextStyle(
                  color: theme.colorScheme.onPrimary.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 24),

              // List container styled like login page card
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: _buildUserList(context, theme),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList(BuildContext context, ThemeData theme) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(color: theme.colorScheme.error),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          );
        }

        final users = snapshot.data!;
        return ListView.separated(
          itemCount: users.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final userData = users[index];
            if (userData["email"] == _authService.getCurrentUser()!.email) {
              return const SizedBox.shrink();
            }
            return UserTile(
              text: userData["email"],
              avatarUrl: userData["avatarUrl"],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      receiverEmail: userData["email"],
                      receiverID: userData['uid'],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';               


class CustomChatBox extends StatefulWidget {
  const CustomChatBox({super.key});

  @override
  State<CustomChatBox> createState() => _CustomChatBoxState();
}

class _CustomChatBoxState extends State<CustomChatBox> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {"text": "Hello! I am your AI assistant. Do you have any questions about these jobs?", "isUser": false}
        
  ];

  bool _isTyping = false;


  void _handleSendMessage() async {
    String text = _messageController.text.trim();
    if (text.isEmpty) return;


    setState(() {
      _messages.add({"text": text, "isUser": true});
      _isTyping = true;
    });
    
    _messageController.clear();

    
    await _sendMessageTon8n(text);
  }

Future<void> _sendMessageTon8n(String text) async {
    try {

      final String n8nUrl = 'https://ismail2.app.n8n.cloud/webhook/19ddccf1-361d-4d5a-ba83-8d02595880ce';

      debugPrint("✉️ Sending message to n8n.a..");

      final response = await http.post(
        Uri.parse(n8nUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userMessage': text, 
          'userId': 'ismail_123', 
        }),
      );

      if (response.statusCode == 200) {
        // 3. Read the AI's reply from n8n
        final responseData = jsonDecode(response.body);
        final String botReply = responseData['output'] ?? "No reply received.";

        if (mounted) {
          setState(() {
            _messages.add({"text": botReply, "isUser": false});
            _isTyping = false;
          });
        }
      } else {
        throw "n8n returned error: ${response.statusCode}";
      }

    } catch (e) {
      debugPrint("❌ Chat Error: $e");
      if (mounted) {
        setState(() {
          _messages.add({"text": "Error: $e", "isUser": false});
          _isTyping = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 41, 1, 1), 
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      
      child: Column(
        children: [
     
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          
         
          const Text(
            "AI Assistant",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          
          const Divider(color: Colors.white24),

       
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg["isUser"];
                
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isUser ? const Color.fromARGB(255, 112, 50, 3) : Colors.white12,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                        bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      msg["text"],
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                );
              },
            ),
          ),
     
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("AI is typing...", style: TextStyle(color: Colors.white54, fontSize: 12)),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white10,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _handleSendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

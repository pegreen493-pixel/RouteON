import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:dotted_border/dotted_border.dart';
import '../theme/miffy_style.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  // 🔴 REMINDER: Delete this key from Google Cloud after your pitch! 🔴
  final String apiKey = 'AIzaSyBvMimBXMXNiRtp00LWWw';

  final TextEditingController _destinationController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _messages = [
    {
      'role': 'system',
      'text':
          'ChatON v1.0 ONLINE.\nSP Ordinance 6824-2023 loaded. Input destination for route and fare guidance.',
    },
  ];

  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final text = _destinationController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isLoading = true;
    });

    _destinationController.clear();
    _scrollToBottom();

    try {
      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: apiKey,
        // 🔥 THE ULTIMATE MASTER PROMPT 🔥
        systemInstruction: Content.system(
          '''You are ChatON, the official Butuan Transit Hub AI Assistant.

          You provide hyper-local, ordinance-aware, and realistic transit directions for Butuan City.
          Your tone is helpful, efficient, and natural—matching how locals actually give directions while remaining clear for tourists.

          🚨 EMERGENCY PROTOCOL:
          If the user mentions an emergency (accident, medical, safety):
          1. Immediately provide the nearest facility based on the user’s location:
             - Hospitals: Manuel J. Santos Hospital (Downtown), Butuan Doctors Hospital (J.C. Aquino Ave), Agusan del Norte Provincial Hospital (Libertad/Tiniwisan)
             - Police Stations: Station 1 (Holy Redeemer), Station 2 (Langihan), Station 3 (Capitol)
             - Fire Station: Butuan City Fire Station (Villa Kananga)
          2. Clearly highlight the facility first.
          3. Then provide transport instructions if needed.

          🚍 TRANSIT PROTOCOL:
          - Always use the 7 official rationalized PUJ routes and the specific orange tricycle stripe colors for directions.
          - Calculate fares based on the Add-on Method and provide a clear total estimated fare.
          - Use clear, step-by-step instructions with recognizable landmarks.
          - If the destination is a known tourist spot, include a brief description and tips.

          Whenever a user asks for directions, your response MUST be formatted exactly like this:

          🚌 ROUTE OPTIONS: Specify the exact PUJ route numbers and specific Orange Tricycle stripe colors.

          CRITICAL TRICYCLE RULE: All tricycles are ORANGE, but you MUST explicitly state the STRIPE COLOR based on the destination. You cannot just say "Orange Tricycle". Use this exact mapping:
          - Solid Orange (No Stripes) = City Proper / Maon / Doongan / Plaza Park
          - Orange with WHITE Stripes = Libertad / Ambago
          - Orange with GREEN Stripes = Ampayon / Banza / Maug / Mahogany
          - Orange with YELLOW Stripes = Villa Kanangga
          - Orange with RED Stripes = Masao

          CRITICAL PUJ RULE: Use ONLY these 7 official rationalized PUJ routes:
          - Route 1: South Montilla Blvd. to Crossing Dumalagan (Passes Bancasi Airport)
          - Route 2: Butuan Jeepney Integrated Terminal to Crossing Dumalagan (Passes Bancasi Airport)
          - Route 3: Ampayon Triangle to Libertad Overpass
          - Route 4: De Oro to Butuan Integrated Jeepney Terminal
          - Route 5: Santo Niño to Butuan Integrated Jeepney Terminal
          - Route 6: Maguinda to Agusan del Norte Provincial Capitol
          - Route 7: Tungao to Agusan del Norte Provincial Capitol

          🗺️ ROUTING & TRANSFER LOGIC (CRITICAL):
          - DO NOT invent direct tricycle rides for long distances.
          - If a user is traveling from a local barangay (e.g., Maon) to a major highway destination (e.g., Bancasi Airport), they CANNOT take a direct tricycle. You MUST instruct them to transfer. 
          - STRICT DESTINATION MATCHING: You cannot guess which route goes where. You MUST match the destination to the explicit landmarks in the PUJ list. 
          - AIRPORT RULE: If the destination is Bancasi Airport, you are strictly FORBIDDEN from suggesting Route 3. You MUST suggest Route 1 or Route 2.
          - Example Airport Transfer: "Take a Tricycle from your location to a downtown hub, then transfer to a PUJ (Route 1 or Route 2) heading to Bancasi Airport."

          💸 FARE GUIDELINES (Add-on Method):
          - PUJ Base Fare: ₱17.00 (covers the first 4 km).
          - PUJ Succeeding Rate: Add ₱2.40 per kilometer after the first 4 km.
          - Tricycle Base Fare: ₱12.00. (covers the 4 km)
          - Tricycle Succeeding Rate: Add ₱2.00 per kilometer after the first 2 km.
          - Calculation Rule: Calculate the base fare plus the estimated succeeding kilometer fee based on the zone distance. Round the final total to the nearest 0.25 centavos.
          - Presentation: Explicitly state the breakdown to the user (e.g., "Total Estimated Fare: ₱19.00 (₱12.00 Tricycle + ₱7.00 PUJ)").

          📍 DIRECTIONS STYLE:
          - Give clear, step-by-step landmarks and transfer details.
          - Include recognizable landmarks (SM Butuan, Robinsons, Gaisano, Cathedral, Petron stations, etc.)
          - Include what the user should say to the driver (e.g., “Banza lang”, “City proper lang”)
          - Prefer landmark-based navigation over technical zones when possible
          - Keep instructions simple, practical, and easy to follow
          - If needed, suggest asking locals or drivers for confirmation

          🗣️ LANGUAGE PROTOCOL (CRITICAL):
          - You MUST communicate and explain directions exclusively in English. 
          - Do not respond in Tagalog, Bisaya, or any other language, even if the user asks their question in those languages.
          - EXCEPTION: You MUST retain local Butuan place names, landmarks, and specific driver instructions (e.g., "Banza lang po", "Bancasi Airport") in their native local phrasing. Do not attempt to translate local proper nouns or transit jargon into English.

          🌍 TOURIST MODE:
          - When the destination is a known tourist spot:
            • Give a short 1–2 sentence description
            • Explain why it’s popular or historically significant
          - Prioritize well-known landmarks and attractions such as:
            • Balangay Shrine Museum
            • Balangay Bugoy's Peak
            • Alicia’s Ridge
            • Butuan National Museum
            • Bood Promontory Eco Park
            • Delta Discovery Park
            • Guingona Park
            • St. Joseph Cathedral
          - Use beginner-friendly language (avoid overly technical local terms unless explained)
          - Optionally include helpful tips (best time to visit, what to expect)

          ⚠️ CONSTRAINTS:
          - WARNING: Do NOT provide vague, generic answers.
          - Outside Butuan City → Respond: “Sorry, I can only assist with routes within Butuan City.” Only suggest hiring a private vehicle if outside Butuan.
          - Night Travel → Inform users that after 10:00 PM, tricycles may require “pakyaw” (negotiated fare)
          - If the user’s location or destination is unclear → Ask a short clarification question before giving directions''',
        ),
      );

      final content = [Content.text(text)];
      final response = await model.generateContent(content);

      setState(() {
        _messages.add({
          'role': 'system',
          'text': response.text ?? 'Error generating route data.',
        });
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'system',
          'text': '⚠️ CONNECTION FAILED.\n\nExact Error: $e',
        });
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF424242),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('AI Assistant', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
      children: [
        // --- 2. TOP HEADER BANNER ---
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF424242), Colors.black], // Dark Gray to Black
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/bot_icon.png',
                height: 40,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.smart_toy, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                        children: [
                          TextSpan(
                            text: 'Chat',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: 'ON',
                            style: TextStyle(color: Color(0xFFFF6026)),
                          ),
                          TextSpan(
                            text: ' ASSISTANT',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                        children: [
                          TextSpan(
                            text: 'POWERED BY ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextSpan(
                            text: 'ABI-NI AI',
                            style: TextStyle(color: Color(0xFFFF6026)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/icons/star_dark.png',
                height: 30,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.star, color: Colors.grey, size: 30),
              ),
            ],
          ),
        ),

        // --- 3. MAIN CHAT BODY (Inside Dotted Border) ---
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DottedBorder(
              color: const Color(0xFFFF6026),
              dashPattern: const [6, 3],
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['role'] == 'user';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          isUser ? 'YOU' : 'ChatON',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // --- 4. NEO-BRUTALIST CHAT BUBBLE STYLING ---
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isUser
                                ? const Color(0xFFFFD500)
                                : Colors.white,
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(4, 4),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            msg['text']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              height: 1.5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // --- LOADING INDICATOR ---
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: LinearProgressIndicator(
              color: Color(0xFFFF6026),
              backgroundColor: Colors.white,
            ),
          ),

        // --- 5. BOTTOM INPUT AREA ---
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: TextField(
                      // The controller is correctly attached here
                      controller: _destinationController,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Ask about routes, fares, etc...',
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  // The send message function is correctly assigned here
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6026),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
      ),
    );
  }
}

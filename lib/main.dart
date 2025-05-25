import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(DatingApp());
}

class DatingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dating App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Data Models
class User {
  final String id;
  String name;
  int age;
  String imageUrl;
  String bio;
  double distance;
  List<String> interests;
  String occupation;
  String education;
  List<String> photos;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.bio,
    required this.distance,
    required this.interests,
    this.occupation = '',
    this.education = '',
    List<String>? photos,
  }) : photos = photos ?? [imageUrl];
}

class Match {
  final String id;
  final User user;
  final DateTime matchedAt;
  final List<Message> messages;

  Match({
    required this.id,
    required this.user,
    required this.matchedAt,
    List<Message>? messages,
  }) : messages = messages ?? [];
}

class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.isRead = false,
  });
}

// Global Data Store (In a real app, this would be replaced with a proper state management solution)
class AppState {
  static User? currentUser;
  static List<User> allUsers = [];
  static List<Match> matches = [];
  static List<String> likedUsers = [];
  static List<String> dislikedUsers = [];

  static void initializeData() {
    // Current user
    currentUser = User(
      id: 'current_user',
      name: 'John',
      age: 27,
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      bio: 'Software Developer passionate about technology and outdoor adventures. Love trying new restaurants and traveling to new places.',
      distance: 0,
      interests: ['Technology', 'Hiking', 'Photography', 'Travel', 'Food'],
      occupation: 'Software Developer',
      education: 'Computer Science',
      photos: [
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400',
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
      ],
    );

    // Sample users
    allUsers = [
      User(
        id: '1',
        name: 'Emma',
        age: 25,
        imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b9c4c0e8?w=400',
        bio: 'Love hiking, coffee, and good conversations ☕🏔️',
        distance: 2.5,
        interests: ['Hiking', 'Coffee', 'Photography'],
        occupation: 'Photographer',
        education: 'Fine Arts',
        photos: [
          'https://images.unsplash.com/photo-1494790108755-2616b9c4c0e8?w=400',
          'https://images.unsplash.com/photo-1506863530036-1efeddceb993?w=400',
        ],
      ),
      User(
        id: '2',
        name: 'Sophia',
        age: 28,
        imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400',
        bio: 'Artist and dreamer. Looking for someone to explore the city with 🎨',
        distance: 1.8,
        interests: ['Art', 'Music', 'Travel'],
        occupation: 'Graphic Designer',
        education: 'Design School',
        photos: [
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400',
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400',
        ],
      ),
      User(
        id: '3',
        name: 'Isabella',
        age: 23,
        imageUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400',
        bio: 'Yoga instructor and foodie. Life is about balance 🧘‍♀️🍜',
        distance: 3.2,
        interests: ['Yoga', 'Cooking', 'Meditation'],
        occupation: 'Yoga Instructor',
        education: 'Health Sciences',
        photos: [
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400',
          'https://images.unsplash.com/photo-1485893086445-ed75865251e0?w=400',
        ],
      ),
      User(
        id: '4',
        name: 'Olivia',
        age: 26,
        imageUrl: 'https://images.unsplash.com/photo-1488716820095-cbe80883c496?w=400',
        bio: 'Dog lover and adventure seeker. Let\'s go on an adventure! 🐕🌟',
        distance: 4.1,
        interests: ['Dogs', 'Adventure', 'Running'],
        occupation: 'Veterinarian',
        education: 'Veterinary Medicine',
        photos: [
          'https://images.unsplash.com/photo-1488716820095-cbe80883c496?w=400',
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400',
        ],
      ),
      User(
        id: '5',
        name: 'Maya',
        age: 24,
        imageUrl: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=400',
        bio: 'Software engineer by day, salsa dancer by night 💃💻',
        distance: 1.2,
        interests: ['Dancing', 'Technology', 'Wine Tasting'],
        occupation: 'Software Engineer',
        education: 'Computer Science',
        photos: [
          'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=400',
          'https://images.unsplash.com/photo-1522512115668-c09775d6f424?w=400',
        ],
      ),
      User(
        id: '6',
        name: 'Zoe',
        age: 29,
        imageUrl: 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=400',
        bio: 'Marketing maven with a passion for sustainable living 🌱',
        distance: 5.7,
        interests: ['Sustainability', 'Marketing', 'Gardening'],
        occupation: 'Marketing Manager',
        education: 'Business Administration',
        photos: [
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=400',
          'https://images.unsplash.com/photo-1519699047748-de8e457a634e?w=400',
        ],
      ),
      User(
        id: '7',
        name: 'Aria',
        age: 27,
        imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
        bio: 'Musician and writer seeking harmony in all things 🎵📚',
        distance: 2.9,
        interests: ['Music', 'Writing', 'Literature'],
        occupation: 'Music Teacher',
        education: 'Music Composition',
        photos: [
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
        ],
      ),
      User(
        id: '8',
        name: 'Luna',
        age: 22,
        imageUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400',
        bio: 'Psychology student who loves stargazing and deep talks 🌙⭐',
        distance: 3.8,
        interests: ['Psychology', 'Astronomy', 'Philosophy'],
        occupation: 'Student',
        education: 'Psychology',
        photos: [
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400',
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        ],
      ),
      User(
        id: '9',
        name: 'Chloe',
        age: 30,
        imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
        bio: 'Chef who believes food is love. Let me cook for you! 👩‍🍳❤️',
        distance: 4.5,
        interests: ['Cooking', 'Food', 'Travel'],
        occupation: 'Chef',
        education: 'Culinary Arts',
        photos: [
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
          'https://images.unsplash.com/photo-1521146764736-56c929d59c83?w=400',
        ],
      ),
      User(
        id: '10',
        name: 'Ava',
        age: 26,
        imageUrl: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=400',
        bio: 'Nurse with a big heart. Love helping others and weekend getaways 💜✈️',
        distance: 1.6,
        interests: ['Healthcare', 'Travel', 'Volunteering'],
        occupation: 'Registered Nurse',
        education: 'Nursing',
        photos: [
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=400',
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        ],
      ),
      User(
        id: '11',
        name: 'Riley',
        age: 25,
        imageUrl: 'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=400',
        bio: 'Fitness trainer who loves beach volleyball and smoothie bowls 🏐🥙',
        distance: 6.2,
        interests: ['Fitness', 'Beach Sports', 'Nutrition'],
        occupation: 'Personal Trainer',
        education: 'Kinesiology',
        photos: [
          'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=400',
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
        ],
      ),
      User(
        id: '12',
        name: 'Mia',
        age: 24,
        imageUrl: 'https://images.unsplash.com/photo-1521146764736-56c929d59c83?w=400',
        bio: 'Environmental scientist working to save the planet 🌍🌿',
        distance: 3.4,
        interests: ['Environment', 'Science', 'Hiking'],
        occupation: 'Environmental Scientist',
        education: 'Environmental Science',
        photos: [
          'https://images.unsplash.com/photo-1521146764736-56c929d59c83?w=400',
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400',
        ],
      ),
      User(
        id: '13',
        name: 'Harper',
        age: 28,
        imageUrl: 'https://images.unsplash.com/photo-1499952127939-9bbf5af6c51c?w=400',
        bio: 'Architect designing the future. Coffee dates and city walks? ☕🏗️',
        distance: 2.1,
        interests: ['Architecture', 'Design', 'Urban Planning'],
        occupation: 'Architect',
        education: 'Architecture',
        photos: [
          'https://images.unsplash.com/photo-1499952127939-9bbf5af6c51c?w=400',
          'https://images.unsplash.com/photo-1520052205864-92d242b3a76b?w=400',
        ],
      ),
      User(
        id: '14',
        name: 'Layla',
        age: 23,
        imageUrl: 'https://images.unsplash.com/photo-1506863530036-1efeddceb993?w=400',
        bio: 'Fashion blogger with wanderlust. Always ready for the next adventure ✈️👗',
        distance: 7.8,
        interests: ['Fashion', 'Blogging', 'Travel'],
        occupation: 'Fashion Blogger',
        education: 'Fashion Design',
        photos: [
          'https://images.unsplash.com/photo-1506863530036-1efeddceb993?w=400',
          'https://images.unsplash.com/photo-1509967419530-da38b4704bc6?w=400',
        ],
      ),
      User(
        id: '15',
        name: 'Nora',
        age: 31,
        imageUrl: 'https://images.unsplash.com/photo-1520052205864-92d242b3a76b?w=400',
        bio: 'Lawyer by profession, bookworm by passion. Weekend hikes welcome 📚⚖️',
        distance: 4.9,
        interests: ['Law', 'Reading', 'Hiking'],
        occupation: 'Lawyer',
        education: 'Law School',
        photos: [
          'https://images.unsplash.com/photo-1520052205864-92d242b3a76b?w=400',
          'https://images.unsplash.com/photo-1485893086445-ed75865251e0?w=400',
        ],
      ),
      User(
        id: '16',
        name: 'Ella',
        age: 26,
        imageUrl: 'https://images.unsplash.com/photo-1509967419530-da38b4704bc6?w=400',
        bio: 'Therapist who loves art therapy and weekend farmers markets 🎨🥕',
        distance: 3.7,
        interests: ['Therapy', 'Art', 'Organic Food'],
        occupation: 'Therapist',
        education: 'Psychology',
        photos: [
          'https://images.unsplash.com/photo-1509967419530-da38b4704bc6?w=400',
          'https://images.unsplash.com/photo-1522512115668-c09775d6f424?w=400',
        ],
      ),
      User(
        id: '17',
        name: 'Grace',
        age: 27,
        imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
        bio: 'Marine biologist fascinated by ocean life. Scuba diving buddy? 🐠🤿',
        distance: 8.3,
        interests: ['Marine Biology', 'Scuba Diving', 'Conservation'],
        occupation: 'Marine Biologist',
        education: 'Marine Biology',
        photos: [
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400',
        ],
      ),
      User(
        id: '18',
        name: 'Lily',
        age: 25,
        imageUrl: 'https://images.unsplash.com/photo-1519699047748-de8e457a634e?w=400',
        bio: 'Event planner who knows how to have fun. Dance floors and good vibes 🎉💃',
        distance: 2.3,
        interests: ['Event Planning', 'Dancing', 'Networking'],
        occupation: 'Event Planner',
        education: 'Hospitality Management',
        photos: [
          'https://images.unsplash.com/photo-1519699047748-de8e457a634e?w=400',
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
        ],
      ),
      User(
        id: '19',
        name: 'Ruby',
        age: 29,
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
        bio: 'Financial advisor with a love for wine tasting and weekend getaways 🍷📊',
        distance: 5.1,
        interests: ['Finance', 'Wine', 'Travel'],
        occupation: 'Financial Advisor',
        education: 'Finance',
        photos: [
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
        ],
      ),
      User(
        id: '20',
        name: 'Violet',
        age: 24,
        imageUrl: 'https://images.unsplash.com/photo-1522512115668-c09775d6f424?w=400',
        bio: 'Journalist always chasing the next story. Coffee shop interviews? ☕📰',
        distance: 1.9,
        interests: ['Journalism', 'Writing', 'Current Events'],
        occupation: 'Journalist',
        education: 'Journalism',
        photos: [
          'https://images.unsplash.com/photo-1522512115668-c09775d6f424?w=400',
          'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=400',
        ],
      ),
      User(
        id: '21',
        name: 'Hazel',
        age: 26,
        imageUrl: 'https://images.unsplash.com/photo-1485893086445-ed75865251e0?w=400',
        bio: 'Dentist with a bright smile. Love board games and weekend brunch 😊🦷',
        distance: 4.6,
        interests: ['Healthcare', 'Board Games', 'Brunch'],
        occupation: 'Dentist',
        education: 'Dental School',
        photos: [
          'https://images.unsplash.com/photo-1485893086445-ed75865251e0?w=400',
          'https://images.unsplash.com/photo-1499952127939-9bbf5af6c51c?w=400',
        ],
      ),
      User(
        id: '22',
        name: 'Ivy',
        age: 28,
        imageUrl: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400',
        bio: 'Data scientist who loves rock climbing and craft beer 🧗‍♀️🍺',
        distance: 3.5,
        interests: ['Data Science', 'Rock Climbing', 'Craft Beer'],
        occupation: 'Data Scientist',
        education: 'Statistics',
        photos: [
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400',
          'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=400',
        ],
      ),
      User(
        id: '23',
        name: 'Stella',
        age: 32,
        imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        bio: 'Real estate agent helping people find home. Movie nights and cozy dinners 🏠🎬',
        distance: 6.7,
        interests: ['Real Estate', 'Movies', 'Home Decor'],
        occupation: 'Real Estate Agent',
        education: 'Business',
        photos: [
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=400',
        ],
      ),
      User(
        id: '24',
        name: 'Aurora',
        age: 23,
        imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
        bio: 'Art student with big dreams. Museum dates and creative conversations 🎨✨',
        distance: 2.8,
        interests: ['Art', 'Museums', 'Creativity'],
        occupation: 'Art Student',
        education: 'Fine Arts',
        photos: [
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=400',
        ],
      ),
    ];

    // Sample matches with messages
    matches = [
      Match(
        id: '1',
        user: allUsers[0], // Emma
        matchedAt: DateTime.now().subtract(Duration(days: 2)),
        messages: [
          Message(
            id: '1',
            senderId: '1',
            text: 'Hey! Thanks for the like 😊',
            timestamp: DateTime.now().subtract(Duration(days: 2)),
            isRead: true,
          ),
          Message(
            id: '2',
            senderId: 'current_user',
            text: 'Hi Emma! Love your hiking photos!',
            timestamp: DateTime.now().subtract(Duration(days: 1)),
            isRead: true,
          ),
          Message(
            id: '3',
            senderId: '1',
            text: 'Thanks! Do you hike often?',
            timestamp: DateTime.now().subtract(Duration(hours: 5)),
            isRead: false,
          ),
        ],
      ),
      Match(
        id: '2',
        user: allUsers[1], // Sophia
        matchedAt: DateTime.now().subtract(Duration(hours: 12)),
        messages: [
          Message(
            id: '4',
            senderId: '2',
            text: 'Hi there! 👋',
            timestamp: DateTime.now().subtract(Duration(hours: 12)),
            isRead: true,
          ),
        ],
      ),
    ];
  }

  static void addMatch(User user) {
    matches.add(Match(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      user: user,
      matchedAt: DateTime.now(),
    ));
  }

  static void addMessage(String matchId, String text) {
    final matchIndex = matches.indexWhere((m) => m.id == matchId);
    if (matchIndex != -1) {
      matches[matchIndex].messages.add(
        Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: currentUser!.id,
          text: text,
          timestamp: DateTime.now(),
        ),
      );
    }
  }
}

// Authentication Screen
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink[300]!, Colors.pink[600]!],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(32),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 80,
                          color: Colors.pink,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Dating App',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        SizedBox(height: 32),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _handleAuth,
                          child: Text(_isLogin ? 'Login' : 'Sign Up'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            _isLogin
                                ? 'Don\'t have an account? Sign up'
                                : 'Already have an account? Login',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleAuth() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simulate authentication
      AppState.initializeData();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }
}

// Main Screen with Navigation
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    SwipeScreen(),
    MatchesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.favorite),
                if (AppState.matches.any((m) => m.messages.any((msg) => !msg.isRead && msg.senderId != AppState.currentUser!.id)))
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                    ),
                  ),
              ],
            ),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Swipe Screen
class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> with TickerProviderStateMixin {
  List<User> availableUsers = [];
  int currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _loadAvailableUsers();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _loadAvailableUsers() {
    availableUsers = AppState.allUsers.where((user) =>
    !AppState.likedUsers.contains(user.id) &&
        !AppState.dislikedUsers.contains(user.id) &&
        !AppState.matches.any((match) => match.user.id == user.id)
    ).toList();
  }

  void _swipeCard(bool isLike) {
    if (currentIndex >= availableUsers.length) return;

    final user = availableUsers[currentIndex];

    setState(() {
      _slideAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: isLike ? Offset(2.0, 0.0) : Offset(-2.0, 0.0),
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

      _rotationAnimation = Tween<double>(
        begin: 0.0,
        end: isLike ? 0.3 : -0.3,
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    });

    _animationController.forward().then((_) {
      setState(() {
        if (isLike) {
          AppState.likedUsers.add(user.id);
          // Simulate mutual like (50% chance)
          if (math.Random().nextBool()) {
            AppState.addMatch(user);
            _showMatchDialog(user);
          }
        } else {
          AppState.dislikedUsers.add(user.id);
        }
        currentIndex++;
      });
      _animationController.reset();
    });
  }

  void _showMatchDialog(User user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.pink, Colors.purple],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'It\'s a Match!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(AppState.currentUser!.imageUrl),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.favorite, color: Colors.white, size: 30),
                    SizedBox(width: 20),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'You and ${user.name} liked each other!',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Keep Swiping'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pink,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              match: AppState.matches.firstWhere((m) => m.user.id == user.id),
                            ),
                          ),
                        );
                      },
                      child: Text('Say Hi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.tune, color: Colors.grey[600]),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: currentIndex >= availableUsers.length
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 80, color: Colors.grey[400]),
              SizedBox(height: 20),
              Text(
                'No more profiles',
                style: TextStyle(fontSize: 24, color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              Text(
                'Check back later for new people!',
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                    _loadAvailableUsers();
                  });
                },
                child: Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        )
            : Stack(
          children: [
            // Next card (background)
            if (currentIndex + 1 < availableUsers.length)
              Positioned.fill(
                child: Transform.scale(
                  scale: 0.95,
                  child: UserCard(user: availableUsers[currentIndex + 1]),
                ),
              ),
            // Current card
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: _slideAnimation.value * MediaQuery.of(context).size.width,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserDetailScreen(
                                user: availableUsers[currentIndex],
                              ),
                            ),
                          );
                        },
                        child: UserCard(user: availableUsers[currentIndex]),
                      ),
                    ),
                  ),
                );
              },
            ),
            // Action buttons
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () => _swipeCard(false),
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.red, size: 30),
                    heroTag: "dislike",
                  ),
                  SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: Icon(Icons.star, color: Colors.blue, size: 25),
                    heroTag: "super_like",
                    mini: true,
                  ),
                  SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () => _swipeCard(true),
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite, color: Colors.pink, size: 30),
                    heroTag: "like",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

// User Card Widget
class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Stack(
            children: [
              // Background image
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(user.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              // User info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${user.name}, ${user.age}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.location_on, color: Colors.white, size: 20),
                          Text(
                            '${user.distance.toStringAsFixed(1)} km',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      if (user.occupation.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            user.occupation,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      SizedBox(height: 8),
                      Text(
                        user.bio,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: user.interests.take(3)
                            .map((interest) => Chip(
                          label: Text(
                            interest,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          backgroundColor: Colors.pink.withOpacity(0.7),
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              // Info button
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.info_outline, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// User Detail Screen
class UserDetailScreen extends StatefulWidget {
  final User user;

  UserDetailScreen({required this.user});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  PageController _pageController = PageController();
  int _currentPhotoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          slivers: [
      SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.6,
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPhotoIndex = index;
                });
              },
              itemCount: widget.user.photos.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.user.photos[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            // Photo indicators
            Positioned(
              top: 50,
              left: 20,
              right: 80,
              child: Row(
                children: widget.user.photos.asMap().entries.map((entry) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: entry.key == _currentPhotoIndex
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ),
    SliverToBoxAdapter(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Basic info
    Row(
    children: [
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    '${widget.user.name}, ${widget.user.age}',
    style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 4),
    Row(
    children: [
    Icon(Icons.location_on, color: Colors.grey, size: 20),
    Text(
    '${widget.user.distance.toStringAsFixed(1)} km away',
    style: TextStyle(
    color: Colors.grey[600],
    fontSize: 16,
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ],
    ),
    SizedBox(height: 20),

    // Bio
    Text(
    'About',
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 8),
    Text(
    widget.user.bio,
    style: TextStyle(fontSize: 16, height: 1.4),
    ),
    SizedBox(height: 20),

    // Interests
    Text(
    'Interests',
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 12),
    Wrap(
    spacing: 8,
    runSpacing: 8,
    children: widget.user.interests
        .map((interest) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
    color: Colors.pink[50],
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.pink[200]!),
    ),
    child: Text(
    interest,
    style: TextStyle(
    color: Colors.pink[700],
    fontWeight: FontWeight.w500,
    ),
    ),
    ))
        .toList(),
    ),
    SizedBox(height: 20),

    // Work and Education
    if (widget.user.occupation.isNotEmpty) ...[
    Row(
    children: [
    Icon(Icons.work, color: Colors.grey[600], size: 20),
    SizedBox(width: 12),
    Expanded(
    child: Text(
    widget.user.occupation,
    style: TextStyle(fontSize: 16),
    ),
    ),
    ],
    ),
    SizedBox(height: 12),
    ],

    if (widget.user.education.isNotEmpty) ...[
    Row(
    children: [
    Icon(Icons.school, color: Colors.grey[600], size: 20),
    SizedBox(width: 12),
    Expanded(
    child: Text(
    widget.user.education,
    style: TextStyle(fontSize: 16),
    ),
    ),
    ],
    ),
    SizedBox(height: 20),
    ],
    ],
    ),
    ),
    ],
    ),
    bottomNavigationBar: Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 10,
    ),
    ],
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    FloatingActionButton(
    onPressed: () => Navigator.of(context).pop(),
    backgroundColor: Colors.white,
    child: Icon(Icons.close, color: Colors.red, size: 30),
    heroTag: "detail_dislike",
    ),
    FloatingActionButton(
    onPressed: () {},
    backgroundColor: Colors.white,
    child: Icon(Icons.star, color: Colors.blue, size: 25),
    heroTag: "detail_super_like",
    mini: true,
    ),
    FloatingActionButton(
    onPressed: () {
    // Handle like action
    Navigator.of(context).pop();
    },
    backgroundColor: Colors.white,
    child: Icon(Icons.favorite, color: Colors.pink, size: 30),
    heroTag: "detail_like",
    ),
    ],
    ),
    ),
    );
  }
}

// Matches Screen
class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matches', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.pink,
          labelColor: Colors.pink,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Matches'),
            Tab(text: 'Messages'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMatchesTab(),
          _buildMessagesTab(),
        ],
      ),
    );
  }

  Widget _buildMatchesTab() {
    if (AppState.matches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
            SizedBox(height: 20),
            Text(
              'No matches yet',
              style: TextStyle(fontSize: 24, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            Text(
              'Keep swiping to find your perfect match!',
              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: AppState.matches.length,
      itemBuilder: (context, index) {
        final match = AppState.matches[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen(match: match),
              ),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(match.user.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          match.user.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _getTimeAgo(match.matchedAt),
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (match.messages.any((m) => !m.isRead && m.senderId != AppState.currentUser!.id))
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessagesTab() {
    final matchesWithMessages = AppState.matches.where((m) => m.messages.isNotEmpty).toList();

    if (matchesWithMessages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey[400]),
            SizedBox(height: 20),
            Text(
              'No messages yet',
              style: TextStyle(fontSize: 24, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            Text(
              'Start a conversation with your matches!',
              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: matchesWithMessages.length,
      itemBuilder: (context, index) {
        final match = matchesWithMessages[index];
        final lastMessage = match.messages.last;
        final unreadCount = match.messages.where((m) => !m.isRead && m.senderId != AppState.currentUser!.id).length;

        return ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(match.user.imageUrl),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            match.user.name,
            style: TextStyle(
              fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          subtitle: Text(
            lastMessage.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: unreadCount > 0 ? Colors.black87 : Colors.grey[600],
              fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
          trailing: Text(
            _getTimeAgo(lastMessage.timestamp),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen(match: match),
              ),
            );
          },
        );
      },
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

// Chat Screen
class ChatScreen extends StatefulWidget {
  final Match match;

  ChatScreen({required this.match});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Mark messages as read
    setState(() {
      for (var message in widget.match.messages) {
        if (message.senderId != AppState.currentUser!.id) {
          message.isRead = true;
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      AppState.addMessage(widget.match.id, _messageController.text.trim());
    });

    _messageController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.match.user.imageUrl),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.match.user.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Active now',
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: widget.match.messages.length,
              itemBuilder: (context, index) {
                final message = widget.match.messages[index];
                final isMe = message.senderId == AppState.currentUser!.id;

                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isMe) ...[
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(widget.match.user.imageUrl),
                        ),
                        SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.pink : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      if (isMe) ...[
                        SizedBox(width: 8),
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(AppState.currentUser!.imageUrl),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  backgroundColor: Colors.pink,
                  mini: true,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}

// Settings Screen
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _showMeOnTinder = true;
  bool _showRecentlyActive = true;
  double _ageRangeMin = 18;
  double _ageRangeMax = 35;
  double _maxDistance = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Discovery Settings
            Text(
              'Discovery Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Maximum Distance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Maximum Distance',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${_maxDistance.round()} km',
                          style: TextStyle(fontSize: 16, color: Colors.pink),
                        ),
                      ],
                    ),
                    Slider(
                      value: _maxDistance,
                      min: 1,
                      max: 100,
                      divisions: 99,
                      activeColor: Colors.pink,
                      onChanged: (value) {
                        setState(() {
                          _maxDistance = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),

                    // Age Range
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Age Range',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${_ageRangeMin.round()}-${_ageRangeMax.round()}',
                          style: TextStyle(fontSize: 16, color: Colors.pink),
                        ),
                      ],
                    ),
                    RangeSlider(
                      values: RangeValues(_ageRangeMin, _ageRangeMax),
                      min: 18,
                      max: 80,
                      divisions: 62,
                      activeColor: Colors.pink,
                      labels: RangeLabels(
                        _ageRangeMin.round().toString(),
                        _ageRangeMax.round().toString(),
                      ),
                      onChanged: (values) {
                        setState(() {
                          _ageRangeMin = values.start;
                          _ageRangeMax = values.end;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Notification Settings
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text('Push Notifications'),
                    subtitle: Text('Get notified about new matches and messages'),
                    value: _notificationsEnabled,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  Divider(height: 1),
                  SwitchListTile(
                    title: Text('Show Me on Dating App'),
                    subtitle: Text('Control your profile visibility'),
                    value: _showMeOnTinder,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() {
                        _showMeOnTinder = value;
                      });
                    },
                  ),
                  Divider(height: 1),
                  SwitchListTile(
                    title: Text('Show Recently Active'),
                    subtitle: Text('Show your activity status to others'),
                    value: _showRecentlyActive,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() {
                        _showRecentlyActive = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Account Settings
            Text(
              'Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.privacy_tip, color: Colors.pink),
                    title: Text('Privacy Policy'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Handle privacy policy tap
                    },
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.help, color: Colors.pink),
                    title: Text('Help & Support'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Handle help tap
                    },
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.pink),
                    title: Text('About'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Handle about tap
                    },
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text('Logout', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      _showLogoutDialog();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                      (route) => false,
                );
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

// Profile Screen
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (AppState.currentUser != null) {
      _bioController.text = AppState.currentUser!.bio;
      _occupationController.text = AppState.currentUser!.occupation;
      _educationController.text = AppState.currentUser!.education;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AppState.currentUser;
    if (user == null) {
      return Scaffold(
        body: Center(child: Text('No user data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user.imageUrl),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${user.name}, ${user.age}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.pink[200]!),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.pink[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Profile Photos
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Photos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: user.photos.length + 1,
                      itemBuilder: (context, index) {
                        if (index == user.photos.length) {
                          return Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.grey[600],
                              size: 40,
                            ),
                          );
                        }

                        return Container(
                          width: 100,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(user.photos[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Profile Information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _bioController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Tell people about yourself...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.pink),
                      ),
                    ),
                    onChanged: (value) {
                      user.bio = value;
                    },
                  ),

                  SizedBox(height: 20),

                  Text(
                    'Job Title',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _occupationController,
                    decoration: InputDecoration(
                      hintText: 'Add your job title',
                      prefixIcon: Icon(Icons.work, color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.pink),
                      ),
                    ),
                    onChanged: (value) {
                      user.occupation = value;
                    },
                  ),

                  SizedBox(height: 20),

                  Text(
                    'Education',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _educationController,
                    decoration: InputDecoration(
                      hintText: 'Add your education',
                      prefixIcon: Icon(Icons.school, color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.pink),
                      ),
                    ),
                    onChanged: (value) {
                      user.education = value;
                    },
                  ),

                  SizedBox(height: 20),

                  Text(
                    'Interests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...user.interests.map((interest) =>
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.pink[50],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.pink[200]!),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  interest,
                                  style: TextStyle(
                                    color: Colors.pink[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      user.interests.remove(interest);
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.pink[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      GestureDetector(
                        onTap: _showAddInterestDialog,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, size: 16, color: Colors.grey[600]),
                              SizedBox(width: 4),
                              Text(
                                'Add Interest',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Save Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showAddInterestDialog() {
    final TextEditingController interestController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Interest'),
          content: TextField(
            controller: interestController,
            decoration: InputDecoration(
              hintText: 'Enter your interest',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (interestController.text.trim().isNotEmpty) {
                  setState(() {
                    AppState.currentUser!.interests.add(interestController.text.trim());
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.pink,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _bioController.dispose();
    _occupationController.dispose();
    _educationController.dispose();
    super.dispose();
  }
}
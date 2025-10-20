import 'package:flutter/material.dart';

void main() {
  // This is the entry point for a Flutter application.
  runApp(const WebApp());
}

// --- Main Application Widget ---
class WebApp extends StatelessWidget {
  const WebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programming Languages',
      theme: ThemeData(
        // Using a color similar to the W3Schools signature color
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // W3Schools Green
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// --- Data Model for Languages ---
class Language {
  final String title;
  final String description;
  final IconData icon;

  const Language({required this.title, required this.description, required this.icon});
}

// List of available programming languages
const List<Language> languages = [
  Language(
    title: 'HTML Tutorial',
    description: 'HTML is the standard markup language for creating Web pages. '
        'HTML (HyperText Markup Language) is the cornerstone of all web development, serving as the language used to structure the content you see on the internet.'
        'Its not a programming language—it doesnt perform calculations or logic—but rather a markup language that uses a system of tags to define the elements of a document, such as headings, paragraphs, images, and links',
    icon: Icons.html,

  ),
  Language(
    title: 'CSS Tutorial',
    description: 'CSS is the language we use to style an HTML document. It describes how HTML elements should be displayed. '
    'CSS stands for Cascading Style Sheets and is the language used to describe the presentation and styling of a document written in a markup language, most commonly HTML. '
    'While HTML provides the structure (the "bones" of a website), CSS provides the aesthetics (the "skin"), governing everything from the colors and fonts to the complex layouts and animations.',
    icon: Icons.css,
  ),
  Language(
    title: 'JavaScript Tutorial',
    description: 'JavaScript is the programming language of the Web. It can update and change both HTML and CSS. '
    'JavaScript (JS) is a dynamic, high-level programming language that forms the third essential layer of the modern web, alongside HTML (structure) and CSS (style). '
    'Its primary role is to add interactivity and dynamic behavior to websites, allowing developers to create engaging user experiences that respond to user actions and system events in real time.',
    icon: Icons.javascript,
  ),
  Language(
    title: 'Python Tutorial',
    description: 'Python is a widely used general-purpose high-level programming language. '
    'Python is one of the most popular and versatile programming languages in the world. It is a high-level, interpreted, general-purpose language with a design philosophy that emphasizes code readability and an elegant, English-like syntax. '
        'It is often the first language taught to beginners, but its capabilities make it a powerhouse for professional developers across many industries',
    icon: Icons.settings_applications,
  ),
  Language(
    title: 'SQL Tutorial',
    description: 'SQL is a standard language for storing, manipulating and retrieving data in databases. '
    'SQL (pronounced "sequel" or S-Q-L), which stands for Structured Query Language, is a domain-specific, standardized programming language used to manage and manipulate relational databases. '
    'Its the essential language for interacting with relational database management systems (RDBMS) like MySQL, PostgreSQL, Oracle, and Microsoft SQL Server.'
    'Unlike general-purpose languages like Python or Java, SQL is declarative, meaning you tell the database what data you want, not how to find it.',
    icon: Icons.storage,
  ),
  Language(
    title: 'Java Tutorial',
    description: 'Java is a high-level, class-based, object-oriented programming language. '
    'Java is a high-level, class-based, object-oriented programming (OOP) language thats designed to have as few implementation dependencies as possible. '
      'Its core philosophy is "Write Once, Run Anywhere" (WORA), meaning compiled Java code can run on any platform that supports Java without the need for recompilation.',
    icon: Icons.code,
  ),
];

// --- Main Page Widget (Handles State for Selected Content) ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initial selected language is HTML
  Language _selectedLanguage = languages.first;

  // Function to change the selected language and close the drawer
  void _selectLanguage(Language language) {
    setState(() {
      _selectedLanguage = language;
    });
    // Close the drawer on mobile view
    if (MediaQuery.of(context).size.width < 1000) {
      Navigator.of(context).pop();
    }
  }

  // --- DRAWER (Sidebar) Implementation ---
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header - mimicking a logo/title area
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Languages Tutorial',
              style: TextStyle(
                color: Colors.yellowAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // List of Languages
          ...languages.map((language) {
            final isSelected = language.title == _selectedLanguage.title;
            return ListTile(
              // Use rich, informative icons
              leading: Icon(language.icon, color: isSelected ? Colors.yellow : Colors.grey[700]),
              title: Text(
                language.title,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.yellow : Colors.deepPurple,
                ),
              ),
              selected: isSelected,
              onTap: () => _selectLanguage(language),
            );
          }).toList(),
          const Divider(),
          // Placeholder for "References" or other sections
          ListTile(
            leading: const Icon(Icons.menu_book, color: Colors.grey),
            title: const Text('References', style: TextStyle(color: Colors.black54)),
            onTap: () {
              // Placeholder action
            },
          ),
        ],
      ),
    );
  }

  // --- MAIN CONTENT Implementation ---
  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Title
          Text(
            _selectedLanguage.title,
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 16),
          // Short Description
          Text(
            _selectedLanguage.description,
            style: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 40),

          // Code Example Card
          _buildExampleCard(
            title: 'Example: Hello World',
            code: _getExampleCode(_selectedLanguage.title),
          ),
          const SizedBox(height: 30),

          // Further Reading Section
          Text(
            'What you should already know:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 10),
          _buildBulletPoint('Basic understanding of web technologies.'),
          _buildBulletPoint('How to use a text editor.'),
          _buildBulletPoint('A basic knowledge of English.'),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18, color: Color(0xFF04AA6D))),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard({required String title, required String code}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0B3), // Light yellow background
        border: Border.all(color: const Color(0xFFFFCC66)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE7E9EB), // Code block color
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Try It Yourself Button (W3Schools style)
          ElevatedButton(
            onPressed: () {
              // Simulate navigation/action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Starting the ${_selectedLanguage.title} editor... (Simulated)'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple, // Green button
              foregroundColor: Colors.yellow,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Try it Yourself',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  String _getExampleCode(String languageTitle) {
    switch (languageTitle) {
      case 'HTML Tutorial':
        return '''
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>

<h1>My First Heading</h1>
<p>My first paragraph.</p>

</body>
</html>
''';
      case 'CSS Tutorial':
        return '''
body {
  background-color: lightblue;
}

h1 {
  color: white;
  text-align: center;
}
''';
      case 'JavaScript Tutorial':
        return '''
<script>
function myFunction() {
  document.getElementById("demo").innerHTML = "Hello World!";
}
</script>
''';
      case 'Python Tutorial':
        return '''
print("Hello, W3School User!")
def greet(name):
    return f"Hello, {name}"
''';
      case 'SQL Tutorial':
        return '''
SELECT CustomerName, City
FROM Customers
WHERE Country='Mexico';
''';
      case 'Java Tutorial':
        return '''
class Main {
  public static void main(String[] args) {
    System.out.println("Hello, Java!");
  }
}
''';
      default:
        return 'No specific example code available.';
    }
  }

  // --- WIDGET BUILDER ---
  @override
  Widget build(BuildContext context) {
    // Determine if the screen is wide (like a web/desktop view)
    // We make the sidebar always visible if the screen is 1000 pixels or wider.
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Programming Book', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 4,
        // Only show the hamburger icon if we are in mobile/tablet mode
        automaticallyImplyLeading: !isDesktop,
      ),
      // Use the Drawer widget only for mobile/tablet behavior
      drawer: isDesktop ? null : _buildDrawer(),

      body: Row(
        children: <Widget>[
          // Sidebar is permanently displayed on wide screens
          if (isDesktop)
            SizedBox(
              width: 250, // Standard sidebar width for the web view
              child: _buildDrawer(),
            ),

          // Main content takes the remaining space
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }
}

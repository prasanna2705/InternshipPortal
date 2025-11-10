import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PMInternshipApp());
}

class PMInternshipApp extends StatelessWidget {
  const PMInternshipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PM Internship Scheme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Segoe UI',
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        useMaterial3: true,
      ),
      home: const StartScreen(),
    );
  }
}

// Data model for a candidate
class Candidate {
  final String name;
  final String email;
  final String? phone;
  final String? profileImageUrl;
  final List<String> skills;
  final String? experience;
  final String? education;
  final String? linkedinUrl;
  final String? githubUrl;

  Candidate({
    required this.name,
    required this.email,
    this.phone,
    this.profileImageUrl,
    this.skills = const [],
    this.experience,
    this.education,
    this.linkedinUrl,
    this.githubUrl,
  });

  // Override hashCode and operator == for Set operations
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Candidate && runtimeType == other.runtimeType && email == other.email;

  @override
  int get hashCode => email.hashCode;
}

// StartScreen with intro, info icon, and contact info
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  final List<String> steps = const [
    "Select your domain/sectors to manage.",
    "Login with your HR email (format: hr@domain.com).",
    "Browse real-time active internships in your domain.",
    "Manage internships & view candidate applications.",
    "Use AI Match to shortlist best candidates.",
    "Send notifications & schedule interviews smoothly.",
  ];

  void _showFeatureInfo(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('How to Use This App'),
        content: SingleChildScrollView(
            child: ListBody(
                children: steps
                    .map<Widget>((String step) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Icon(Icons.check_circle,
                                  color: Colors.teal),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  step,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList())),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it!'))
        ],
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PM INTERNSHIP SCHEME'),
          centerTitle: true,
          backgroundColor: Colors.indigo.shade700,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'How to Use',
              onPressed: () => _showFeatureInfo(context),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade50, Colors.indigo.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ListView(
            children: [
              Icon(Icons.school, size: 80, color: Colors.indigo.shade600),
              const SizedBox(height: 12),
              Text(
                'Empowering Youth with Internships from Reputed Organizations.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.indigo.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Facilitating skill development, real-world experience,\n'
                'and pathways to employment across sectors.\n'
                'Smart AI-powered matching for optimal placements.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.indigo.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.indigo.shade300, thickness: 1),
              const SizedBox(height: 12),
              Card(
                color: Colors.indigo.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contact & Website',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.indigo.shade900)),
                      const SizedBox(height: 8),
                      Text('Email: support@pminternship.org',
                          style: TextStyle(
                              fontSize: 16, color: Colors.indigo.shade700)),
                      const SizedBox(height: 4),
                      Text('Phone: +91-9876543210',
                          style: TextStyle(
                              fontSize: 16, color: Colors.indigo.shade700)),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => _launchUrl(
                            'https://legendary-praline-782176.netlify.app/'),
                        child: Text('Website:https://legendary-praline-782176.netlify.app/',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue.shade700,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const DomainSelectionScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Agree & Continue',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ));
  }
}

// Data model for a candidate
// DomainSelectionScreen with back arrow to StartScreen (home)
class DomainSelectionScreen extends StatelessWidget {
  const DomainSelectionScreen({super.key});
  final List<Map<String, dynamic>> domains = const [
    {'name': 'IT & Software', 'active': 156},
    {'name': 'Banking & Finance', 'active': 89},
    {'name': 'FMCG', 'active': 67},
    {'name': 'Oil and Gas', 'active': 34},
    {'name': 'Manufacturing', 'active': 78},
    {'name': 'Healthcare', 'active': 45},
    {'name': 'Retail', 'active': 92},
    {'name': 'Hospitality', 'active': 56},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Domain'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Home',
          onPressed: () {
            Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(builder: (_) => const StartScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: domains.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 12),
        itemBuilder: (BuildContext context, int index) {
          var domain = domains[index];
          return Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              title: Text(domain['name'] as String,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              subtitle: Text('${domain['active'] as int} Active Internships'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade700,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (_) => LoginPage(
                              selectedDomain: domain['name'] as String)));
                },
                child: const Text('Access Portal',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
      ),
    );
  }
}

// LoginPage with validation and back arrow to domain selection
class LoginPage extends StatefulWidget {
  final String selectedDomain;
  const LoginPage({super.key, required this.selectedDomain});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String hrEmailFormat(String domain) =>
      'hr@${domain.toLowerCase().replaceAll(RegExp(r'[\s&]'), '')}.com';

  void _login() {
    if (_formKey.currentState!.validate()) {
      final String expectedEmail = hrEmailFormat(widget.selectedDomain);
      if (_emailController.text.trim() != expectedEmail) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email must be $expectedEmail')));
        return;
      }
      Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
              builder: (_) => DashboardScreen(domain: widget.selectedDomain)));
    }
  }

  @override
  Widget build(BuildContext context) {
    String expectedEmail = hrEmailFormat(widget.selectedDomain);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login - ${widget.selectedDomain}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const DomainSelectionScreen(),
              ),
            );
          },
        ),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 5,
        actions: const <Widget>[
          LogoutButton(), // Added logout button here
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigo.shade50, Colors.indigo.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Login with Email:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 6),
              Text(expectedEmail,
                  style:
                      TextStyle(fontSize: 16, color: Colors.indigo.shade700)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? val) {
                  if (val == null || val.isEmpty) return 'Enter your email';
                  if (!val.contains('@')) return 'Enter valid email';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (String? val) {
                  if (val == null || val.isEmpty) return 'Enter password';
                  return null;
                },
              ),
              const SizedBox(height: 36),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const StadiumBorder(),
                    elevation: 5,
                    backgroundColor: Colors.indigo.shade700,
                    foregroundColor: Colors.white),
                onPressed: _login,
                child: const Text('Login', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Logout',
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil<void>(
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const StartScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// DashboardScreen showing internships with Manage
class DashboardScreen extends StatefulWidget {
  final String domain;
  const DashboardScreen({super.key, required this.domain});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> activeInternships = [];
  List<Candidate> selectedCandidates = []; // Changed to Candidate

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadInternships();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadInternships() {
    final List<Map<String, dynamic>> jobs = <Map<String, dynamic>>[
      {
        'title': 'Software Developer Intern',
        'stipend': '30,000/month',
        'positions': 5,
        'applicants': 42,
        'deadline': '2025-10-01',
        'description':
            'Develop and maintain software applications in a collaborative team environment. '
            'Participate in code reviews and testing to ensure high-quality software delivery. '
            'Work with cross-functional teams to define and achieve product goals. '
            'Improve skills with ongoing mentorship and training opportunities.'
      },
      {
        'title': 'Marketing Strategy Intern',
        'stipend': '20,000/month',
        'positions': 3,
        'applicants': 30,
        'deadline': '2025-09-28',
        'description':
            'Assist in developing marketing plans including social media campaigns and market research. '
            'Support event planning and client outreach efforts. '
            'Collaborate with sales and creative teams to optimize marketing output.'
      },
    ];
    activeInternships = List<Map<String, dynamic>>.generate(10, (int index) {
      return jobs[index % jobs.length];
    });
    selectedCandidates = [];
  }

  void _addCandidate(Candidate candidate) {
    if (!selectedCandidates.contains(candidate)) {
      setState(() {
        selectedCandidates.add(candidate);
      });
    }
  }

  void _removeCandidate(Candidate candidate) {
    setState(() {
      selectedCandidates.remove(candidate);
    });
  }

  void _sendEmails() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text('Emails sent to ${selectedCandidates.length} candidate(s).'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.domain} HR Portal'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 5,
        leading: BackButton(onPressed: () {
          Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                  builder: (_) => LoginPage(selectedDomain: widget.domain)));
        }),
        actions: const <Widget>[
          LogoutButton(), // Added logout button
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.indigo.shade800,
            labelColor: Colors.indigo.shade900,
            unselectedLabelColor: Colors.indigo.shade400,
            tabs: <Widget>[
              const Tab(text: 'Active Internships'),
              Tab(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Selected Candidates'),
                  const SizedBox(width: 6),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.indigo.shade700,
                    child: Text(
                      '${selectedCandidates.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              )),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: activeInternships.length,
                  itemBuilder: (BuildContext context, int index) {
                    var internship = activeInternships[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      elevation: 5,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 16),
                        title: Text(internship['title'] as String,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18)),
                        subtitle: Text(
                            '₹${internship['stipend'] as String} · Positions: ${internship['positions'] as int} · Applicants: ${internship['applicants'] as int}\nDeadline: ${internship['deadline'] as String}'),
                        isThreeLine: true,
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade600,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Manage'),
                          onPressed: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (_) => ManageInternshipPage(
                                  internship: internship,
                                  onCandidateSelected: _addCandidate,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                selectedCandidates.isEmpty
                    ? Center(
                        child: Text('No candidates selected.',
                            style: TextStyle(
                                fontSize: 18, color: Colors.indigo.shade400)))
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: selectedCandidates.length,
                        itemBuilder: (BuildContext context, int i) {
                          Candidate candidate = selectedCandidates[i];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            color: Colors.indigo.shade50,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              title: Text(candidate.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              subtitle: Text(candidate.email),
                              trailing: IconButton(
                                icon: const Icon(Icons.close),
                                tooltip: 'Deselect Candidate',
                                onPressed: () => _removeCandidate(candidate),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
          if (selectedCandidates.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, -1))
                ],
              ),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.email),
                label: Text(
                    'Send Email to Selected (${selectedCandidates.length})'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.indigo.shade700,
                  foregroundColor: Colors.white,
                ),
                onPressed: _sendEmails,
              ),
            )
        ],
      ),
    );
  }
}

// ManageInternshipPage shows job description and RUN AI MATCHING button with icon description

class ManageInternshipPage extends StatefulWidget {
  final Map<String, dynamic> internship;
  final Function(Candidate) onCandidateSelected; // Changed to Candidate

  const ManageInternshipPage(
      {super.key, required this.internship, required this.onCandidateSelected});

  @override
  State<ManageInternshipPage> createState() => _ManageInternshipPageState();
}

class _ManageInternshipPageState extends State<ManageInternshipPage> {
  void _showAIMatching() {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
          builder: (_) => AIMatchingScreen(
                onCandidateSelected: widget.onCandidateSelected,
              )),
    );
  }

  void _showAIInfo(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('About AI Matching'),
              content: const Text(
                  'AI Matching uses advanced algorithms analyzing resumes, skills, experience, and other factors to shortlist top candidates. '
                  'This process de-biases the initial screening and saves time by focusing HR attention on the best fits.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    var job = widget.internship;
    return Scaffold(
      appBar: AppBar(
        title: Text(job['title'] as String),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 5,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About AI Matching',
            onPressed: () => _showAIInfo(context),
          ),
          Tooltip(
            message: 'Shows top 5 candidates among applicants',
            child: ElevatedButton.icon(
              icon: const Icon(Icons.flash_on),
              label: const Text('RUN AI MATCHING'),
              style: ElevatedButton.styleFrom(
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                backgroundColor: Colors.indigo.shade900,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                foregroundColor: Colors.white,
              ),
              onPressed: _showAIMatching,
            ),
          ),
          const SizedBox(width: 12),
          const LogoutButton(), // Added logout button
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text('Job Description:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              '${job['description']}\n\nThis internship offers a comprehensive learning experience, providing exposure to industry best practices, mentorship, and growth opportunities. Participants will be involved in practical projects, collaborating with cross-functional teams and benefiting from continuous feedback.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// AIMatchingScreen with selection, scheduling, and highlighting

class AIMatchingScreen extends StatefulWidget {
  final Function(Candidate) onCandidateSelected;

  const AIMatchingScreen({super.key, required this.onCandidateSelected});

  @override
  State<AIMatchingScreen> createState() => _AIMatchingScreenState();
}

class _AIMatchingScreenState extends State<AIMatchingScreen> {
  final List<Candidate> _aiCandidates = [
    Candidate(
      name: 'Alice Smith',
      email: 'alice.smith@example.com',
      phone: '+1-555-123-4567',
      profileImageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
      skills: ['Flutter', 'Dart', 'Firebase', 'UI/UX', 'Agile'],
      experience: '2 years as Flutter Developer at Tech Solutions Inc.',
      education: 'B.E. Computer Science, University of XYZ, 2022',
      linkedinUrl: 'https://linkedin.com/in/alicesmith',
      githubUrl: 'https://github.com/alicesmithdev',
    ),
    Candidate(
      name: 'Bob Johnson',
      email: 'bob.johnson@example.com',
      phone: '+1-555-987-6543',
      profileImageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
      skills: ['Java', 'Spring Boot', 'SQL', 'REST APIs', 'Microservices'],
      experience: '3 years as Backend Developer at Global Apps.',
      education: 'M.Tech. Software Engineering, ABC University, 2021',
      linkedinUrl: 'https://linkedin.com/in/bobjohnson',
      githubUrl: 'https://github.com/bobjdev',
    ),
    Candidate(
      name: 'Carol White',
      email: 'carol.white@example.com',
      phone: '+1-555-234-5678',
      profileImageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
      skills: [
        'Python',
        'Machine Learning',
        'Data Science',
        'TensorFlow',
        'NLP'
      ],
      experience: '1.5 years as Data Scientist at AI Innovations.',
      education: 'M.S. Artificial Intelligence, XYZ Institute, 2023',
      linkedinUrl: 'https://linkedin.com/in/carolwhite',
      githubUrl: 'https://github.com/carolwml',
    ),
    Candidate(
      name: 'David Brown',
      email: 'david.brown@example.com',
      phone: '+1-555-876-5432',
      profileImageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
      skills: ['React', 'JavaScript', 'HTML', 'CSS', 'Node.js', 'TypeScript'],
      experience: '2.5 years as Frontend Developer at WebCrafters.',
      education: 'B.Sc. Web Development, Online University, 2022',
      linkedinUrl: 'https://linkedin.com/in/davidbrown',
      githubUrl: 'https://github.com/davidbrowndev',
    ),
    Candidate(
      name: 'Eve Martin',
      email: 'eve.martin@example.com',
      phone: '+1-555-345-6789',
      profileImageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
      skills: ['AWS', 'DevOps', 'Docker', 'Kubernetes', 'Linux', 'CI/CD'],
      experience: '4 years as Cloud Engineer at CloudServe.',
      education: 'B.Tech. Information Technology, GHI College, 2020',
      linkedinUrl: 'https://linkedin.com/in/evemartin',
      githubUrl: 'https://github.com/evemartinops',
    ),
  ];

  final Set<Candidate> selected = {};
  final Set<Candidate> scheduled = {};

  void _sendEmail(Candidate candidate, String type) {
    String message = '';
    switch (type) {
      case 'shortlist':
        message =
            'Email sent to ${candidate.name}: You are shortlisted for the internship!';
        break;
      case 'interview':
        message =
            'Email sent to ${candidate.name}: Interview slot has been scheduled.';
        break;
      case 'reject':
        message = 'Email sent to ${candidate.name}: You have been deselected.';
        break;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleSelection(Candidate candidate) {
    bool isSelected = selected.contains(candidate);
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
            '${isSelected ? 'Deselect' : 'Select'} candidate ${candidate.name}?'),
        content: Text(
            'This will send a ${isSelected ? 'deselection' : 'shortlisting'} email to the candidate. Confirm?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                if (isSelected) {
                  selected.remove(candidate);
                  scheduled.remove(candidate);
                  _sendEmail(candidate, 'reject');
                } else {
                  selected.add(candidate);
                  _sendEmail(candidate, 'shortlist');
                }
                widget.onCandidateSelected(candidate);
              });
            },
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }

  void _scheduleInterview(Candidate candidate) {
    TextEditingController slotController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Schedule Interview for ${candidate.name}'),
        content: TextField(
          controller: slotController,
          decoration: const InputDecoration(
            labelText: 'Enter date & time',
            hintText: 'e.g. 2025/10/01 14:00 (YYYY/MM/DD HH:mm)',
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                if (slotController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid date & time')),
                  );
                  return;
                }
                Navigator.pop(context);
                setState(() {
                  scheduled.add(candidate);
                });
                _sendEmail(candidate, 'interview');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Email sent: Interview scheduled for ${candidate.name} at ${slotController.text}')));
              },
              child: const Text('Schedule')),
        ],
      ),
    );
  }

  void _viewProfile(Candidate candidate) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              CandidateProfileScreen(candidate: candidate)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Matching - Top 5 Candidates'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _aiCandidates.length,
        itemBuilder: (BuildContext context, int index) {
          Candidate candidate = _aiCandidates[index];
          bool isSelected = selected.contains(candidate);
          bool isScheduled = scheduled.contains(candidate);

          Color? tileColor;
          if (isScheduled) {
            tileColor = Colors.blue.shade50;
          } else if (isSelected) {
            tileColor = Colors.green.shade50;
          } else {
            tileColor = null;
          }

          return Card(
            color: tileColor,
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isScheduled
                    ? Colors.blue
                    : isSelected
                        ? Colors.green
                        : Colors.indigo.shade300,
                child: Text(candidate.name[0],
                    style: const TextStyle(color: Colors.white)),
              ),
              title: Text(candidate.name,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(candidate.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  OutlinedButton.icon(
                    icon: const Icon(Icons.person),
                    label: const Text('Profile'),
                    onPressed: () => _viewProfile(candidate),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.indigo.shade700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.red : Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _toggleSelection(candidate),
                    child: Text(isSelected ? 'Deselect' : 'Select'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                      onPressed:
                          isSelected ? () => _scheduleInterview(candidate) : null,
                      child: const Text('Schedule')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// New screen to display candidate profile details
class CandidateProfileScreen extends StatelessWidget {
  final Candidate candidate;
  const CandidateProfileScreen({super.key, required this.candidate});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(candidate.name),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: candidate.profileImageUrl != null
                    ? Image.network(candidate.profileImageUrl!).image
                    : null,
                child: candidate.profileImageUrl == null
                    ? Text(
                        candidate.name[0],
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                      )
                    : null,
                backgroundColor: Colors.indigo.shade300,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              icon: Icons.email,
              title: 'Email',
              subtitle: candidate.email,
            ),
            if (candidate.phone != null)
              _buildInfoCard(
                icon: Icons.phone,
                title: 'Phone',
                subtitle: candidate.phone!,
              ),
            if (candidate.skills.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text('Skills:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: candidate.skills
                    .map<Widget>((String skill) => Chip(
                          label: Text(skill),
                          backgroundColor: Colors.indigo.shade100,
                          labelStyle: TextStyle(color: Colors.indigo.shade800),
                        ))
                    .toList(),
              ),
            ],
            if (candidate.experience != null) ...[
              const SizedBox(height: 20),
              const Text('Experience:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(candidate.experience!, style: const TextStyle(fontSize: 16)),
            ],
            if (candidate.education != null) ...[
              const SizedBox(height: 20),
              const Text('Education:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(candidate.education!, style: const TextStyle(fontSize: 16)),
            ],
            if (candidate.linkedinUrl != null) ...[
              const SizedBox(height: 20),
              _buildLinkInfo(
                icon: Icons.link,
                title: 'LinkedIn',
                url: candidate.linkedinUrl!,
                onTap: () => _launchUrl(candidate.linkedinUrl!),
              ),
            ],
            if (candidate.githubUrl != null) ...[
              const SizedBox(height: 10),
              _buildLinkInfo(
                icon: Icons.code,
                title: 'GitHub',
                url: candidate.githubUrl!,
                onTap: () => _launchUrl(candidate.githubUrl!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Icon(icon, color: Colors.indigo.shade700, size: 28),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkInfo({
    required IconData icon,
    required String title,
    required String url,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Icon(icon, color: Colors.indigo.shade700, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      url,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue.shade700,
                        decoration: TextDecoration.underline,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

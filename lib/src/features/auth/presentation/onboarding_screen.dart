import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/neo_brutalist_theme.dart';
import 'auth_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();

  int _currentIndex = 0;

  // Pre-configured university list for selection
  final List<String> _suggestedUniversities = [
    'Delhi University (DU)',
    'Visvesvaraya Technological University (VTU)',
    'University of Mumbai',
    'Anna University',
    'Jawaharlal Nehru University (JNU)',
    'Savitribai Phule Pune University',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _universityController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex == 0 && _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: NeoBrutalism.accentOrange,
              border: Border.all(color: NeoBrutalism.darkBlack, width: 2),
            ),
            child: const Text(
              'Please enter your name to proceed!',
              style: TextStyle(color: NeoBrutalism.darkBlack, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      return;
    }

    if (_currentIndex == 1 && _universityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: NeoBrutalism.accentOrange,
              border: Border.all(color: NeoBrutalism.darkBlack, width: 2),
            ),
            child: const Text(
              'Please select or enter your university!',
              style: TextStyle(color: NeoBrutalism.darkBlack, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      return;
    }

    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Save data and route to login
      Provider.of<AuthState>(context, listen: false).setOnboarding(
        name: _nameController.text.trim(),
        university: _universityController.text.trim(),
      );
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoBrutalism.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header Progress Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'STUDYBRO',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: NeoBrutalism.darkBlack,
                      letterSpacing: -1,
                    ),
                  ),
                  Row(
                    children: List.generate(3, (index) {
                      return Container(
                        width: 24.0,
                        height: 24.0,
                        margin: const EdgeInsets.only(left: 8.0),
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? NeoBrutalism.primaryPurple
                              : NeoBrutalism.pureWhite,
                          border: NeoBrutalism.border(),
                          borderRadius: BorderRadius.circular(4.0),
                          boxShadow: _currentIndex == index
                              ? NeoBrutalism.shadows(offset: 2.0)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w900,
                              color: _currentIndex == index
                                  ? NeoBrutalism.pureWhite
                                  : NeoBrutalism.darkBlack,
                            ),
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
              const SizedBox(height: 40.0),
              
              // Onboarding Slides
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    _buildNameScreen(),
                    _buildUniversityScreen(),
                    _buildCompletedScreen(),
                  ],
                ),
              ),
              
              // Bottom Action Button
              BrutalButton(
                backgroundColor: NeoBrutalism.accentYellow,
                onPressed: _nextPage,
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      _currentIndex == 2 ? 'LET\'S GO!' : 'CONTINUE →',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                        color: NeoBrutalism.darkBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'WHO ARE\nYOU?',
          style: TextStyle(
            fontSize: 42.0,
            fontWeight: FontWeight.w900,
            height: 1.0,
            color: NeoBrutalism.darkBlack,
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Enter your name to customize your digital student hub.',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 32.0),
        BrutalTextField(
          controller: _nameController,
          labelText: 'STUDENT NAME',
          hintText: 'e.g. Rahul Sharma',
          prefixIcon: Icons.person_outline,
        ),
      ],
    );
  }

  Widget _buildUniversityScreen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          const Text(
            'SELECT YOUR\nUNIVERSITY',
            style: TextStyle(
              fontSize: 42.0,
              fontWeight: FontWeight.w900,
              height: 1.0,
              color: NeoBrutalism.darkBlack,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'We will use this to filter relevant notes for your courses.',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24.0),
          BrutalTextField(
            controller: _universityController,
            labelText: 'UNIVERSITY NAME',
            hintText: 'Select below or type yours',
            prefixIcon: Icons.school_outlined,
          ),
          const SizedBox(height: 20.0),
          const Text(
            'POPULAR UNIVERSITIES:',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w900,
              color: NeoBrutalism.darkBlack,
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _suggestedUniversities.map((uni) {
              final isSelected = _universityController.text == uni;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _universityController.text = uni;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: isSelected ? NeoBrutalism.lightPurple : NeoBrutalism.pureWhite,
                    border: NeoBrutalism.border(),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    uni,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: NeoBrutalism.darkBlack,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget _buildCompletedScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            '🎉',
            style: TextStyle(fontSize: 80.0),
          ),
        ),
        const SizedBox(height: 16.0),
        const Center(
          child: Text(
            'ONBOARDING\nCOMPLETED!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.w900,
              height: 1.1,
              color: NeoBrutalism.darkBlack,
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        BrutalContainer(
          backgroundColor: NeoBrutalism.primaryPurple,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CONFIRM DETAILS:',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w900,
                    color: NeoBrutalism.pureWhite,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'NAME: ${_nameController.text}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    color: NeoBrutalism.pureWhite,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'UNIVERSITY: ${_universityController.text}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: NeoBrutalism.lightPurple,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40.0),
      ],
    );
  }
}

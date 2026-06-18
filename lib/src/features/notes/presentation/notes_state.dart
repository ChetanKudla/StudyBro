import 'package:flutter/material.dart';
import '../domain/note.dart';

class NotesState extends ChangeNotifier {
  // List of all Study Notes in the app
  final List<StudyNote> _notes = [];

  // Getters
  List<StudyNote> get notes => _notes;

  NotesState() {
    _loadInitialMockNotes();
  }

  // Add a new note to the list
  void addNote(StudyNote note) {
    _notes.insert(0, note); // Show newer uploads first
    notifyListeners();
  }

  // Reset/Clear uploaded notes (when user logs out)
  void clearNotes() {
    _notes.clear();
    _loadInitialMockNotes();
    notifyListeners();
  }

  // Helper method to get notes by section
  List<StudyNote> getNotesBySection(String section) {
    return _notes.where((note) => note.courseSection == section).toList();
  }

  // Pre-load default mock notes for students to view immediately
  void _loadInitialMockNotes() {
    final list = [
      // BCA
      StudyNote(
        id: 'bca-1',
        subjectName: 'Data Structures and Algorithms',
        collegeName: 'National College of IT',
        universityName: 'Delhi University',
        semester: 3,
        courseSection: 'BCA',
        uploadedBy: 'Prof. Rahul',
        pageCount: 3,
        pageContents: [
          'CHAPTER 1: Introduction to Trees and Graphs\n\nTrees and Graphs are non-linear data structures highly used in programming.\n\nKey Concepts:\n1. Root Node - The top node of a tree hierarchy.\n2. Edges - Connections between nodes.\n3. Binary Tree - A tree where each node has at most two children.',
          'CHAPTER 2: Graph Traversals\n\nThere are two main traversal algorithms:\n- Breadth-First Search (BFS): Uses a Queue (FIFO).\n- Depth-First Search (DFS): Uses a Stack (LIFO).\n\nBFS is optimal for finding the shortest path on unweighted graphs.',
          'CHAPTER 3: Self-Balancing Trees\n\nAVL Trees and Red-Black Trees prevent the worst-case O(N) lookup time of standard BSTs by rotating elements upon insertion or deletion to keep tree depth balanced.'
        ],
      ),
      StudyNote(
        id: 'bca-2',
        subjectName: 'Object-Oriented Programming in Java',
        collegeName: 'State Institute of Science',
        universityName: 'VTU',
        semester: 2,
        courseSection: 'BCA',
        uploadedBy: 'Neha Sharma',
        pageCount: 2,
        pageContents: [
          'CHAPTER 1: The Four Pillars of OOP\n\n1. Encapsulation: Binding data and methods together.\n2. Inheritance: Code reusability via super/sub classes.\n3. Polymorphism: Method overloading and overriding.\n4. Abstraction: Hiding implementation details using interfaces.',
          'CHAPTER 2: Memory Management & Garbage Collection\n\nJava handles memory automatically via Heap and Stack space. Unreferenced heap objects are swept away by the Garbage Collector, keeping the runtime footprint efficient.'
        ],
      ),

      // BA
      StudyNote(
        id: 'ba-1',
        subjectName: 'Introduction to Modern History',
        collegeName: 'St. Xavier Arts College',
        universityName: 'Mumbai University',
        semester: 1,
        courseSection: 'BA',
        uploadedBy: 'Dr. Amit Patel',
        pageCount: 2,
        pageContents: [
          'CHAPTER 1: Industrial Revolution and its Impact\n\nThe shift from agrarian economies to industrial manufacturing in Europe led to massive urbanization, class struggles, and global trade shifts in the 18th and 19th centuries.',
          'CHAPTER 2: Major World Conflicts (1914-1945)\n\nA deep study of World War I and World War II, examining the socio-economic triggers, treaty failures, ideological battles, and subsequent formation of the United Nations.'
        ],
      ),

      // BCom
      StudyNote(
        id: 'bcom-1',
        subjectName: 'Financial Accounting & Auditing',
        collegeName: 'LSR College of Commerce',
        universityName: 'Delhi University',
        semester: 2,
        courseSection: 'BCom',
        uploadedBy: 'CA Rajesh Gupta',
        pageCount: 2,
        pageContents: [
          'CHAPTER 1: Double-Entry Bookkeeping Principles\n\nFor every debit, there must be a matching credit. The fundamental equation is:\nAssets = Liabilities + Equity.\n\nTransactions must be recorded in chronological journal entries first.',
          'CHAPTER 2: Ledger Posting and Trial Balance\n\nSummarizing journal entries into individual accounts (T-accounts). The Trial Balance acts as a verification sheet to ensure debits and credits sum up to equal values.'
        ],
      ),

      // BSc
      StudyNote(
        id: 'bsc-1',
        subjectName: 'Organic Chemistry: Carbon Structures',
        collegeName: 'Presidency Science College',
        universityName: 'Calcutta University',
        semester: 4,
        courseSection: 'BSc',
        uploadedBy: 'Dr. Sunita Sen',
        pageCount: 2,
        pageContents: [
          'CHAPTER 1: Hydrocarbons and Hybridization\n\nStudy of alkanes, alkenes, and alkynes. Carbon exhibits sp3, sp2, and sp hybridization which defines its molecular geometry (tetrahedral, planar, linear respectively).',
          'CHAPTER 2: Aromatic Compounds & Benzene Resonance\n\nBenzene exhibits resonance stability due to its delocalized pi-electrons. This cyclic stability makes it undergo electrophilic substitution reactions instead of addition.'
        ],
      ),

      // BE
      StudyNote(
        id: 'be-1',
        subjectName: 'Engineering Mechanics & Dynamics',
        collegeName: 'RV College of Engineering',
        universityName: 'VTU',
        semester: 1,
        courseSection: 'BE',
        uploadedBy: 'Prof. S. R. Murthy',
        pageCount: 2,
        pageContents: [
          'CHAPTER 1: Force Systems and Equilibrium\n\nAnalysis of coplanar and concurrent forces acting on rigid bodies. Resolution of forces into horizontal and vertical vectors. Summation of forces and moments must equal zero for static equilibrium.',
          'CHAPTER 2: Kinematics of Particles\n\nEquations of linear and curvilinear motion. Examining displacement, velocity, and acceleration vectors. Newton\'s second law (F=ma) under varying constraints.'
        ],
      ),

      // EEE
      StudyNote(
        id: 'eee-1',
        subjectName: 'Network Analysis & Circuit Theory',
        collegeName: 'BMS College of Engineering',
        universityName: 'VTU',
        semester: 3,
        courseSection: 'EEE',
        uploadedBy: 'Dr. Vikram Reddy',
        pageCount: 2,
        pageContents: [
          'CHAPTER 1: Kirchoff\'s Laws & Nodal Analysis\n\nKirchoff\'s Current Law (KCL): Sum of currents entering a node is zero.\nKirchoff\'s Voltage Law (KVL): Sum of voltages in a loop is zero.\nNodal analysis simplifies network loops into node voltage equations.',
          'CHAPTER 2: AC Circuits & RLC Resonance\n\nAnalyzing resistance, inductance, and capacitance in sinusoidal steady-state. Resonance occurs when inductive reactance equals capacitive reactance (X_L = X_C).'
        ],
      ),
    ];
    _notes.addAll(list);
  }
}

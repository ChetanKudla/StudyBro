import 'package:flutter/material.dart';
import '../../../core/theme/neo_brutalist_theme.dart';
import '../domain/note.dart';

class NoteViewScreen extends StatefulWidget {
  final StudyNote note;

  const NoteViewScreen({super.key, required this.note});

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  int _currentPage = 0;
  bool _isBookmarked = false;

  void _nextPage() {
    if (_currentPage < widget.note.pageCount - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoBrutalism.lightPurple,
      appBar: AppBar(
        backgroundColor: NeoBrutalism.pureWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: NeoBrutalism.darkBlack),
        shape: const Border(
          bottom: BorderSide(
            color: NeoBrutalism.darkBlack,
            width: NeoBrutalism.borderWidth,
          ),
        ),
        title: Text(
          widget.note.subjectName.toUpperCase(),
          style: const TextStyle(
            color: NeoBrutalism.darkBlack,
            fontWeight: FontWeight.w900,
            fontSize: 16.0,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? NeoBrutalism.accentOrange : NeoBrutalism.darkBlack,
            ),
            onPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: NeoBrutalism.accentMint,
                      border: Border.all(color: NeoBrutalism.darkBlack, width: 2),
                    ),
                    child: Text(
                      _isBookmarked ? 'Added to Saved Notes!' : 'Removed from Saved Notes!',
                      style: const TextStyle(color: NeoBrutalism.darkBlack, fontWeight: FontWeight.bold),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // PDF Document Info Box
              BrutalContainer(
                backgroundColor: NeoBrutalism.pureWhite,
                padding: 12.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FILE: ${widget.note.subjectName.replaceAll(' ', '_').toLowerCase()}.pdf',
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontWeight: FontWeight.w900,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Uploaded by: ${widget.note.uploadedBy}',
                          style: const TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: NeoBrutalism.accentYellow,
                        border: Border.all(color: NeoBrutalism.darkBlack, width: 1.5),
                      ),
                      child: const Text(
                        'PDF MODE',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Page Simulator Container (Thick Borders, Drop Shadow)
              Expanded(
                child: BrutalContainer(
                  backgroundColor: NeoBrutalism.pureWhite,
                  padding: 20.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Page Contents
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.note.pageContents[_currentPage],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: NeoBrutalism.darkBlack,
                              height: 1.6,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                      
                      const Divider(color: NeoBrutalism.darkBlack, thickness: 2.0),
                      const SizedBox(height: 8.0),
                      
                      // Page Info Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'STUDYBRO READER v1.0',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'PAGE ${_currentPage + 1} OF ${widget.note.pageCount}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w900,
                              color: NeoBrutalism.darkBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Page Navigation Controls (Brutal Buttons)
              Row(
                children: [
                  Expanded(
                    child: BrutalButton(
                      backgroundColor: _currentPage == 0 
                          ? Colors.grey[300]! 
                          : NeoBrutalism.accentOrange,
                      onPressed: _currentPage == 0 ? () {} : _previousPage,
                      child: Center(
                        child: Text(
                          '← PREVIOUS',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: _currentPage == 0 ? Colors.grey[600] : NeoBrutalism.darkBlack,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: BrutalButton(
                      backgroundColor: _currentPage == widget.note.pageCount - 1 
                          ? Colors.grey[300]! 
                          : NeoBrutalism.accentMint,
                      onPressed: _currentPage == widget.note.pageCount - 1 ? () {} : _nextPage,
                      child: Center(
                        child: Text(
                          'NEXT →',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: _currentPage == widget.note.pageCount - 1 ? Colors.grey[600] : NeoBrutalism.darkBlack,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

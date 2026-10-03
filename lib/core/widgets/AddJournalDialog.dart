import 'package:flutter/material.dart';
import 'dart:ui';

class AddJournalDialog extends StatefulWidget {
  const AddJournalDialog({Key? key}) : super(key: key);

  @override
  State<AddJournalDialog> createState() => _AddJournalDialogState();
}

class _AddJournalDialogState extends State<AddJournalDialog> {
  // Step 0: Intention Tab, Step 1: Reflection Landing, Step 2: Reflection Form
  int _currentTab = 0; // 0 = An intention, 1 = A reflection
  bool _isReflectionForm = false; // true jika sedang di "My daily reflection"

  // Form State
  int _selectedMoodIndex = 3; // Default selection: 'Good'
  final TextEditingController _thoughtController = TextEditingController();

  final List<Map<String, String>> _moods = [
    {'emoji': '😔', 'label': 'Low'},
    {'emoji': '😟', 'label': 'Off'},
    {'emoji': '😐', 'label': 'Okay'},
    {'emoji': '😊', 'label': 'Good'},
    {'emoji': '😁', 'label': 'Wonderful'},
  ];

  @override
  void dispose() {
    _thoughtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F6),
            borderRadius: BorderRadius.circular(28),
          ),
          child: SingleChildScrollView(
            child: _isReflectionForm ? _buildReflectionForm() : _buildTabbedDialog(),
          ),
        ),
      ),
    );
  }

  // --- TAMPILAN 1 & 2: TABBED DIALOG (INTENTION / REFLECTION LANDING) ---
  Widget _buildTabbedDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Make a little space',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            _buildCloseButton(),
          ],
        ),
        const SizedBox(height: 16),

        // Custom Tab Switcher
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEDD),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentTab = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _currentTab == 0 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: _currentTab == 0
                          ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'An intention',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _currentTab == 0 ? Colors.black : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentTab = 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _currentTab == 1 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: _currentTab == 1
                          ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'A reflection',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _currentTab == 1 ? Colors.black : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Konten Berdasarkan Tab Aktiv
        if (_currentTab == 0) _buildIntentionContent() else _buildReflectionLandingContent(),
      ],
    );
  }

  // Content Tab: An Intention
  Widget _buildIntentionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('What would you like to do?', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Something small, something meaningful',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Time', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('09:00', style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.access_time_rounded, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Category', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Personal', style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.keyboard_arrow_down, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
                SizedBox(width: 6),
                Text('October 3', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.bolt, size: 16, color: Colors.orange),
                SizedBox(width: 2),
                Text('50 XP on completion', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC107),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text('Add intention', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ],
    );
  }

  // Content Tab: A Reflection (Landing)
  Widget _buildReflectionLandingContent() {
    return Column(
      children: [
        const SizedBox(height: 12),
        const Text(
          'A quiet moment to check in with yourself. What felt meaningful today?',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC107),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
            onPressed: () {
              setState(() {
                _isReflectionForm = true;
              });
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Begin a reflection',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.black, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- TAMPILAN 3: FORM MY DAILY REFLECTION ---
  Widget _buildReflectionForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My daily reflection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            _buildCloseButton(),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "What's on your mind? This is your space — no right words needed.",
          style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.3),
        ),
        const SizedBox(height: 16),
        const Text('Your thoughts', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 8),
        TextField(
          controller: _thoughtController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Today, I'm making space for...",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF81C784), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF81C784), width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('And how are you feeling?', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 12),

        // Mood Selector List
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_moods.length, (index) {
            final isSelected = _selectedMoodIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedMoodIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 58,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFDCEDC8) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: isSelected ? Border.all(color: const Color(0xFFAED581)) : null,
                ),
                child: Column(
                  children: [
                    Text(_moods[index]['emoji']!, style: const TextStyle(fontSize: 28)),
                    const SizedBox(height: 4),
                    Text(
                      _moods[index]['label']!,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? Colors.black : Colors.grey[600],
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),

        // Save Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC107),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            ),
            onPressed: () {
              // Logika Simpan Reflection
              Navigator.pop(context);
            },
            icon: const Icon(Icons.bolt, color: Colors.black),
            label: const Text(
              'Save my reflection   +40 XP',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton() {
    return IconButton(
      icon: const Icon(Icons.close, size: 20),
      style: IconButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.05),
        minimumSize: const Size(36, 36),
        padding: EdgeInsets.zero,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}
import 'package:flutter/material.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _nameController = TextEditingController();
  final _goalController = TextEditingController();

  static const _green = Color(0xFF1D9E75);
  static const _greenDark = Color(0xFF085041);
  static const _greenLight = Color(0xFFE1F5EE);
  static const _greenMid = Color(0xFF5DCAA5);

  int _selectedIconIndex = 0;
  int _selectedColorIndex = 0;
  String _selectedUnit = 'min';

  final List<Map<String, dynamic>> _iconOptions = [
    {'icon': Icons.water_drop_outlined, 'label': 'Water'},
    {'icon': Icons.directions_run_rounded, 'label': 'Exercise'},
    {'icon': Icons.menu_book_outlined, 'label': 'Reading'},
    {'icon': Icons.self_improvement_outlined, 'label': 'Meditation'},
    {'icon': Icons.bedtime_outlined, 'label': 'Sleep'},
    {'icon': Icons.restaurant_outlined, 'label': 'Nutrition'},
    {'icon': Icons.favorite_outline_rounded, 'label': 'Health'},
    {'icon': Icons.emoji_nature_outlined, 'label': 'Nature'},
  ];

  final List<Map<String, dynamic>> _colorOptions = [
    {'color': const Color(0xFF1D9E75), 'bg': const Color(0xFFE1F5EE)},
    {'color': const Color(0xFF378ADD), 'bg': const Color(0xFFE6F1FB)},
    {'color': const Color(0xFF7F77DD), 'bg': const Color(0xFFEEEDFE)},
    {'color': const Color(0xFFD85A30), 'bg': const Color(0xFFFAECE7)},
    {'color': const Color(0xFFBA7517), 'bg': const Color(0xFFFAEEDA)},
    {'color': const Color(0xFF639922), 'bg': const Color(0xFFEAF3DE)},
    {'color': const Color(0xFFD4537E), 'bg': const Color(0xFFFBEAF0)},
    {'color': const Color(0xFF888780), 'bg': const Color(0xFFF1EFE8)},
  ];

  final List<String> _units = ['min', 'hours', 'glasses', 'pages', 'times', 'km'];

  @override
  void dispose() {
    _nameController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _greenLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: _greenDark,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New habit',
          style: TextStyle(
            color: Color(0xFF085041),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPreviewCard(),
            const SizedBox(height: 24),
            _buildLabel('Habit name'),
            const SizedBox(height: 8),
            _buildNameField(),
            const SizedBox(height: 20),
            _buildLabel('Icon'),
            const SizedBox(height: 10),
            _buildIconPicker(),
            const SizedBox(height: 20),
            _buildLabel('Color'),
            const SizedBox(height: 10),
            _buildColorPicker(),
            const SizedBox(height: 20),
            _buildLabel('Daily goal'),
            const SizedBox(height: 10),
            _buildGoalRow(),
            const SizedBox(height: 36),
            _buildSaveButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewCard() {
    final selectedColor = _colorOptions[_selectedColorIndex]['color'] as Color;
    final selectedBg = _colorOptions[_selectedColorIndex]['bg'] as Color;
    final selectedIcon = _iconOptions[_selectedIconIndex]['icon'] as IconData;
    final name = _nameController.text.isEmpty ? 'Habit name' : _nameController.text;
    final goal = _goalController.text.isEmpty ? '0' : _goalController.text;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _greenMid, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: selectedBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(selectedIcon, color: selectedColor, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF085041),
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: 0,
                    minHeight: 5,
                    backgroundColor: _greenLight,
                    valueColor: AlwaysStoppedAnimation<Color>(selectedColor),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '0/$goal $_selectedUnit',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF888780)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      onChanged: (_) => setState(() {}),
      decoration: _inputDecoration(hint: 'e.g. Morning walk'),
    );
  }

  Widget _buildIconPicker() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: _iconOptions.length,
      itemBuilder: (_, i) {
        final selected = i == _selectedIconIndex;
        final color = _colorOptions[_selectedColorIndex]['color'] as Color;
        final bg = _colorOptions[_selectedColorIndex]['bg'] as Color;
        return GestureDetector(
          onTap: () => setState(() => _selectedIconIndex = i),
          child: Container(
            decoration: BoxDecoration(
              color: selected ? bg : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? color : const Color(0xFFD3D1C7),
                width: selected ? 1.5 : 0.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _iconOptions[i]['icon'] as IconData,
                  color: selected ? color : const Color(0xFF888780),
                  size: 22,
                ),
                const SizedBox(height: 4),
                Text(
                  _iconOptions[i]['label'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: selected ? color : const Color(0xFF888780),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_colorOptions.length, (i) {
        final selected = i == _selectedColorIndex;
        final color = _colorOptions[i]['color'] as Color;
        return GestureDetector(
          onTap: () => setState(() => _selectedColorIndex = i),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? _greenDark : Colors.transparent,
                width: 2.5,
              ),
            ),
            child: selected
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                : null,
          ),
        );
      }),
    );
  }

  Widget _buildGoalRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _goalController,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
            decoration: _inputDecoration(hint: '30'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _greenMid, width: 0.5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedUnit,
                isExpanded: true,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF085041),
                ),
                onChanged: (val) => setState(() => _selectedUnit = val!),
                items: _units
                    .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: _green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: const Text(
          'Save habit',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF085041),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFB4B2A9)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF5DCAA5), width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF5DCAA5), width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1D9E75), width: 1.5),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:pdf_reader/pages/musicpage.dart';
import 'package:pdf_reader/pages/notespage.dart';
import 'package:pdf_reader/pages/pdfpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final _selectedColor = Colors.white;
  final _unselectedColor = Colors.grey[60];
  final _labelStyle =
      const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 90, 103, 166),
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            groupAlignment: 0,
            indicatorColor: Colors.orange.shade200,
            onDestinationSelected: _onDestinationselected,
            backgroundColor: Colors.transparent,
            selectedLabelTextStyle: _labelStyle.copyWith(color: _selectedColor),
            unselectedLabelTextStyle:
                _labelStyle.copyWith(color: _unselectedColor),
            destinations:  const [
              NavigationRailDestination(
                  icon: Icon(fluent.FluentIcons.document_search), label: Text('Home')),
              NavigationRailDestination(
                  icon: Icon(fluent.FluentIcons.sticky_notes_outline_app_icon), label: Text('Note')),
              NavigationRailDestination(
                  icon: Icon(fluent.FluentIcons.music_note,), label: Text('Music')),
            ],
            selectedIndex: selectedIndex,
            // labelType: NavigationRailLabelType.selected,
            useIndicator: true,
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            selectedIconTheme: const IconThemeData(color: Colors.black),
            leading: InkWell(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Image.asset(
                'assets/logo.png',
                width: 40,
                height: 40,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          //  const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: buildPage())
        ],
      ),
    );
  }

  _onDestinationselected(int idx) {
    setState(() {
      selectedIndex = idx;
    });
  }

  Widget buildPage() {
    switch (selectedIndex) {
      case 0:
        return PdfPage();
      case 1:
        return const NotesPage();
      case 2:
        return MusicPage();

      default:
        return PdfPage();
    }
  }
}

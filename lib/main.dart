import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const SawtApp());

class SawtApp extends StatelessWidget {
  const SawtApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SawtBilaWatar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xFF0B3D2E)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final List<Widget> _pages = const [HomeTab(), MushafTab(), MoreTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'المصحف'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'المزيد'),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFF0B3D2E), borderRadius: BorderRadius.circular(20)),
          child: const Column(children: [
            Text('صوت بلا وتر', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            Text('صوت يصل للقلب بلا وتر', style: TextStyle(color: Color(0xFFD4AF37))),
            SizedBox(height: 10),
            Text('تأسست 22/10/2026', style: TextStyle(color: Colors.white70)),
          ]),
        ),
        const SizedBox(height: 16),
        const Card(child: ListTile(leading: Icon(Icons.menu_book), title: Text('المصحف - 604 صفحة'))),
        const Card(child: ListTile(leading: Icon(Icons.mic), title: Text('انشر بصوتك'))),
        const Card(child: ListTile(leading: Icon(Icons.mosque), title: Text('المؤذن'))),
      ],
    );
  }
}

class MushafTab extends StatefulWidget {
  const MushafTab({super.key});
  @override
  State<MushafTab> createState() => _MushafTabState();
}

class _MushafTabState extends State<MushafTab> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    String text = page == 1
      ? 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ\nالْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ\nالرَّحْمَنِ الرَّحِيمِ\nمَالِكِ يَوْمِ الدِّينِ'
      : 'صفحة $page - الجزء ${(page / 20).ceil()}\n\n© SawtBilaWatar | Islam El-Suorey 2026';
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Text('صفحة $page / 604', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Expanded(child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD4AF37)), borderRadius: BorderRadius.circular(16)), child: Center(child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, height: 2))))),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ElevatedButton(onPressed: page > 1 ? () => setState(() => page--) : null, child: const Text('السابق')),
          ElevatedButton(onPressed: page < 604 ? () => setState(() => page++) : null, child: const Text('التالي')),
        ]),
      ]),
    );
  }
}

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});
  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
  @override
  Widget build(BuildContext context) {
    final links = [
      ('يوتيوب', 'https://youtube.com/@sawtbilawatar'),
      ('تليجرام', 'https://t.me/SawtBilaWatar'),
      ('تيك توك', 'https://www.tiktok.com/@sawtbilawatar'),
      ('فيسبوك بيدج', 'https://www.facebook.com/SawtBilaWatar'),
      ('فيسبوك جروب', 'https://facebook.com/groups/sawtbilawater'),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('تابعنا على كل المنصات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...links.map((e) => Card(child: ListTile(title: Text(e.$1), trailing: const Icon(Icons.open_in_new), onTap: () => _open(e.$2)))),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF0B3D2E), borderRadius: BorderRadius.circular(16)), child: const Text('© SawtBilaWatar | Islam El-Suorey 2026 - جميع الحقوق محفوظة - يمنع اعادة الرفع دون اذن', style: TextStyle(color: Colors.white))),
      ],
    );
  }
}

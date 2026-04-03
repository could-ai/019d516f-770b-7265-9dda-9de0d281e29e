import 'package:flutter/material.dart';

void main() {
  runApp(const PhbsPresentationApp());
}

class PhbsPresentationApp extends StatelessWidget {
  const PhbsPresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presentasi PHBS Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class SlideData {
  final String title;
  final List<String> points;
  final IconData icon;

  SlideData({required this.title, required this.points, required this.icon});
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: 'Perilaku Hidup Bersih dan Sehat (PHBS)\ndi Lingkungan Kampus',
      points: ['Mewujudkan Kampus Sehat, Nyaman, dan Berprestasi'],
      icon: Icons.health_and_safety,
    ),
    SlideData(
      title: 'Apa itu PHBS di Kampus?',
      points: [
        'Sekumpulan perilaku yang dipraktikkan atas dasar kesadaran.',
        'Hasil pembelajaran untuk menolong diri sendiri di bidang kesehatan.',
        'Berperan aktif mewujudkan kesehatan lingkungan kampus.',
      ],
      icon: Icons.school,
    ),
    SlideData(
      title: 'Mengapa PHBS Penting?',
      points: [
        'Mencegah penyebaran penyakit menular.',
        'Meningkatkan konsentrasi dan produktivitas belajar.',
        'Menciptakan lingkungan kampus yang bersih dan nyaman.',
        'Membangun citra positif institusi pendidikan.',
      ],
      icon: Icons.lightbulb,
    ),
    SlideData(
      title: 'Indikator PHBS (Bagian 1)',
      points: [
        '1. Mencuci tangan dengan sabun dan air mengalir.',
        '2. Mengonsumsi jajanan sehat di kantin kampus.',
        '3. Menggunakan toilet/jamban yang bersih dan sehat.',
      ],
      icon: Icons.wash,
    ),
    SlideData(
      title: 'Indikator PHBS (Bagian 2)',
      points: [
        '4. Olahraga teratur dan terukur.',
        '5. Memberantas jentik nyamuk di lingkungan kampus.',
        '6. Tidak merokok di area kampus (Kawasan Tanpa Rokok).',
      ],
      icon: Icons.sports_gymnastics,
    ),
    SlideData(
      title: 'Indikator PHBS (Bagian 3)',
      points: [
        '7. Membuang sampah pada tempatnya (sesuai jenis: organik/anorganik).',
        '8. Menimbang berat badan dan mengukur tinggi badan secara berkala.',
      ],
      icon: Icons.delete_outline,
    ),
    SlideData(
      title: 'Peran Mahasiswa',
      points: [
        'Menjadi Agen Perubahan (Agent of Change).',
        'Mempraktikkan PHBS mulai dari diri sendiri.',
        'Menegur dengan sopan jika ada yang melanggar aturan kebersihan.',
        'Menjaga dan merawat fasilitas kampus bersama.',
      ],
      icon: Icons.groups,
    ),
    SlideData(
      title: 'Kesimpulan',
      points: [
        'Kampus sehat berawal dari kebiasaan kecil kita.',
        'Mari bersama-sama terapkan PHBS untuk masa depan yang lebih baik.',
        'Kesehatan adalah investasi masa depan!',
      ],
      icon: Icons.check_circle_outline,
    ),
    SlideData(
      title: 'Terima Kasih',
      points: ['Mari Wujudkan Kampus Sehat Bersama-sama!'],
      icon: Icons.favorite,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return SlideWidget(
                    slide: _slides[index], 
                    isTitleSlide: index == 0 || index == _slides.length - 1
                  );
                },
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: _currentPage > 0 ? _prevPage : null,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Sebelumnya'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Slide ${_currentPage + 1} dari ${_slides.length}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _currentPage < _slides.length - 1 ? _nextPage : null,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Selanjutnya'),
            iconAlignment: IconAlignment.end,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;
  final bool isTitleSlide;

  const SlideWidget({super.key, required this.slide, this.isTitleSlide = false});

  @override
  Widget build(BuildContext context) {
    // Responsive padding based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = screenWidth > 800 ? 64.0 : 24.0;
    double titleFontSize = screenWidth > 800 ? (isTitleSlide ? 56.0 : 42.0) : (isTitleSlide ? 36.0 : 28.0);
    double bodyFontSize = screenWidth > 800 ? 28.0 : 18.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: isTitleSlide ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              if (isTitleSlide) ...[
                Icon(slide.icon, size: screenWidth > 800 ? 120 : 80, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 32),
              ],
              Text(
                slide.title,
                textAlign: isTitleSlide ? TextAlign.center : TextAlign.left,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  height: 1.2,
                ),
              ),
              SizedBox(height: isTitleSlide ? 24 : 48),
              if (!isTitleSlide)
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (screenWidth > 600) ...[
                        Icon(slide.icon, size: 80, color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)),
                        const SizedBox(width: 40),
                      ],
                      Expanded(
                        child: ListView(
                          children: slide.points.map((point) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• ', style: TextStyle(fontSize: bodyFontSize + 4, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                                  Expanded(
                                    child: Text(
                                      point,
                                      style: TextStyle(fontSize: bodyFontSize, height: 1.5, color: Colors.black87),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...slide.points.map((point) => Text(
                      point,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: bodyFontSize, fontStyle: FontStyle.italic, color: Colors.black54),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

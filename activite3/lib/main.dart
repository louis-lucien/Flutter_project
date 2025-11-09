import 'package:flutter/material.dart';
import 'redacteurs_interface.dart'; // ✅ Ajout obligatoire

void main() {
  runApp(MonAppli());
}

class MonAppli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazine Infos',
      debugShowCheckedModeBanner: false,
      home: NavigationPrincipale(),
    );
  }
}

class NavigationPrincipale extends StatefulWidget {
  @override
  State<NavigationPrincipale> createState() => _NavigationPrincipaleState();
}

class _NavigationPrincipaleState extends State<NavigationPrincipale> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    PageAccueil(),
    const RedacteurInterface(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Rédacteurs',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
    );
  }
}

//----------------------------------------------------------
// PAGE ACCUEIL
//----------------------------------------------------------
class PageAccueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Taille de l’écran pour la responsivité
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazine Infos'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image principale
            Image.asset(
              'assets/images/magazine.jpeg',
              width: screenWidth,
              fit: BoxFit.cover,
            ),
            const PartieTitre(),
            const PartieTexte(),
            const PartieIcone(),
            const PartieRubrique(),
          ],
        ),
      ),
    );
  }
}

//----------------------------------------------------------
// PARTIE TITRE
//----------------------------------------------------------
class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleSize = screenWidth * 0.06; // taille responsive
    final subtitleSize = screenWidth * 0.04;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenue dans Magazine Infos',
            style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Votre source d’actualité numérique et tendances',
            style: TextStyle(fontSize: subtitleSize, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

//----------------------------------------------------------
// PARTIE TEXTE
//----------------------------------------------------------
class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textSize = screenWidth * 0.04;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        'Magazine Infos est un magazine numérique qui propose des articles '
        'variés sur la technologie, la mode, la culture et bien plus encore. '
        'Restez informé(e) et inspiré(e) grâce à nos rubriques riches et captivantes !',
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: textSize),
      ),
    );
  }
}

//----------------------------------------------------------
// PARTIE ICONE
//----------------------------------------------------------
class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.width * 0.08;

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _iconeElement(Icons.phone, 'TEL', iconSize),
          _iconeElement(Icons.email, 'MAIL', iconSize),
          _iconeElement(Icons.share, 'PARTAGE', iconSize),
        ],
      ),
    );
  }

  Widget _iconeElement(IconData icon, String label, double iconSize) {
    return Column(
      children: [
        Icon(icon, color: Colors.pink, size: iconSize),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.pink)),
      ],
    );
  }
}

//----------------------------------------------------------
// PARTIE RUBRIQUE
//----------------------------------------------------------
class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Dimensions pour la première image
    final imageWidth1 = screenWidth * 0.35;
    final imageHeight1 = imageWidth1 * 0.7;
    // Dimensions réduites pour la deuxième image
    final imageWidth2 = screenWidth * 0.35;
    final imageHeight2 = imageWidth2 * 0.7;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _rubriqueImage(
            'assets/images/presse.jpeg',
            imageWidth1,
            imageHeight1,
          ),
          _rubriqueImage('assets/images/note.jpeg', imageWidth2, imageHeight2),
        ],
      ),
    );
  }

  Widget _rubriqueImage(String path, double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(path, width: width, height: height, fit: BoxFit.cover),
    );
  }
}

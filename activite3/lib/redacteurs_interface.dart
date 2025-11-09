import 'package:flutter/material.dart';
import 'database/database_manager.dart';
import 'modele/redacteur.dart';

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  List<Redacteur> redacteurs = [];

  @override
  void initState() {
    super.initState();
    _loadRedacteurs();
  }

  Future<void> _loadRedacteurs() async {
    final data = await DatabaseManager.instance.getAllRedacteurs();
    setState(() {
      redacteurs = data;
    });
  }

  Future<void> _addRedacteur() async {
    if (_nomController.text.isEmpty ||
        _prenomController.text.isEmpty ||
        _emailController.text.isEmpty)
      return;

    final redacteur = Redacteur(
      nom: _nomController.text,
      prenom: _prenomController.text,
      email: _emailController.text,
    );

    await DatabaseManager.instance.insertRedacteur(redacteur);
    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();
    _loadRedacteurs();
  }

  Future<void> _editRedacteur(Redacteur redacteur) async {
    _nomController.text = redacteur.nom;
    _prenomController.text = redacteur.prenom;
    _emailController.text = redacteur.email;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Modifier le rédacteur"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              await DatabaseManager.instance.updateRedacteur(
                Redacteur(
                  id: redacteur.id,
                  nom: _nomController.text,
                  prenom: _prenomController.text,
                  email: _emailController.text,
                ),
              );
              Navigator.pop(context);
              _loadRedacteurs();
            },
            child: const Text("Enregistrer"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteRedacteur(int id) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
        content: const Text("Voulez-vous vraiment supprimer ce rédacteur ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Non"),
          ),
          ElevatedButton(
            onPressed: () async {
              await DatabaseManager.instance.deleteRedacteur(id);
              Navigator.pop(context);
              _loadRedacteurs();
            },
            child: const Text("Oui"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Rédacteurs'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: 'Prénom'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _addRedacteur,
              icon: const Icon(Icons.add),
              label: const Text("Ajouter un Rédacteur"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: redacteurs.length,
                itemBuilder: (context, index) {
                  final r = redacteurs[index];
                  return Card(
                    child: ListTile(
                      title: Text("${r.nom} ${r.prenom}"),
                      subtitle: Text(r.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editRedacteur(r),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteRedacteur(r.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

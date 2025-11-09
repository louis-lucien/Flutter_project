class Redacteur {
  int? id;
  String nom;
  String prenom;
  String email;

  Redacteur({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  // Convertir un objet Redacteur en Map (pour l’enregistrer dans SQLite)
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'nom': nom, 'prenom': prenom, 'email': email};
    if (id != null) map['id'] = id;
    return map;
  }

  // Convertir un Map (issu de la base) en objet Redacteur
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
    );
  }
}

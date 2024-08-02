// Archivo: user_model.dart
class UserModel {
  final String id;
  final String email;
  final String? imageUrl; // Agregamos el campo de la URL de la imagen

  UserModel({required this.id, required this.email, this.imageUrl});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      imageUrl: map['image'], // Obtener la URL de la imagen desde el mapa
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'image': imageUrl, // Añadir la URL de la imagen al mapa
    };
  }
}

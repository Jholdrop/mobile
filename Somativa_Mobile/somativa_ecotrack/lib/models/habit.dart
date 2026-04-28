/// Modelo de dados para representar um hábito sustentável
/// 
/// Contém informações sobre o hábito, como nome, descrição, ícone e status de conclusão
class Habit {
  /// Identificador único do hábito
  final String id;
  
  /// Nome do hábito sustentável
  final String name;
  
  /// Descrição detalhada do hábito
  final String description;
  
  /// Ícone que representa o hábito (usando IconData do Flutter)
  final int iconCodePoint;
  
  /// Nome da família de ícones
  final String iconFontFamily;
  
  /// Categoria do hábito (ex: água, energia, resíduos, transporte)
  final String category;
  
  /// Pontuação awarded ao completar o hábito
  final int points;
  
  /// Indica se o hábito foi concluído
  bool isCompleted;
  
  /// Data em que o hábito foi concluído (null se não concluído)
  DateTime? completedAt;

  /// Construtor padrão do modelo Habit
  /// 
  /// [id] - Identificador único
  /// [name] - Nome do hábito
  /// [description] - Descrição do hábito
  /// [iconCodePoint] - Código do ícone
  /// [iconFontFamily] - Família do ícone
  /// [category] - Categoria do hábito
  /// [points] - Pontos awarded
  /// [isCompleted] - Status de conclusão
  Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.iconCodePoint,
    required this.iconFontFamily,
    required this.category,
    this.points = 10,
    this.isCompleted = false,
    this.completedAt,
  });

  /// Cria uma cópia do hábito com os campos atualizados
  Habit copyWith({
    String? id,
    String? name,
    String? description,
    int? iconCodePoint,
    String? iconFontFamily,
    String? category,
    int? points,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      iconFontFamily: iconFontFamily ?? this.iconFontFamily,
      category: category ?? this.category,
      points: points ?? this.points,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Converte o hábito para um mapa (para possível persistência)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'category': category,
      'points': points,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  /// Cria um hábito a partir de um mapa
  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      iconCodePoint: map['iconCodePoint'] as int,
      iconFontFamily: map['iconFontFamily'] as String,
      category: map['category'] as String,
      points: map['points'] as int? ?? 10,
      isCompleted: map['isCompleted'] as bool? ?? false,
      completedAt: map['completedAt'] != null 
          ? DateTime.parse(map['completedAt'] as String) 
          : null,
    );
  }
}
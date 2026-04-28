import 'package:flutter/material.dart';
import '../models/habito.dart';

/// Provider para gerenciamento de estado global da aplicação EcoTrack
/// 
/// Responsável por:
/// - Armazenar a lista de hábitos pendentes e concluídos
/// - Marcar hábitos como concluídos
/// - Calcular quantidade de hábitos realizados
/// - Atualizar os dados do dashboard
/// - Controlar a tela selecionada no BottomNavigationBar
/// - Controlar tema claro/escuro
class EcoTrackProvider extends ChangeNotifier {
  // ============================================
  // ATRIBUTOS PRIVADOS
  // ============================================
  
  /// Lista de hábitos pendentes (não concluídos)
  List<Habit> _pendingHabits = [];
  
  /// Lista de hábitos já concluídos
  final List<Habit> _completedHabits = [];
  
  /// Índice da aba selecionada no BottomNavigationBar
  int _currentIndex = 0;
  
  /// Nome do usuário
  String _userName = 'Usuário';
  
  /// Indica se o modo escuro está ativado
  bool _isDarkMode = false;
  
  /// Meta semanal de hábitos (em percentual)
  int _weeklyGoal = 60;
  
  /// Nível atual do usuário
  int _userLevel = 1;
  
  /// Pontuação ecológica total
  int _ecoPoints = 0;

  // ============================================
  // GETTERS PÚBLICOS
  // ============================================
  
  /// Retorna a lista de hábitos pendentes
  List<Habit> get pendingHabits => _pendingHabits;
  
  /// Retorna a lista de hábitos concluídos
  List<Habit> get completedHabits => _completedHabits;
  
  /// Retorna o índice da aba atual
  int get currentIndex => _currentIndex;
  
  /// Retorna o nome do usuário
  String get userName => _userName;
  
  /// Indica se o modo escuro está ativado
  bool get isDarkMode => _isDarkMode;
  
  /// Retorna a meta semanal
  int get weeklyGoal => _weeklyGoal;
  
  /// Retorna o nível do usuário
  int get userLevel => _userLevel;
  
  /// Retorna a pontuação ecológica
  int get ecoPoints => _ecoPoints;
  
  /// Retorna o total de hábitos
  int get totalHabits => _pendingHabits.length + _completedHabits.length;
  
  /// Retorna o número de hábitos concluídos
  int get completedCount => _completedHabits.length;
  
  /// Retorna o número de hábitos pendentes
  int get pendingCount => _pendingHabits.length;
  
  /// Calcula o progresso semanal em percentual
  double get weeklyProgress {
    if (totalHabits == 0) return 0;
    return (completedCount / totalHabits) * 100;
  }
  
  /// Retorna a lista de todos os hábitos (pendentes + concluídos)
  List<Habit> get allHabits => [..._pendingHabits, ..._completedHabits];

  // ============================================
  // CONSTRUTOR
  // ============================================
  
  /// Construtor que inicializa com hábitos padrão
  EcoTrackProvider() {
    _initializeDefaultHabits();
  }

  // ============================================
  // MÉTODOS PÚBLICOS
  // ============================================
  
  /// Inicializa a lista de hábitos padrão do aplicativo
  void _initializeDefaultHabits() {
    _pendingHabits = [
      // Hábitos de água
      Habit(
        id: '1',
        name: 'Economizar água no banho',
        description: 'Reduza o tempo do banho para 5 minutos',
        iconCodePoint: Icons.water_drop.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Água',
        points: 15,
      ),
      Habit(
        id: '2',
        name: 'Desligar torneira ao escovar dentes',
        description: 'Feche a torneira enquanto escova os dentes',
        iconCodePoint: Icons.water.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Água',
        points: 10,
      ),
      
      // Hábitos de resíduos
      Habit(
        id: '3',
        name: 'Separar lixo reciclável',
        description: 'Separe papel, plástico, metal e vidro para reciclagem',
        iconCodePoint: Icons.recycling.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Resíduos',
        points: 20,
      ),
      Habit(
        id: '4',
        name: 'Usar sacola reutilizável',
        description: 'Leve sacolas reutilizáveis ao fazer compras',
        iconCodePoint: Icons.shopping_bag.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Resíduos',
        points: 10,
      ),
      
      // Hábitos de energia
      Habit(
        id: '5',
        name: 'Desligar luzes desnecessárias',
        description: 'Apague as luzes ao sair de um cômodo',
        iconCodePoint: Icons.lightbulb_outline.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Energia',
        points: 10,
      ),
      Habit(
        id: '6',
        name: 'Desconectar eletrônicos',
        description: 'Desconecte carregadores e eletrônicos em standby',
        iconCodePoint: Icons.power_off.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Energia',
        points: 15,
      ),
      
      // Hábitos de transporte
      Habit(
        id: '7',
        name: 'Usar transporte coletivo',
        description: 'Prefira ônibus, metrô ou trem ao carro',
        iconCodePoint: Icons.directions_bus.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Transporte',
        points: 20,
      ),
      Habit(
        id: '8',
        name: 'Usar bicicleta',
        description: 'Use bicicleta para deslocamentos curtos',
        iconCodePoint: Icons.pedal_bike.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Transporte',
        points: 25,
      ),
      Habit(
        id: '9',
        name: 'Caminhar em vez de dirigir',
        description: 'Para distâncias curtas, caminhe',
        iconCodePoint: Icons.directions_walk.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Transporte',
        points: 15,
      ),
      
      // Hábitos de consumo
      Habit(
        id: '10',
        name: 'Usar garrafa reutilizável',
        description: 'Leve sua própria garrafa de água',
        iconCodePoint: Icons.local_drink.codePoint,
        iconFontFamily: 'MaterialIcons',
        category: 'Consumo',
        points: 15,
      ),
    ];
  }

  /// Define o índice da aba selecionada
  void setCurrentIndex(int index) {
    if (index >= 0 && index <= 2) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  /// Marca um hábito como concluído
  /// 
  /// [habitId] - ID do hábito a ser marcado como concluído
  void completeHabit(String habitId) {
    // Procura o hábito na lista de pendentes
    final habitIndex = _pendingHabits.indexWhere((h) => h.id == habitId);
    
    if (habitIndex != -1) {
      // Remove o hábito da lista de pendentes
      final habit = _pendingHabits.removeAt(habitIndex);
      
      // Cria uma cópia com o status de concluído
      final completedHabit = habit.copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      );
      
      // Adiciona à lista de concluídos
      _completedHabits.add(completedHabit);
      
      // Atualiza a pontuação
      _ecoPoints += habit.points;
      
      // Verifica se o usuário sobe de nível
      _checkLevelUp();
      
      notifyListeners();
    }
  }

  /// Desmarca um hábito como concluído (move de volta para pendente)
  /// 
  /// [habitId] - ID do hábito a ser desmarcado
  void uncompleteHabit(String habitId) {
    // Procura o hábito na lista de concluídos
    final habitIndex = _completedHabits.indexWhere((h) => h.id == habitId);
    
    if (habitIndex != -1) {
      // Remove o hábito da lista de concluídos
      final habit = _completedHabits.removeAt(habitIndex);
      
      // Cria uma cópia com o status de não concluído
      final pendingHabit = habit.copyWith(
        isCompleted: false,
        completedAt: null,
      );
      
      // Adiciona à lista de pendentes
      _pendingHabits.add(pendingHabit);
      
      // Remove a pontuação
      _ecoPoints -= habit.points;
      if (_ecoPoints < 0) _ecoPoints = 0;
      
      notifyListeners();
    }
  }

  /// Verifica se o usuário deve subir de nível
  void _checkLevelUp() {
    // A cada 100 pontos, o usuário sobe um nível
    final newLevel = (_ecoPoints ~/ 100) + 1;
    if (newLevel > _userLevel) {
      _userLevel = newLevel;
    }
  }

  /// Atualiza o nome do usuário
  void setUserName(String name) {
    if (name.isNotEmpty) {
      _userName = name;
      notifyListeners();
    }
  }

  /// Alterna entre modo claro e escuro
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// Define o modo escuro
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  /// Atualiza a meta semanal
  void setWeeklyGoal(int goal) {
    if (goal >= 0 && goal <= 100) {
      _weeklyGoal = goal;
      notifyListeners();
    }
  }

  /// Limpa todos os hábitos concluídos
  void clearCompletedHabits() {
    _completedHabits.clear();
    notifyListeners();
  }

  /// Reseta todo o progresso do usuário
  void resetProgress() {
    _pendingHabits.clear();
    _completedHabits.clear();
    _ecoPoints = 0;
    _userLevel = 1;
    _initializeDefaultHabits();
    notifyListeners();
  }

  /// Adiciona um novo hábito personalizado
  void addCustomHabit(Habit habit) {
    _pendingHabits.add(habit);
    notifyListeners();
  }

  /// Remove um hábito pelo ID
  void removeHabit(String habitId) {
    _pendingHabits.removeWhere((h) => h.id == habitId);
    _completedHabits.removeWhere((h) => h.id == habitId);
    notifyListeners();
  }

  /// Retorna hábitos por categoria
  List<Habit> getHabitsByCategory(String category) {
    return allHabits.where((h) => h.category == category).toList();
  }

  /// Retorna as categorias disponíveis
  List<String> get categories {
    final allCategories = allHabits.map((h) => h.category).toSet().toList();
    allCategories.sort();
    return allCategories;
  }

  /// Calcula o impacto estimado (em kg de CO2 economizado)
  /// Estimativa baseada em estudos ambientais
  double get estimatedImpact {
    // Cada hábito completo economiza aproximadamente 0.5kg de CO2 por dia
    return _completedHabits.length * 0.5 * 7; // Por semana
  }
}


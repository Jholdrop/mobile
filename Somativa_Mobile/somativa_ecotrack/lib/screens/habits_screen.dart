import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/eco_track_provider.dart';

/// Tela de Hábitos Sustentáveis com TabBarView
/// 
/// Contém duas abas:
/// - Aba 1: Hábitos Pendentes (ListView)
/// - Aba 2: Hábitos Concluídos (ListView)
class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ============================================
        // TAB BAR
        // ============================================
        Container(
          color: Theme.of(context).colorScheme.primary,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.amber,
            indicatorWeight: 3,
            tabs: [
              // Aba de Hábitos Pendentes
              Consumer<EcoTrackProvider>(
                builder: (context, provider, child) {
                  return Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.pending_actions, size: 20),
                        const SizedBox(width: 8),
                        Text('Pendentes (${provider.pendingCount})'),
                      ],
                    ),
                  );
                },
              ),
              
              // Aba de Hábitos Concluídos
              Consumer<EcoTrackProvider>(
                builder: (context, provider, child) {
                  return Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, size: 20),
                        const SizedBox(width: 8),
                        Text('Concluídos (${provider.completedCount})'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        
        // ============================================
        // TAB BAR VIEW
        // ============================================
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Aba 1: Hábitos Pendentes
              _buildPendingHabitsTab(),
              
              // Aba 2: Hábitos Concluídos
              _buildCompletedHabitsTab(),
            ],
          ),
        ),
      ],
    );
  }

  /// Constrói a aba de hábitos pendentes
  Widget _buildPendingHabitsTab() {
    return Consumer<EcoTrackProvider>(
      builder: (context, provider, child) {
        final pendingHabits = provider.pendingHabits;
        
        if (pendingHabits.isEmpty) {
          return _buildEmptyState(
            icon: Icons.celebration,
            title: 'Parabéns!',
            message: 'Você completou todos os hábitos!',
            color: Colors.green,
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: pendingHabits.length,
          itemBuilder: (context, index) {
            return _buildHabitCard(pendingHabits[index], isPending: true);
          },
        );
      },
    );
  }

  /// Constrói a aba de hábitos concluídos
  Widget _buildCompletedHabitsTab() {
    return Consumer<EcoTrackProvider>(
      builder: (context, provider, child) {
        final completedHabits = provider.completedHabits;
        
        if (completedHabits.isEmpty) {
          return _buildEmptyState(
            icon: Icons.pending_actions,
            title: 'Nenhum hábito concluído',
            message: 'Complete hábitos para vê-los aqui',
            color: Colors.grey,
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: completedHabits.length,
          itemBuilder: (context, index) {
            return _buildHabitCard(completedHabits[index], isPending: false);
          },
        );
      },
    );
  }

  /// Constrói um card de hábito
  Widget _buildHabitCard(Habit habit, {required bool isPending}) {
    // Define a cor baseada na categoria
    Color categoryColor = _getCategoryColor(habit.category);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showHabitDetails(habit),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // ============================================
              // ÍCONE DO HÁBITO
              // ============================================
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  IconData(habit.iconCodePoint, fontFamily: habit.iconFontFamily),
                  color: categoryColor,
                  size: 28,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // ============================================
              // INFORMAÇÕES DO HÁBITO
              // ============================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome do hábito
                    Text(
                      habit.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Descrição
                    Text(
                      habit.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Categoria e pontos
                    Row(
                      children: [
                        // Badge de categoria
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            habit.category,
                            style: TextStyle(
                              fontSize: 11,
                              color: categoryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 8),
                        
                        // Pontos
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${habit.points} pts',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // ============================================
              // BOTÃO DE AÇÃO
              // ============================================
              if (isPending)
                IconButton(
                  onPressed: () {
                    // Marca como concluído
                    context.read<EcoTrackProvider>().completeHabit(habit.id);
                    
                    // Feedback visual
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${habit.name} concluído! +${habit.points} pontos'),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 32,
                  ),
                  tooltip: 'Marcar como concluído',
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Constrói estado vazio
  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
    required Color color,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: color.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Retorna a cor baseada na categoria
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Água':
        return Colors.blue;
      case 'Resíduos':
        return Colors.brown;
      case 'Energia':
        return Colors.orange;
      case 'Transporte':
        return Colors.purple;
      case 'Consumo':
        return Colors.teal;
      default:
        return Colors.green;
    }
  }

  /// Exibe detalhes do hábito
  void _showHabitDetails(Habit habit) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        Color categoryColor = _getCategoryColor(habit.category);
        
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================
              // ÍCONE E TÍTULO
              // ============================================
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      IconData(habit.iconCodePoint, fontFamily: habit.iconFontFamily),
                      color: categoryColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            habit.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: categoryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // ============================================
              // DESCRIÇÃO
              // ============================================
              Text(
                'Descrição',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                habit.description,
                style: const TextStyle(fontSize: 16),
              ),
              
              const SizedBox(height: 16),
              
              // ============================================
              // PONTOS
              // ============================================
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${habit.points} pontos awarded ao completar',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // ============================================
              // BOTÃO DE AÇÃO
              // ============================================
              if (!habit.isCompleted)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<EcoTrackProvider>().completeHabit(habit.id);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${habit.name} concluído! +${habit.points} pontos'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Marcar como Concluído'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<EcoTrackProvider>().uncompleteHabit(habit.id);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.undo, color: Colors.orange),
                    label: const Text('Desmarcar Conclusão'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Colors.orange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
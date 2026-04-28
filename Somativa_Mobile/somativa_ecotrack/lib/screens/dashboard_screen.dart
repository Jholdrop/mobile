import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/eco_track_provider.dart';
import '../widgets/dashboard_info_card.dart';

/// Tela de dashboard com resumo das acoes sustentaveis.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EcoTrackProvider>(
      builder: (context, provider, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final int crossAxisCount = constraints.maxWidth >= 900
                ? 3
                : constraints.maxWidth >= 600
                    ? 2
                    : 2;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, provider),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: crossAxisCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.25,
                    children: [
                      DashboardInfoCard(
                        icon: Icons.check_circle,
                        iconColor: Colors.green,
                        title: 'Habitos concluidos',
                        value: '${provider.completedCount}',
                        backgroundColor: Colors.green.withValues(alpha: 0.12),
                      ),
                      DashboardInfoCard(
                        icon: Icons.pending_actions,
                        iconColor: Colors.orange,
                        title: 'Habitos pendentes',
                        value: '${provider.pendingCount}',
                        backgroundColor: Colors.orange.withValues(alpha: 0.12),
                      ),
                      DashboardInfoCard(
                        icon: Icons.star,
                        iconColor: Colors.amber.shade700,
                        title: 'Pontuacao verde',
                        value: '${provider.ecoPoints}',
                        backgroundColor: Colors.amber.withValues(alpha: 0.12),
                      ),
                      DashboardInfoCard(
                        icon: Icons.flag,
                        iconColor: Colors.blue,
                        title: 'Meta semanal',
                        value: '${provider.weeklyGoal}%',
                        backgroundColor: Colors.blue.withValues(alpha: 0.12),
                      ),
                      DashboardInfoCard(
                        icon: Icons.emoji_events,
                        iconColor: Colors.purple,
                        title: 'Nivel atual',
                        value: 'Nivel ${provider.userLevel}',
                        backgroundColor: Colors.purple.withValues(alpha: 0.12),
                      ),
                      DashboardInfoCard(
                        icon: Icons.eco,
                        iconColor: Colors.teal,
                        title: 'Impacto estimado',
                        value: '${provider.estimatedImpact.toStringAsFixed(1)} kg',
                        backgroundColor: Colors.teal.withValues(alpha: 0.12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildProgressCard(context, provider),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, EcoTrackProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ola, ${provider.userName}!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Veja o resumo das suas acoes sustentaveis da semana.',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context, EcoTrackProvider provider) {
    final double progress = (provider.weeklyProgress / 100).clamp(0, 1);
    final bool reachedGoal = provider.weeklyProgress >= provider.weeklyGoal;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progresso semanal',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(
                reachedGoal ? Colors.green : Colors.orange,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            reachedGoal
                ? 'Meta atingida: ${provider.weeklyProgress.toStringAsFixed(0)}%'
                : 'Atual: ${provider.weeklyProgress.toStringAsFixed(0)}% | Meta: ${provider.weeklyGoal}%',
          ),
        ],
      ),
    );
  }
}

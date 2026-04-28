import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/eco_track_provedor.dart';

/// Pagina Home de apresentacao do aplicativo (sem login).
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EcoTrackProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.eco, color: Colors.white, size: 80),
                    SizedBox(height: 12),
                    Text(
                      'EcoTrack',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Acompanhe seus habitos sustentaveis e veja seu impacto positivo no planeta.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resumo rapido',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Habitos concluidos: ${provider.completedCount}'),
                      Text('Habitos pendentes: ${provider.pendingCount}'),
                      Text('Pontuacao verde: ${provider.ecoPoints} pontos'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => provider.setCurrentIndex(1),
                icon: const Icon(Icons.check_circle),
                label: const Text('Ir para Habitos Sustentaveis'),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () => provider.setCurrentIndex(2),
                icon: const Icon(Icons.dashboard),
                label: const Text('Ver Dashboard Ambiental'),
              ),
            ],
          ),
        );
      },
    );
  }
}


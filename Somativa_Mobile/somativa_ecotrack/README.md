# SOMATIVA_ECOTRACK

Aplicativo Flutter (nível iniciante) para controle de hábitos sustentáveis com `Provider`.

## Páginas da atividade
- Home (apresentação do app)
- Hábitos Sustentáveis (`TabBarView` com pendentes e concluídos)
- Dashboard Ambiental (resumo em cards)

## Widgets exigidos usados
- `Scaffold`
- `AppBar`
- `Drawer`
- `BottomNavigationBar`
- `TabBarView`
- `ListView`
- `GridView`

## Estrutura
```text
lib/
  models/habit.dart
  providers/eco_track_provider.dart
  screens/home_screen.dart
  screens/welcome_screen.dart
  screens/habits_screen.dart
  screens/dashboard_screen.dart
  widgets/dashboard_info_card.dart
  main.dart
```

## Executar
```
flutter run (terminal)
```

## Documentação
- `docs/ISO29148_Requisitos_EcoTrack.md`
- `docs/Prototipos_Media_Fidelidade_EcoTrack.md`


Data: 28/04/2026  
Projeto: SOMATIVA_ECOTRACK

## 1. Objetivo
Desenvolver um aplicativo Flutter responsivo para acompanhar habitos sustentaveis.

## 2. Escopo (3 paginas)
- Home: apresentacao do aplicativo.
- Habitos Sustentaveis: controle de habitos pendentes e concluidos.
- Dashboard Ambiental: resumo visual do progresso.

## 3. Requisitos Funcionais
- RF-01: Exibir pagina Home com nome do app, descricao e ilustracao/icone.
- RF-02: Exibir navegacao com `Drawer` e `BottomNavigationBar`.
- RF-03: Permitir troca entre 3 paginas: Home, Habitos e Dashboard.
- RF-04: Controlar a aba selecionada pelo `Provider`.
- RF-05: Exibir pagina de Habitos com `TabBarView`.
- RF-06: Exibir habitos pendentes em `ListView`.
- RF-07: Permitir marcar habito como concluido.
- RF-08: Ao concluir, mover habito para lista de concluidos via `Provider`.
- RF-09: Exibir habitos concluidos em `ListView`.
- RF-10: Exibir Dashboard em `GridView` com cards de resumo.
- RF-11: Atualizar Dashboard automaticamente quando o estado mudar.

## 4. Requisitos Nao Funcionais
- RNF-01: Interface simples e intuitiva (nivel iniciante).
- RNF-02: Responsividade para celular e telas maiores.
- RNF-03: Codigo organizado em `models`, `providers`, `screens` e `widgets`.

## 5. Regras de Negocio
- RN-01: Habito so pode estar em uma lista por vez.
- RN-02: Concluir habito aumenta pontuacao ecologica.
- RN-03: Progresso semanal = (concluidos / total) * 100.

## 6. Rastreabilidade
- Home: `lib/screens/welcome_screen.dart`
- Navegacao principal: `lib/screens/home_screen.dart`
- Habitos: `lib/screens/habits_screen.dart`
- Dashboard: `lib/screens/dashboard_screen.dart`
- Estado global: `lib/providers/eco_track_provider.dart`

## 7. Validacao
- `flutter analyze`: sem erros.
- `flutter test`: aprovado.

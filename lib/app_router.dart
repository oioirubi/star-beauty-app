import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/screens/treinamento/treinamento.dart';

import 'components/base_tela.dart';
import '/screens/home_screen.dart';

import 'screens/usuario/user_home.dart';
import 'screens/usuario/login_screen.dart';
import 'screens/usuario/signup_screen.dart';

import 'screens/busca_e_match/busca_e_match.dart';
import 'screens/busca_e_match/match_listagem.dart';

import 'screens/entretenimento/entretenimento.dart';
import 'screens/entretenimento/classificados.dart';
import 'screens/entretenimento/news.dart';
import 'screens/entretenimento/tv_star_beauty.dart';

import 'screens/gps_da_beleza/gps_da_beleza.dart';
import 'screens/gps_da_beleza/swot_analysis_screen.dart';
import 'screens/gps_da_beleza/painel_de_objetivos.dart';
import 'screens/gps_da_beleza/relatorio_mensal.dart';
import 'screens/gps_da_beleza/plano_de_acao.dart';
import 'screens/gps_da_beleza/modelo_de_negocio.dart';

import 'screens/treinamento/meu_aprendizado.dart';
import 'screens/treinamento/starflix.dart';
import 'screens/treinamento/videos_recentes.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BaseScreen(
          userType: '', // Passe valores fixos ou dinâmicos conforme necessário
          userId: '',
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/user/:userId',
          builder: (context, state) {
            // Captura o parâmetro userId da URL
            final userId = state.pathParameters['userId']!;
            return UserHome(
              userType: 'professional',
              userId: userId,
            );
          },
        ),
        GoRoute(
          path: '/user_home',
          builder: (context, state) => const UserHome(
            userType: '',
            userId: '',
          ),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupScreen(),
        ),

        // Rotas de "Busca e Match"
        GoRoute(
          path: '/busca_e_match',
          builder: (context, state) => const MatchScreen(userType: 'UserType'),
        ),
        GoRoute(
          path: '/listagem',
          builder: (context, state) => const MatchListagem(
            userType: '',
          ),
        ),

        // Rotas de "Entretenimento"
        GoRoute(
          path: '/entretenimento',
          builder: (context, state) => const Entretenimento(
            userType: '',
          ),
        ),
        GoRoute(
          path: '/classificados',
          builder: (context, state) =>
              const Classificados(userType: 'UserType'),
        ),
        GoRoute(
          path: '/news',
          builder: (context, state) => const News(userType: 'UserType'),
        ),
        GoRoute(
          path: '/tv_star_beauty',
          builder: (context, state) => const TvStarBeauty(userType: 'UserType'),
        ),

        // Rotas de "GPS da Beleza"
        GoRoute(
          path: '/gps_da_beleza',
          builder: (context, state) => const GpsDaBeleza(
            userType: '',
          ),
        ),
        GoRoute(
          path: '/analiseswot',
          builder: (context, state) => const SWOTAnalysisScreen(),
        ),
        GoRoute(
          path: '/painel_de_objetivos',
          builder: (context, state) =>
              const ObjectivesPanel(userType: 'UserType'),
        ),
        GoRoute(
          path: '/relatorio_mensal',
          builder: (context, state) =>
              const MonthlyReportScreen(userType: 'UserType'),
        ),
        GoRoute(
          path: '/plano_de_acao',
          builder: (context, state) =>
              const ActionPlanScreen(userType: 'UserType'),
        ),
        GoRoute(
          path: '/modelo_de_negocio',
          builder: (context, state) =>
              const ModeloDeNegocio(userType: 'UserType'),
        ),

        // Rotas de "Treinamento"
        GoRoute(
          path: '/treinamento',
          builder: (context, state) => const Treinamento(),
        ),
        GoRoute(
          path: '/starflix',
          builder: (context, state) => const Starflix(userType: 'UserType'),
        ),
        GoRoute(
          path: '/meu_aprendizado',
          builder: (context, state) => const MeuAprendizado(
            userType: '',
          ),
        ),
        GoRoute(
          path: '/videos_recentes',
          builder: (context, state) => const VideosRecentes(
            userType: '',
          ),
        ),

        // Rota para capturar erros
        GoRoute(
          path: '*',
          builder: (context, state) => const ErrorScreen(
            message: 'Página não encontrada',
            userType: '',
          ),
        ),
      ],
    ),
  ],
);

class ErrorScreen extends StatelessWidget {
  final String message;
  final String userType;

  const ErrorScreen({super.key, required this.message, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erro')),
      body: Center(
        child: Text(message, style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}

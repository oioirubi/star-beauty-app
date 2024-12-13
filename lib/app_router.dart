import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_beauty_app/components/categorias_page.dart';
import 'package:star_beauty_app/components/category_model.dart';
import 'package:star_beauty_app/global_state/firebase_auth_notifier.dart';
import 'package:star_beauty_app/screens/busca_e_match/match_cadastro.dart';
import 'package:star_beauty_app/screens/busca_e_match/meus_maths.dart';
import 'package:star_beauty_app/screens/error_screen.dart';
import 'package:star_beauty_app/screens/treinamento/treinamento.dart';
import 'package:star_beauty_app/screens/usuario/perfil_usuario.dart';

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

GoRouter createRouter(BuildContext context) {
  final authNotifier =
      Provider.of<FirebaseAuthNotifier>(context, listen: false);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      ShellRoute(
          builder: (context, state, child) => BaseScreen(
                userType:
                    authNotifier.currentUser != null ? 'Professional' : 'Guest',
                userId: authNotifier.currentUser?.uid ?? '',
                child: child,
              ),
          routes: [
            GoRoute(
              path: '/user_home',
              builder: (context, state) => UserHome(
                userId: authNotifier.currentUser?.uid ?? '',
                userType: 'defaultType',
                title: '',
                description: '',
                categories: const [],
              ),
            ),
            GoRoute(
              path: '/categorias_page',
              builder: (context, state) {
                final List<CategoryModel> categories =
                    (state.extra as List<dynamic>?)
                            ?.map((item) => item as CategoryModel)
                            .toList() ??
                        [];

                return CategoriasPage(
                  title: state.uri.queryParameters['title'] ?? '',
                  description: state.uri.queryParameters['description'] ?? '',
                  categories: categories,
                );
              },
            ),

            // Rotas de "Busca e Match"
            GoRoute(
              path: '/busca_e_match',
              builder: (context, state) {
                // Verifica e converte a lista de categorias para o tipo correto
                final List<CategoryModel> categories =
                    (state.extra as List<dynamic>?)
                            ?.map((item) => item as CategoryModel)
                            .toList() ??
                        [];

                return BuscaEMatch(
                  title: state.uri.queryParameters['title'] ?? '',
                  description: state.uri.queryParameters['description'] ?? '',
                  categories: categories,
                );
              },
            ),
            GoRoute(
              path: '/listagem',
              builder: (context, state) => const MatchListagem(
                userType: '',
              ),
            ),
            GoRoute(
              path: '/meus_matchs',
              builder: (context, state) =>
                  const MeusMaths(userType: 'UserType'),
            ),
            GoRoute(
              path: '/match_cadastro',
              builder: (context, state) => const MatchCadastro(),
            ),

            // Rotas de "Entretenimento"
            GoRoute(
              path: '/entretenimento',
              builder: (context, state) {
                // Verifica e converte a lista de categorias para o tipo correto
                final List<CategoryModel> categories =
                    (state.extra as List<dynamic>?)
                            ?.map((item) => item as CategoryModel)
                            .toList() ??
                        [];

                return Entretenimento(
                  title: state.uri.queryParameters['title'] ?? '',
                  description: state.uri.queryParameters['description'] ?? '',
                  categories: categories,
                );
              },
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
              builder: (context, state) =>
                  const TvStarBeauty(userType: 'UserType'),
            ),

            // Rotas de "GPS da Beleza"
            GoRoute(
              path: '/gps_da_beleza',
              builder: (context, state) {
                // Verifica e converte a lista de categorias para o tipo correto
                final List<CategoryModel> categories =
                    (state.extra as List<dynamic>?)
                            ?.map((item) => item as CategoryModel)
                            .toList() ??
                        [];

                return GpsDaBeleza(
                  title: state.uri.queryParameters['title'] ?? '',
                  description: state.uri.queryParameters['description'] ?? '',
                  categories: categories,
                  userType: '',
                );
              },
            ),
            GoRoute(
              path: '/analise_swot',
              builder: (context, state) =>
                  const AnaliseSWOT(userType: 'UserType'),
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
              builder: (context, state) {
                // Verifica e converte a lista de categorias para o tipo correto
                final List<CategoryModel> categories =
                    (state.extra as List<dynamic>?)
                            ?.map((item) => item as CategoryModel)
                            .toList() ??
                        [];

                return Treinamento(
                  title: state.uri.queryParameters['title'] ?? '',
                  description: state.uri.queryParameters['description'] ?? '',
                  categories: categories,
                );
              },
            ),
            GoRoute(
              path: '/starflix',
              builder: (context, state) => const Starflix(),
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
          ]),
      GoRoute(
        path: '/perfil_usuario',
        builder: (context, state) => const UserProfilePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '*',
        builder: (context, state) => const ErrorScreen(
          message: 'Página não encontrada',
          userType: '',
        ),
      ),
    ],
    redirect: (context, state) {
      // Garante que o estado do FirebaseAuthNotifier está carregado
      if (authNotifier.isLoading) return null;

      final loggedIn = authNotifier.currentUser != null;
      final isOnAuthPage = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      // Redireciona usuários não logados para a página de login
      if (!loggedIn && !isOnAuthPage) {
        return '/login';
      }

      // Redireciona usuários logados para a home, evitando que voltem para login/signup
      if (loggedIn && isOnAuthPage) {
        return '/user_home';
      }

      return null; // Sem redirecionamento
    },
  );
}

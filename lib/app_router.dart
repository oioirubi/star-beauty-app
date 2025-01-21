import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_beauty_app/components/custom_base_screen.dart';
import 'package:star_beauty_app/global_state/firebase_auth_notifier.dart';

import 'package:star_beauty_app/screens/busca_e_match/meus_maths.dart';
import 'package:star_beauty_app/screens/error_screen.dart';
import 'package:star_beauty_app/screens/treinamento/course_screen.dart';
import 'package:star_beauty_app/screens/treinamento/video_screen.dart';
import 'package:star_beauty_app/screens/usuario/perfil_usuario.dart';

import '/screens/home_screen.dart';

import 'screens/usuario/user_home.dart';
import 'screens/usuario/login_screen.dart';
import 'screens/usuario/signup_screen.dart';

import 'screens/busca_e_match/match_listagem.dart';

import 'screens/entretenimento/classificados.dart';
import 'screens/entretenimento/news.dart';
import 'screens/entretenimento/tv_star_beauty.dart';

import 'screens/gps_da_beleza/gps_da_beleza.dart';
import 'screens/gps_da_beleza/swot_analysis_page.dart';
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
          builder: (context, state, child) {
            final currentUser = FirebaseAuth.instance.currentUser;

            // Se o usuário não está logado, exiba algo ou um erro
            if (currentUser == null) {
              return const Center(child: Text("Usuário não autenticado"));
            }

            // Use FutureBuilder para carregar os dados do Firestore
            return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                      child: Text("Erro ao carregar dados do usuário"));
                }

                // Pegue os dados do Firestore
                final userData = snapshot.data?.data() ?? {};
                final name =
                    userData['name'] ?? currentUser.displayName ?? "Usuário";
                final profilePicture =
                    userData['profilePicture'] ?? currentUser.photoURL;

                // Debug prints
                print('userName: $name');
                print('userPhotoUrl: $profilePicture');

                // Retorne a CustomizableBaseScreen
                return CustomizableBaseScreen(
                  userName: name,
                  userPhotoUrl: profilePicture,
                  child: child,
                );
              },
            );
          },
          routes: [
            GoRoute(
              path: '/user_home',
              builder: (context, state) {
                return const UserHome();
              },
            ),

            GoRoute(
              path: '/perfil_usuario',
              builder: (context, state) => const UserProfilePage(),
            ),

            GoRoute(
              path: '/categorias_page',
              builder: (context, state) =>
                  const MeusMaths(userType: 'UserType'),
            ),
            // Rotas de "Busca e Match"
            GoRoute(
              path: '/busca_e_match',
              builder: (context, state) =>
                  const MeusMaths(userType: 'UserType'),
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

            // Rotas de "Entretenimento"
            GoRoute(
              path: '/entretenimento',
              builder: (context, state) =>
                  const MeusMaths(userType: 'UserType'),
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
              builder: (context, state) => const GpsDaBeleza(),
            ),
            GoRoute(
              path: '/analise_swot',
              builder: (context, state) => const SwotAnalysisPage(),
            ),

            GoRoute(
              path: '/painel_de_objetivos',
              builder: (context, state) =>
                  const ObjectivesPanel(userType: 'UserType'),
            ),
            GoRoute(
              path: '/relatorio_mensal',
              builder: (context, state) => const MonthlyReportScreen(),
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
            GoRoute(
              path: '/course_screen',
              builder: (context, state) => const CourseScreen(
                courseName: "courseName",
                courseDescription: "courseDescription",
                expiryDate: "expiryDate",
                lessons: [
                  LessonItem(
                      title: "hello world",
                      duration: "2h30min",
                      isCompleted: false,
                      classURL:
                          'https://www.dropbox.com/scl/fi/cqiuzy9kk344rrst8w0k3/2025-01-15-16-36-24.mp4?rlkey=nulo63qda68jrzmek1ojepgnk&st=o0g92cdd&dl=1'),
                  LessonItem(
                      title: "hello world",
                      duration: "2h30min",
                      isCompleted: false,
                      classURL:
                          'https://www.dropbox.com/scl/fi/cqiuzy9kk344rrst8w0k3/2025-01-15-16-36-24.mp4?rlkey=nulo63qda68jrzmek1ojepgnk&st=o0g92cdd&dl=1'),
                  LessonItem(
                      title: "hello world",
                      duration: "2h30min",
                      isCompleted: false,
                      classURL:
                          'https://www.dropbox.com/scl/fi/cqiuzy9kk344rrst8w0k3/2025-01-15-16-36-24.mp4?rlkey=nulo63qda68jrzmek1ojepgnk&st=o0g92cdd&dl=1'),
                  LessonItem(
                      title: "hello world",
                      duration: "2h30min",
                      isCompleted: false,
                      classURL:
                          "https://morris91.oceansaver.in/pacific/?lFty4gp9ycSRJRCQTm342Gi"),
                ],
                progress: 0.5,
              ),
            ),
            GoRoute(
                path: '/video_screen',
                builder: (ctx, st) => const VideoScreen()),
            // Rotas de "Treinamento"
            GoRoute(
              path: '/treinamento',
              builder: (context, state) =>
                  const MeusMaths(userType: 'UserType'),
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

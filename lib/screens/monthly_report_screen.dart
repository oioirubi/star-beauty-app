import 'package:flutter/material.dart';

class MonthlyReportScreen extends StatelessWidget {
  const MonthlyReportScreen({Key? key, required String userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12, // Número de meses
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Relatório Mensal'),
          bottom: const TabBar(
            isScrollable: true, // Permite rolar se o espaço não for suficiente
            tabs: [
              Tab(text: 'Janeiro'),
              Tab(text: 'Fevereiro'),
              Tab(text: 'Março'),
              Tab(text: 'Abril'),
              Tab(text: 'Maio'),
              Tab(text: 'Junho'),
              Tab(text: 'Julho'),
              Tab(text: 'Agosto'),
              Tab(text: 'Setembro'),
              Tab(text: 'Outubro'),
              Tab(text: 'Novembro'),
              Tab(text: 'Dezembro'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMonthlyReport('Janeiro'),
            _buildMonthlyReport('Fevereiro'),
            _buildMonthlyReport('Março'),
            _buildMonthlyReport('Abril'),
            _buildMonthlyReport('Maio'),
            _buildMonthlyReport('Junho'),
            _buildMonthlyReport('Julho'),
            _buildMonthlyReport('Agosto'),
            _buildMonthlyReport('Setembro'),
            _buildMonthlyReport('Outubro'),
            _buildMonthlyReport('Novembro'),
            _buildMonthlyReport('Dezembro'),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyReport(String month) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Faturamento - $month'),
          _buildDataCard('Total: R\$ 12.000'),
          _buildDataCard('Cabelo: R\$ 5.000'),
          _buildDataCard('Manicure: R\$ 3.000'),
          _buildDataCard('Estética: R\$ 2.000'),
          _buildDataCard('Maquiagem: R\$ 1.000'),
          _buildDataCard('Depilação: R\$ 1.000'),
          const SizedBox(height: 16),
          _buildSectionTitle('Quantidade de Serviços Realizados - $month'),
          _buildDataCard('Total: 150'),
          _buildDataCard('Cabelo: 50'),
          _buildDataCard('Manicure: 40'),
          _buildDataCard('Estética: 30'),
          _buildDataCard('Maquiagem: 20'),
          _buildDataCard('Depilação: 10'),
          const SizedBox(height: 16),
          _buildSectionTitle('Despesas - $month'),
          _buildDataCard('Fixas: R\$ 3.000'),
          _buildDataCard('Variáveis: R\$ 2.000'),
          const SizedBox(height: 16),
          _buildSectionTitle('Resultado - $month'),
          _buildDataCard('Lucratividade: R\$ 7.000'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDataCard(String data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(data),
      ),
    );
  }
}

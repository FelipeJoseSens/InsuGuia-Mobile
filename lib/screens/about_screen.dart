import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Projeto'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Cabeçalho
          Center(
            child: Column(
              children: [
                Icon(Icons.local_hospital, size: 64, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 16),
                Text(
                  'InsuGuia Mobile',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Versão 1.0.0 (Protótipo Acadêmico)',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(height: 32),

          // Aviso Importante
          _buildSection(
            context,
            title: '⚠️ Aviso Legal',
            content: 'Este aplicativo é um Produto Mínimo Viável (MVP) desenvolvido para fins estritamente acadêmicos. '
                'Ele NÃO possui validação clínica oficial e NÃO deve ser utilizado como única fonte para tomada de decisão médica. '
                'Sempre consulte o protocolo institucional.',
            icon: Icons.warning_amber,
            iconColor: Colors.orange,
          ),

          // Quem desenvolveu
          _buildSection(
            context,
            title: 'Desenvolvimento',
            content: 'Projeto de Extensão do Curso de Sistemas de Informação (T28) da Unidavi.\n\n'
                'Desenvolvido em parceria com a demanda apresentada pelo Dr. Itairan da Silva Terres sobre manejo da hiperglicemia hospitalar.',
            icon: Icons.code,
          ),

          // Como funciona o cálculo
          _buildSection(
            context,
            title: 'Protocolo de Cálculo',
            content: 'O algoritmo baseia-se nas diretrizes para pacientes internados não-críticos:\n\n'
                '• TDD (Dose Total Diária): 0.5 UI/kg\n'
                '• Basal (NPH): 0.2 UI/kg (aplicada às 22h)\n'
                '• Fator de Sensibilidade: Regra dos 1500 (1500 ÷ TDD)\n'
                '• Meta Glicêmica: 140 mg/dL',
            icon: Icons.calculate,
          ),

          // Arredondamento
          _buildSection(
            context,
            title: 'Segurança e Arredondamento',
            content: 'Para garantir a segurança na administração e compatibilidade com seringas hospitalares padrão (escala de 1 em 1 UI):\n\n'
                'Todas as doses calculadas são arredondadas matematicamente para o número INTEIRO mais próximo.\n\n'
                'Exemplo: Uma dose calculada de 4.3 UI será exibida como 4 UI. Uma dose de 4.7 UI será exibida como 5 UI.',
            icon: Icons.verified_user,
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.secondary, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
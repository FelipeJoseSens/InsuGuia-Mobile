import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/hash_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _secretController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _showReset = false;
  String? _errorMessage;

  Future<void> _checkSecret() async {
    setState(() { _errorMessage = null; });
    final prefs = await SharedPreferences.getInstance();
    final email = _emailController.text.trim();
    final storedSecret = prefs.getString('secret_$email');
    if (storedSecret == null) {
      setState(() { _errorMessage = 'Usuário não encontrado.'; });
      return;
    }
    if (_secretController.text.trim() == storedSecret) {
      setState(() { _showReset = true; });
    } else {
      setState(() { _errorMessage = 'Resposta incorreta.'; });
    }
  }

  Future<void> _resetPassword() async {
    setState(() { _errorMessage = null; });
    final prefs = await SharedPreferences.getInstance();
    final email = _emailController.text.trim();
    final newPasswordHash = HashUtils.hashPassword(_newPasswordController.text);
    await prefs.setString('user_$email', newPasswordHash);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redefinir Senha')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              enabled: !_showReset,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _secretController,
              decoration: const InputDecoration(labelText: 'Pergunta secreta: Nome do seu primeiro animal de estimação?'),
              enabled: !_showReset,
            ),
            if (_showReset) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'Nova senha'),
                obscureText: true,
              ),
            ],
            const SizedBox(height: 24),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showReset ? _resetPassword : _checkSecret,
                child: Text(_showReset ? 'Redefinir Senha' : 'Verificar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

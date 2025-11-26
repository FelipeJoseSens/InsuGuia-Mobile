import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/hash_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _secretController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _secretController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Preencha todos os campos';
        _isLoading = false;
      });
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final email = _emailController.text.trim();
    final passwordHash = HashUtils.hashPassword(_passwordController.text);
    final secret = _secretController.text.trim();
    // Verifica se já existe usuário com esse e-mail
    if (prefs.containsKey('user_$email')) {
      setState(() {
        _errorMessage = 'E-mail já cadastrado';
        _isLoading = false;
      });
      return;
    }
    // Salva usuário
    await prefs.setString('user_$email', passwordHash);
    await prefs.setString('secret_$email', secret);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _secretController,
              decoration: const InputDecoration(labelText: 'Pergunta secreta: Nome do seu primeiro animal de estimação?'),
            ),
            const SizedBox(height: 24),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Cadastrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

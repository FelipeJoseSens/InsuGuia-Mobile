# 🩺 InsuGuia Mobile

Aplicativo Flutter desenvolvido na disciplina **Desenvolvimento para Plataformas Móveis (UNIDAVI)**.

## 👥 Equipe
- Felipe José Sens
- William Mateus Weber

**Orientação Clínica**: Dr. Itairan da Silva Terres

## 🎯 Objetivo
Aplicativo de apoio à prescrição de insulina hospitalar, com base nas diretrizes da Sociedade Brasileira de Diabetes.

## ⚙️ Tecnologias
- Flutter / Dart
- Git (versionamento)
- Visual Studio Code
- Android Studio (emulador)

## 📋 Pré-requisitos
- Flutter SDK instalado e configurado
- Android Studio ou dispositivo físico para teste
- Git (opcional, para versionamento)
- Visual Studio Code (recomendado)

## 🚀 Rodar o projeto
No PowerShell (Windows):

```powershell
# Clone o repositório (opcional)
git clone https://github.com/FelipeJoseSens/InsuGuia-Mobile.git

# Entre na pasta do projeto
cd "c:\Users\felip\Desktop\Desenvolvimento Mobile\InsuGuia\InsuGuia-Mobile"

# Instale as dependências
flutter pub get

# Verifique o código
flutter analyze

# Execute os testes
flutter test

# Rode o app
flutter run
```

### 🧪 Testes
O projeto inclui testes unitários e de widget. Para executar:

```powershell
# Todos os testes
flutter test

# Apenas testes do serviço de prescrição
flutter test test/prescription_service_test.dart
```

### 📱 Como usar
1. Inicie o app
2. Clique em "Cadastrar Paciente"
3. Preencha os dados (nome, idade e peso são obrigatórios)
4. Clique em "Salvar e Gerar Prescrição"
5. Visualize a prescrição sugerida
6. Opcional: clique em "Acompanhamento diário" para simular registros

> **Nota**: O acompanhamento é simulado e os dados são mantidos apenas em memória durante a execução.

---

## Sobre esta entrega (protótipo acadêmico)

Este repositório contém um protótipo acadêmico chamado *InsuGuia Mobile* que implementa o cenário "Paciente Não Crítico" para suporte à prescrição de insulina.

> AVISO: Este protótipo é educacional e NÃO possui validade clínica. Não use para decisões médicas. Valide todas as regras com profissionais de saúde antes de qualquer uso clínico.

### Funcionalidades implementadas nesta versão
- Cadastro de paciente: nome, sexo, idade, peso, altura, creatinina, local de internação.
- Geração de prescrição sugerida (regra acadêmica): dieta, monitorização, insulina basal (UI/dia), insulina de ação rápida e orientações para hipoglicemia.
- Acompanhamento diário (simulado): inserir glicemias e receber sugestão de correção (armazenamento em memória durante a execução).
- Documentação inicial em `docs/requirements.md` e `docs/design.md`.
- Testes unitários para `PrescriptionService`.

### Estrutura importante
- `lib/models/patient.dart` — modelo Patient atualizado.
- `lib/services/prescription_service.dart` — lógica de prescrição (protótipo acadêmico).
- `lib/screen/patient_form_screen.dart` — formulário de cadastro ampliado.
- `lib/screen/prescription_screen.dart` — exibe prescrição sugerida.
- `lib/screen/monitoring_screen.dart` — acompanhamento diário simulado.

### 📈 Próximos passos
1. **Melhorias técnicas**
   - Persistência dos registros (SQLite/SharedPreferences)
   - APK de demonstração
   - Mais testes de integração

2. **Expansão clínica**
   - Validação das regras com especialista
   - Implementação de cenário crítico
   - Integração com prontuário (futuro)

3. **Documentação**
   - Manual do usuário detalhado
   - Vídeo de demonstração
   - Documentação API

## 📄 Licença
Este é um protótipo acadêmico. Consulte a documentação em `docs/` para mais informações sobre uso e limitações.

## 📧 Contato
Para dúvidas ou sugestões, entre em contato com a equipe de desenvolvimento.

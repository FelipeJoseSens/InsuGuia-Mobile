# InsuGuia Mobile

Aplicativo móvel desenvolvido em Flutter para auxiliar na prescrição de insulina para pacientes hospitalizados no cenário 'Paciente Não Crítico'.

## Características

- **Material Design 3**: Interface moderna e intuitiva
- **Gerenciamento de Pacientes**: Cadastro e listagem de pacientes
- **Prescrição Automatizada**: Cálculo automático de doses de insulina (basal e correção)
- **Acompanhamento Diário**: Registro de glicemias e sugestões de correção em tempo real
- **Persistência Local**: Dados salvos localmente usando SharedPreferences

## Tecnologias

- Flutter SDK 3.0+
- Material 3
- SharedPreferences para persistência de dados
- UUID para geração de IDs únicos
- Intl para formatação de datas

## Estrutura do Projeto

```
lib/
├── models/
│   ├── patient.dart
│   └── prescription_result.dart
├── services/
│   ├── patient_service.dart
│   └── prescription_service.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── patient_form_screen.dart
│   ├── prescription_screen.dart
│   └── monitoring_screen.dart
└── main.dart
```

## Fluxo de Telas

1. **SplashScreen**: Tela inicial com loading
2. **HomeScreen**: Lista de pacientes salvos
3. **PatientFormScreen**: Formulário para cadastro de novos pacientes
4. **PrescriptionScreen**: Exibe o plano terapêutico calculado
5. **MonitoringScreen**: Acompanhamento diário com registro de glicemias

## Lógica de Cálculo

### Doses de Insulina

- **TDD (Dose Diária Total)**: Peso × 0.5 UI/kg
- **Dose Basal (NPH)**: Peso × 0.2 UI/kg (aplicada às 22:00)
- **Fator de Correção**: 1500 ÷ TDD
- **Glicemia Alvo**: 140 mg/dL

### Correção

Quando glicemia > 140 mg/dL:
- Dose de Correção = (Glicemia Atual - 140) ÷ Fator de Correção

## Como Executar

```bash
# Instalar dependências
flutter pub get

# Executar no emulador/dispositivo
flutter run

# Build para produção
flutter build apk
```

## Aviso Importante

**Este é um protótipo acadêmico sem validade clínica.** Não deve ser utilizado para prescrições médicas reais.

## Licença

Projeto acadêmico - Todos os direitos reservados

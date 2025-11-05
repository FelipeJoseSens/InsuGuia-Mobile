# Relatório de Desenvolvimento - InsuGuia Mobile

## Visão Geral do Projeto
**Data**: 4 de Novembro de 2025  
**Equipe**: Felipe José Sens, William Mateus Weber  
**Status**: Protótipo Funcional  

## 1. Contextualização

### 1.1 Objetivo do Projeto
Desenvolvimento de um protótipo acadêmico em Flutter para apoio à prescrição de insulina em pacientes hospitalizados, com foco no cenário "Paciente Não Crítico", atendendo demanda do Dr. Itairan da Silva Terres.

### 1.2 Escopo Implementado
- Cadastro completo de paciente
- Geração de prescrição baseada em regras acadêmicas
- Acompanhamento diário simulado
- Documentação técnica e clínica

## 2. Desenvolvimento e Implementação

### 2.1 Arquitetura
- **Padrão MVC modificado**
  - Models: `Patient`
  - Services: `PrescriptionService`
  - Screens: Formulário, Prescrição, Acompanhamento
  - Widgets: Componentes reutilizáveis

### 2.2 Funcionalidades Implementadas
1. **Cadastro de Paciente**
   - Campos obrigatórios: nome, idade, peso
   - Campos opcionais: altura, creatinina, sexo, local
   - Validações em tempo real
   
2. **Cálculo de Prescrição**
   - Insulina basal: 0.2 UI/kg/dia
   - TDD educacional: 0.5 UI/kg/dia
   - Fator de correção: 1500/TDD
   - Alvo glicêmico: 140 mg/dL

3. **Acompanhamento Diário**
   - Registro de glicemias
   - Sugestão de correção automática
   - Armazenamento em memória (simulado)

## 3. Testes e Validação

### 3.1 Testes Implementados
1. **Testes Unitários**
   - `PrescriptionService`: cálculo basal e correção
   - Cobertura de casos principais

2. **Testes de Widget**
   - Navegação básica
   - Formulários e validações

### 3.2 Análise Estática
- Flutter Analyzer: sem erros críticos
- Lint rules: conformidade com padrões

### 3.3 Depuração
- Logs implementados em pontos críticos
- Tratamento de erros em campos numéricos
- Validação de formulários

## 4. Documentação

### 4.1 Documentação Técnica
- `README.md`: instruções de execução
- `requirements.md`: requisitos e escopo
- `design.md`: arquitetura e regras

### 4.2 Documentação Clínica
- Disclaimer de uso acadêmico
- Regras de cálculo documentadas
- Orientações de hipoglicemia

## 5. Feedback e Melhorias

### 5.1 Melhorias Implementadas
- Interface mais intuitiva
- Validações em tempo real
- Navegação simplificada
- Cálculos documentados

### 5.2 Pontos de Atenção
- Armazenamento temporário (em memória)
- Necessidade de validação clínica
- Limitação ao cenário não crítico

### 5.3 Próximas Iterações Sugeridas
1. Persistência de dados
   - Implementar SharedPreferences
   - Backup local de registros

2. Expansão clínica
   - Incluir cenário crítico
   - Validar regras com especialista

3. Melhorias técnicas
   - Aumentar cobertura de testes
   - Gerar APK de demonstração
   - Documentação API

## 6. Métricas e Indicadores

### 6.1 Qualidade de Código
- Testes: 100% passando
- Análise estática: sem erros críticos
- Documentação: completa

### 6.2 Usabilidade
- Fluxo linear e intuitivo
- Feedback visual em ações
- Mensagens claras de erro

## 7. Conclusão e Recomendações

### 7.1 Estado Atual
O protótipo atende aos requisitos iniciais, implementando as funcionalidades essenciais com foco na segurança e usabilidade.

### 7.2 Recomendações
1. **Curto Prazo**
   - Implementar persistência
   - Gerar APK de demonstração
   - Expandir testes

2. **Médio Prazo**
   - Validar regras clínicas
   - Adicionar cenários
   - Melhorar UX/UI

3. **Longo Prazo**
   - Integração com prontuário
   - Expansão para outros cenários
   - Validação multicêntrica

## 8. Anexos

### 8.1 Comandos para Execução
```powershell
# Instalar e executar
flutter pub get
flutter run

# Testar
flutter test

# Analisar código
flutter analyze
```

### 8.2 Estrutura do Projeto
```
lib/
  ├── models/
  │   └── patient.dart
  ├── services/
  │   └── prescription_service.dart
  ├── screen/
  │   ├── home_screen.dart
  │   ├── patient_form_screen.dart
  │   ├── prescription_screen.dart
  │   └── monitoring_screen.dart
  └── widgets/
      └── custom_button.dart
```

### 8.3 Equipe e Contatos
- Desenvolvimento: Felipe José Sens, William Mateus Weber
- Orientação Clínica: Dr. Itairan da Silva Terres
- Instituição: UNIDAVI

---
Documento gerado em 4 de Novembro de 2025
Versão do Relatório: 1.0
# Apresentação InsuGuia Mobile
## Protótipo Acadêmico - UNIDAVI

---

## Contexto
- Demanda da área de saúde (Dr. Itairan)
- Apoio à prescrição de insulina hospitalar
- Foco: cenário "Paciente Não Crítico"
- Protótipo acadêmico em Flutter

---

## Objetivos Alcançados
1. Cadastro completo de pacientes
2. Cálculo de prescrição sugerida
3. Acompanhamento diário simulado
4. Documentação técnica e clínica
5. Testes unitários e validações

---

## Tecnologias e Arquitetura
- Flutter/Dart
- Arquitetura MVC simplificada
- Testes automatizados
- Documentação inline
- Controle de versão (Git)

---

## Fluxo Principal
1. Cadastro do paciente
   - Nome, idade, peso (obrigatórios)
   - Altura, creatinina, local (opcionais)

2. Prescrição gerada
   - Dieta e monitorização
   - Insulina basal calculada
   - Orientações de correção

3. Acompanhamento
   - Registro de glicemias
   - Sugestão de correção
   - Histórico da sessão

---

## Regras Implementadas (Acadêmicas)
- Basal: 0.2 UI/kg/dia
- TDD: 0.5 UI/kg/dia
- Fator correção: 1500/TDD
- Alvo: 140 mg/dL

> Observação: Regras simplificadas para fins educativos.
> Necessária validação clínica.

---

## Demo ao Vivo
1. Abrir o app
2. Cadastrar paciente exemplo
3. Ver prescrição gerada
4. Simular acompanhamento
5. Mostrar cálculos

---

## Próximos Passos
1. Curto prazo
   - Persistência de dados
   - APK de demonstração
   - Mais testes

2. Médio/longo prazo
   - Validação clínica
   - Cenário crítico
   - Integração prontuário

---

## Equipe e Contatos
- Felipe José Sens
- William Mateus Weber
- Dr. Itairan (orientação clínica)
- UNIDAVI (2025)
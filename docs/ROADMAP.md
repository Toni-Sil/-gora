# Roteiro de implementação

A especificação em [SDD.md](SDD.md) define requisitos e critérios de aceitação. Etapas ainda não concluídas estão desmarcadas.

- [x] Definir objetivo, identidade conversacional e direção visual.
- [x] Confirmar Windows, plataforma de execução e direção de áudio.
- [x] Aprovar escuta automática durante sessão ativa, após autorização.
- [x] Preparar referência visual demonstrativa e documentação no GitHub.
- [ ] E0: escolher stack, formato de execução, provedor de modelo e voz com avaliação de custo e compatibilidade.
- [ ] E1: separar interface, coordenador de sessão, contratos e adaptadores; entregar execução local documentada e demonstração sem credenciais.
- [ ] E2: integrar diálogo real, cancelamento, histórico persistente e memória manual.
- [ ] E3: validar voz contínua, fim de fala, interrupção pela voz e eco em Windows.
- [ ] E4: memória seletiva revisável, mapa intelectual e aprendizagem linguística contextual.
- [ ] E5: fontes verificáveis e demais evoluções aprovadas.

## Primeira tarefa para desenvolvimento

Ler SDD e AGENTS.md, inventariar o protótipo e propor uma stack compatível com Windows 10 x64. Implementar E1 sem contratar serviços, sem capturar áudio fora da sessão e sem apresentar exemplos fixos como respostas reais. A referência atual é um HTML de demonstração, não uma base modular pronta.

## Questões ainda abertas

Formato instalado ou navegador local; comportamento ao minimizar; iniciativa durante silêncio; timbre de voz; apresentação das correções; política automática de memórias; retenção de texto; fontes atuais; fornecedor final e ferramenta de desenvolvimento.

## Verificação de entrega

Registrar instruções reproduzíveis, testes executados e limitações. Validar no computador real com fone e depois com caixas de som. Sintaxe válida não comprova áudio, cancelamento ou naturalidade.

# Ágora — especificação técnica pública

Versão 0.4-public · 21/09/2026
Repositório: https://github.com/Toni-Sil/-gora
Estado: planejamento e referência demonstrativa; aplicativo completo ainda não implementado.

Esta versão descreve o produto e o trabalho de engenharia. Não contém perfil pessoal, configuração individual de computador, orçamento pessoal ou transcrições. Documentação interna não deve ser copiada para o repositório público sem revisão.

## 1. Produto

Interlocutora intelectual por voz, com diálogo natural e repertório em filosofia, política, existencialismo, ética, religião, teologia e história das ideias. Conversa é a experiência principal; explicações, crítica e orientação linguística entram quando úteis.

A aplicação tem uma única tela futurista, com fundo escuro, núcleo luminoso azul-ciano, controles essenciais e painéis laterais de transcrição, memória e ajustes. Ágora é o nome de trabalho. A inspiração visual não implica imitação de voz de ator nem capacidades de controle do computador.

## 2. Estado da implementação

O arquivo prototype/agora.html contém respostas preparadas, tentativa de saudação com síntese de voz do navegador, ditado por turno quando disponível, texto alternativo, histórico no navegador e memória manual com exportação. Não há modelo real conectado, diálogo contínuo validado, memória automática, banco próprio ou instalador.

A sintaxe do JavaScript foi verificada anteriormente. Áudio, microfone, interface no Windows e naturalidade precisam de testes reais. O núcleo visual representa estados, não volume medido.

## 3. Direção de arquitetura

Plataforma inicial: Windows x64. Interface, configuração e persistência locais; processamento remoto de modelo inicialmente, sem exigir GPU. Modelo local é evolução possível por adaptador.

Linguagem, framework, empacotamento, fornecedor e estratégia de voz ainda estão abertos. Comparar transcrição + modelo textual + síntese com serviço integrado de voz em tempo real. Escolher após testes de português, compatibilidade, custo e latência. A carcaça deve rodar em demonstração sem credenciais.

## 4. Requisitos de experiência

- RF01: uma única janela, com painéis na mesma tela.
- RF02: saudação breve ao abrir, com alternativa manual quando a reprodução automática não for possível.
- RF03: após autorização inicial, permitir escuta automática na sessão ativa; indicar captura e oferecer pausa real.
- RF04: captura desligada fora da sessão; comportamento ao minimizar ainda pendente.
- RF05: texto utilizável mesmo sem permissão de microfone ou sem saída de áudio.
- RF06: estados reais de inicialização, prontidão, escuta, processamento, fala, pausa e falha.
- RF07: transcrição parcial distinguível da final e respostas progressivas.
- RF08: interrupção por botão na primeira integração; interrupção pela voz no MVP de voz contínua.
- RF09: detecção de fim de fala e prevenção de resposta ao próprio áudio.
- RF10: histórico local, sessões e retomada sem duplicação de mensagens.
- RF11: memória manual editável, removível e exportável; extração automática em etapa posterior.
- RF12: ajuste de voz, velocidade, volume, correções e animações.
- RF13: erros úteis para rede, credencial, áudio e limite de consumo; preservar a entrada do usuário.
- RF14: demonstração sempre identificada; nunca apresentar exemplos fixos como respostas reais.

## 5. Personalidade e repertório

Voz conversacional serena, curiosa e direta. Respostas concisas por padrão, profundidade quando solicitada. Discordar com razões, reconhecer incertezas e não terminar toda resposta com uma pergunta. Evitar concordância automática e crítica compulsiva.

Distinguir relato, exploração de hipótese e argumento. Acompanhar mudanças de assunto. Não inventar consciência, experiências humanas ou crenças pessoais.

Em política e religião, avaliar argumentos sem presumir identidade do interlocutor. Distinguir fato, interpretação, tradição, fé e evidência. Não fabricar fontes, citações ou atualidade. Consulta à internet é extensão ainda não definida.

Correções linguísticas devem ser breves e contextuais. Não corrigir como erro do usuário um problema de transcrição; confirmar termos ambíguos. Respeitar registro coloquial compreensível. Frequência e apresentação por voz ou painel precisam de avaliação.

## 6. Componentes lógicos

| Módulo | Responsabilidade |
| --- | --- |
| ui | Núcleo, controles, painéis, teclado e redução de movimento. |
| core/session | Sessões, turnos e estados. |
| core/dialogue | Personalidade, seleção de contexto e orientação linguística. |
| adapters/model | Integração substituível, resposta progressiva e cancelamento. |
| adapters/audio | Captura, transcrição, síntese e reprodução. |
| core/turns | Fim de fala, interrupção, eventos atrasados e eco. |
| storage | Histórico, configuração, migrações e exportação. |
| memory | Origem, revisão, recuperação, edição e exclusão. |
| sources | Proveniência e referências, quando implementadas. |
| diagnostics | Tempos, erros e consumo sem segredos ou conteúdo pessoal por padrão. |

São separações de responsabilidade; não exigem microsserviços. A referência visual não deve continuar como um único arquivo crescente na aplicação final.

## 7. Contratos

Mensagem: ID, sessão, turno, papel, conteúdo, horário, origem texto/voz, estado parcial/final/interrompido/falha e modo demonstração/real.

Pedido ao modelo: ID de turno, contexto selecionado, memórias pertinentes, versão de personalidade, limites e sinal de cancelamento.

Evento: sessão, turno, sequência, tipo, conteúdo e horário. O coordenador rejeita eventos de turnos cancelados. Interromper para o áudio e cancela geração/reprodução pendentes. Não tratar texto não ouvido como necessariamente comunicado.

Memória: ID, categoria, texto, origem, data, estado de revisão. Operações: criar, aprovar, revisar, editar, excluir e exportar. Política de aprovação automática e retenção permanece aberta.

## 8. Estados

| Estado | Ação | Saída |
| --- | --- | --- |
| Iniciando | Carregar configuração e verificar recursos. | Pronta ou falha. |
| Pronta | Receber entrada autorizada. | Ouvindo ou processando. |
| Ouvindo | Transcrever e detectar fim. | Processando ou pausa. |
| Processando | Gerar com cancelamento disponível. | Falando ou falha. |
| Falando | Reproduzir e aceitar interrupção. | Ouvindo, pronta ou interrompida. |
| Interrompida | Invalidar eventos e áudio antigos. | Ouvindo ou pronta. |
| Pausada | Captura e reprodução desligadas. | Retomada explícita. |
| Falha | Explicar e preservar dados. | Nova tentativa ou texto. |

## 9. Memória e qualidade

Manter origem dos registros; separar posições confirmadas de hipóteses exploradas. Revisões substituem interpretações antigas na recuperação. Exclusão invalida resumos e índices relacionados, com distinção entre memória e mensagem original.

Não atribuir pontuação de inteligência nem rotular automaticamente crenças. Mapa intelectual é evolução, com relações contextualizadas entre temas, dúvidas e mudanças.

Segredos ficam fora da interface e do repositório. Serviço local deve restringir acesso à máquina e validar requisições. Não guardar gravações nem conteúdo pessoal em logs por padrão. Custos devem ser medidos, com limite configurável e margem para cobrança; limites locais não garantem o valor final cobrado por terceiros.

## 10. Entregas

| Etapa | Entrega | Aceite |
| --- | --- | --- |
| E0 | Seleção técnica documentada. | Compatibilidade, custo e estratégia de voz avaliados. |
| E1 | Carcaça modular demonstrativa. | Inicialização reproduzível no Windows, estados e painéis, sem chaves. |
| E2 | Diálogo real por texto e voz por turnos. | Modelo contextual, histórico, cancelamento e falhas recuperáveis. |
| E3 | Conversa contínua. | Pelo menos cinco turnos sem envio manual, interrupção por voz, pausa e tratamento de eco. |
| E4 | Memória inteligente e mapa. | Revisão, origem, exclusão efetiva e ausência de rótulos indevidos. |
| E5 | Fontes e expansão. | Apenas conforme prioridades aprovadas. |

E1 não equivale ao MVP final. Um botão de ditado não satisfaz conversa contínua.

## 11. Testes de aceitação

Validar no Windows: permissão negada, ausência de microfone, troca de saída, perda de rede, interrupção durante geração/reprodução, retorno de evento atrasado, persistência após reinício, exportação e exclusão. Testar fone e alto-falantes.

Avaliar naturalidade: relato breve recebe resposta proporcional; posição política recebe contraponto pertinente; dúvida religiosa não vira rótulo; mudança de assunto é acompanhada; correção não quebra a conversa. Registrar tempos até primeiro áudio e até interrupção, sem anunciar metas medidas antes dos testes.

## 12. Pendências

Formato instalado ou navegador local; stack; fornecedores; comportamento ao minimizar; iniciativa durante silêncio; timbre; apresentação de correções; aprovação e retenção de memórias; consulta a fontes; ferramenta de desenvolvimento e nome definitivo.

## 13. Execução pelo desenvolvedor

Ler AGENTS.md e ROADMAP.md. Começar por E1, preservar distinção demonstração/real, não contratar serviços automaticamente e não presumir decisões pendentes. Atualizar documentação e registrar testes efetivamente executados a cada entrega.

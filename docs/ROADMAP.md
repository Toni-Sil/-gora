# Roteiro de implementação

A especificação em [SDD.md](SDD.md) define requisitos e critérios de aceitação. Etapas ainda não concluídas estão desmarcadas.

- [x] Definir objetivo, identidade conversacional e direção visual.
- [x] Confirmar Windows, plataforma de execução e direção de áudio.
- [x] Aprovar escuta automática durante sessão ativa, após autorização.
- [x] Preparar referência visual demonstrativa e documentação no GitHub.
- [x] Especificar apresentação natural, registro de nomes, adesão vocal inicial e memória por interlocutor.
- [ ] Implementar e validar ID01–ID12 da seção 14 do SDD; não confundir aprovação com implementação.
- [ ] E0: escolher stack, formato de execução, provedor de modelo e voz com avaliação de custo e compatibilidade.
- [ ] E1: separar interface, coordenador de sessão, contratos e adaptadores; entregar execução local documentada e demonstração sem credenciais.
- [ ] E2: integrar diálogo real, cancelamento, histórico persistente e memória manual.
- [ ] E3: validar voz contínua, fim de fala, interrupção pela voz e eco em Windows.
- [ ] E4: memória seletiva revisável, mapa intelectual e aprendizagem linguística contextual.
- [ ] E5: fontes verificáveis e demais evoluções aprovadas.

## Primeira tarefa para desenvolvimento

Ler SDD e AGENTS.md, inventariar o protótipo e propor uma stack compatível com Windows 10 x64. Implementar E1 sem contratar serviços, sem capturar áudio fora da sessão e sem apresentar exemplos fixos como respostas reais. A referência atual é um HTML de demonstração, não uma base modular pronta.

## Questões ainda abertas

Formato instalado ou navegador local; comportamento ao minimizar; iniciativa durante silêncio; timbre de voz; apresentação das correções; calibração de resumos; integração de pesquisa e acesso a vídeos; fornecedor final e ferramenta de desenvolvimento.

## Verificação de entrega

Registrar instruções reproduzíveis, testes executados e limitações. Validar no computador real com fone e depois com caixas de som. Sintaxe válida não comprova áudio, cancelamento ou naturalidade.

## Identidade conversacional — sequência aprovada

Em E1, incluir contratos de identidade e simulações identificadas. Em E2, implementar apresentações, visitante e separação de perfis. Após E3, avaliar reconhecimento vocal real com adesão inicial e qualidade de amostra. Em E4, garantir que memória inteligente e mapas permaneçam isolados por pessoa. Grupos e fala sobreposta ficam para evolução; reconhecimento vocal não libera sozinho histórico reservado.

Motor, limiares, retenção/proteção de referência vocal e confirmação adicional de acesso ainda precisam ser definidos. O nome pode surgir e ser registrado naturalmente; isso não implica adesão automática à identificação vocal persistente.

## Memória e pesquisa — decisões aprovadas

- [x] Aprovar dez dias de detalhes recentes, com descarte dos excessos e preservação de resumos importantes e lembranças fixadas.
- [x] Aprovar pesquisa seletiva de atualidade, política, religião, filmes, animes, séries e vídeos de opinião/crítica.
- [x] Definir tela limpa: indicador discreto e referências somente sob demanda.
- [ ] E1: simular indicador de pesquisa e modelar proveniência, person_id e vencimento.
- [ ] E2: guardar datas e separar memória pessoal de fontes externas.
- [ ] E4: implementar manutenção idempotente, expiração e critérios MEM01–MEM08.
- [ ] E5: integrar pesquisa e conteúdo acessível de vídeos; validar WEB01–WEB10. A inclusão em uma entrega anterior depende do planejamento técnico.

Não preservar arquivo oculto de transcrições expiradas. Não afirmar que assistiu a vídeo sem acesso ao conteúdo correspondente. Provedor de pesquisa, limites, integração de vídeos e calibração de resumos continuam pendentes.

# Ágora — especificação técnica pública

Versão 0.6-public · 21/09/2026
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
- RF15: apresentação natural e registro automático do nome informado, sem confirmação administrativa (seção 14).
- RF16: reconhecimento de voz com adesão inicial, estados de incerteza e alternativa visitante (seção 14).
- RF17: identidade e memória isoladas por interlocutor, sem usar voz sozinha como autorização de histórico reservado.

## 5. Personalidade e repertório

Voz conversacional serena, curiosa e direta. Respostas concisas por padrão, profundidade quando solicitada. Discordar com razões, reconhecer incertezas e não terminar toda resposta com uma pergunta. Evitar concordância automática e crítica compulsiva.

Distinguir relato, exploração de hipótese e argumento. Acompanhar mudanças de assunto. Não inventar consciência, experiências humanas ou crenças pessoais.

Em política e religião, avaliar argumentos sem presumir identidade do interlocutor. Distinguir fato, interpretação, tradição, fé e evidência. Não fabricar fontes, citações ou atualidade. Pesquisa seletiva na internet está aprovada, incluindo atualidade, obras e análises; regras na seção 16.

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

Memória: ID, person_id, categoria, texto, origem, data, estado de revisão. Operações: criar, aprovar, revisar, editar, excluir e exportar. Retenção textual definida na seção 15; seleção de memórias deve preservar origem e incerteza.

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
| E5 | Pesquisa seletiva, vídeos acessíveis e expansão. | Pesquisa aprovada; validar fontes e limites conforme seção 16. |

E1 não equivale ao MVP final. Um botão de ditado não satisfaz conversa contínua.

## 11. Testes de aceitação

Validar no Windows: permissão negada, ausência de microfone, troca de saída, perda de rede, interrupção durante geração/reprodução, retorno de evento atrasado, persistência após reinício, exportação e exclusão. Testar fone e alto-falantes.

Avaliar naturalidade: relato breve recebe resposta proporcional; posição política recebe contraponto pertinente; dúvida religiosa não vira rótulo; mudança de assunto é acompanhada; correção não quebra a conversa. Registrar tempos até primeiro áudio e até interrupção, sem anunciar metas medidas antes dos testes.

## 12. Pendências

Formato instalado ou navegador local; stack; fornecedores; comportamento ao minimizar; iniciativa durante silêncio; timbre; apresentação de correções; calibração da seleção de resumos; fornecedores de pesquisa e acesso a vídeos; ferramenta de desenvolvimento e nome definitivo.

## 13. Execução pelo desenvolvedor

Ler AGENTS.md e ROADMAP.md. Começar por E1, preservar distinção demonstração/real, não contratar serviços automaticamente e não presumir decisões pendentes. Atualizar documentação e registrar testes efetivamente executados a cada entrega.

## 14. Identidade conversacional e reconhecimento de voz — aprovado

### 14.1 Objetivo e escopo

Conhecer interlocutores por apresentações naturais, associar corretamente nomes e reconhecer vozes previamente cadastradas. Começar com uma pessoa falando por vez; conversas de grupo e fala sobreposta são evolução. Nome informado, identificação provável pela voz e autorização de acesso são estados distintos.

O registro de nome fornecido numa apresentação não exige a pergunta administrativa “posso cadastrar você?”. Isso não autoriza criar referência vocal persistente sem adesão. Permissão técnica de microfone também não equivale a adesão ao reconhecimento persistente.

### 14.2 Jornada de apresentação

1. Ao abrir, saudar pelo horário local: “Bom dia”, “Boa tarde” ou “Boa noite”, sem afirmar identidade pela voz antes de ouvir a pessoa.
2. Se houver apresentação espontânea (“Sou o Carlos”), aproveitar o nome; não perguntar novamente.
3. Caso o nome não esteja disponível, perguntar naturalmente “Como você se chama?” e seguir o assunto após a resposta.
4. Registrar nome de exibição e sua origem no perfil conversacional. Em modo visitante, manter essa associação apenas na sessão.
5. Se outra pessoa apresentar o interlocutor, associar a apresentação ao falante certo; perguntar brevemente quando houver ambiguidade.
6. Não transformar toda menção a um nome em cadastro. “Meu irmão Carlos” não identifica quem está falando.
7. Nomes iguais não implicam mesma pessoa; o identificador interno deve ser independente do nome.

Exemplo ilustrativo, sem dados de pessoas reais:

> Pessoa: Boa tarde, Ágora.  
> Ágora: Boa tarde. Acho que ainda não nos conhecemos. Como você se chama?  
> Pessoa: Sou o Carlos.  
> Ágora: Prazer, Carlos. O que você gostaria de conversar hoje?

Não afirmar “ainda não nos conhecemos” como certeza quando só houve falha de reconhecimento. Se a pessoa disser que já conversou com a IA, aceitar a informação como apresentação, sem liberar automaticamente um histórico existente.

### 14.3 Referência vocal e adesão

Oferecer uma adesão inicial simples fora do diálogo principal, no painel da mesma tela, explicando finalidade do reconhecimento, armazenamento e como apagar. Não repetir autorização a cada encontro nem pedir permissão para cada nome. A adesão deve ser da própria pessoa; não presumir adesão de visitantes a partir da configuração do proprietário.

Quem não aderir continua conversando como visitante, usando o nome informado naquela sessão, sem referência vocal persistente. Criar a referência somente após adesão e amostra adequada; não cadastrar silenciosamente vozes incidentais do ambiente.

Detalhes de armazenamento, proteção, retenção e processamento local/remoto da referência vocal devem ser definidos antes de implementar cadastro persistente. Não armazenar áudio bruto por padrão nem colocar amostras, vetores de voz ou perfis no Git.

### 14.4 Reconhecimento e incerteza

- Voz conhecida com evidência suficiente: usar o nome em uma saudação breve.
- Correspondência incerta: perguntar “É você, Carlos?” quando houver candidato plausível; caso contrário, pedir o nome sem listar perfis existentes.
- Voz desconhecida ou áudio insuficiente: seguir apresentação natural, sem forçar correspondência.
- Serviço indisponível: permitir apresentação manual e conversa; não inventar reconhecimento.
- Correção (“Não sou o Carlos”, “Meu nome é Carla”): aceitar, reparar a associação e continuar sem insistência.
- Mudança de voz/falante: suspender a associação anterior antes de recuperar ou gravar lembranças; avaliar a nova pessoa.
- Áudio sobreposto: suspender atribuição individual e pedir que fale uma pessoa por vez.
- Nunca atualizar automaticamente a referência de um perfil com áudio de identidade incerta.

O módulo deve retornar pontuação e estado, não uma alegação de certeza. Limiares e critérios de amostra serão calibrados com testes; não fixar porcentagens arbitrárias como garantia. Reconhecimento vocal não é autenticação forte e não deve, sozinho, liberar histórico reservado.

### 14.5 Memória por interlocutor

Adicionar um identificador de interlocutor a mensagens, memórias, resumos e contexto recuperado. Resolver o escopo de identidade e acesso antes de enviar lembranças ao modelo. Perfil visitante deve ter isolamento próprio e não herdar memória do proprietário.

Não recuperar, anunciar ou compartilhar lembranças pessoais de outro perfil. Reconhecer alguém não implica que esteja sozinho: a saudação não deve revelar assuntos privados. O mecanismo de confirmação adicional para acessar histórico reservado ainda será escolhido; enquanto não existir, manter esse acesso indisponível em sessões apenas reconhecidas por voz.

Quando uma atribuição errada for corrigida, revisar os registros afetados e invalidar resumos/índices derivados; não transferir todo o histórico de um perfil com base em uma frase. Exclusão de referência vocal deve impedir uso posterior no reconhecimento e invalidar caches associados.

### 14.6 Competência conversacional

Implementar instruções e exemplos de pragmática, análise da conversação e reparação de mal-entendidos. Essas capacidades orientam o comportamento; não pressupõem treinar um modelo novo.

- Distinguir apresentação, menção a terceiros, hipótese, brincadeira, pedido de análise e relato pessoal.
- Manter interpretações de intenção como hipóteses revisáveis; não inferir identidade por crenças, sotaque ou opinião.
- Confirmar só a ambiguidade relevante, com uma pergunta curta.
- Corrigir nome ouvido incorretamente com naturalidade: “Carlos, entendi.”
- Usar formalidade moderada na saudação e linguagem natural durante a conversa.
- Não repetir nomes, saudações ou perguntas de apresentação desnecessariamente na mesma sessão.
- Respeitar silêncio e pausas; não transformar o encontro em entrevista.
- Continuar o assunto após a apresentação ou correção, sem narrar detalhes de cadastro.
- Oferecer texto como alternativa e nunca tratar a ausência de reconhecimento como impedimento para conversar.

### 14.7 Contratos e módulos adicionais

| Elemento | Dados / responsabilidade |
| --- | --- |
| core/identity | Estados desconhecido, apresentado, visitante, reconhecido e incerto; associação ao turno. |
| adapters/speaker | Avaliar amostra e comparar referências autorizadas; retornar indisponível sem bloquear diálogo. |
| Perfil | person_id, nome de exibição, origem do nome, modo visitante/persistente, datas de criação/revisão. |
| Adesão vocal | person_id, finalidade, estado, data e versão da informação apresentada. |
| Referência vocal | ID, person_id, versão do modelo, qualidade, data e referência de armazenamento protegido. |
| Decisão de identidade | Sessão/turno, candidato opcional, pontuação, qualidade e estado; separada da autorização. |
| Escopo de acesso | person_id efetivo, permissões de memória e origem da confirmação adicional quando aplicável. |

A decisão de identidade pertence ao coordenador, não à livre invenção do modelo de linguagem. O modelo recebe somente o nome/contexto autorizado e o estado necessário à conversa.

### 14.8 Critérios de aceitação

- ID01: apresentação espontânea registra o nome sem perguntar “posso cadastrar?”.
- ID02: nome de terceiro mencionado não vira identidade do falante.
- ID03: ausência de voz na abertura gera saudação sem nome presumido.
- ID04: baixa confiança ou falha técnica não retorna identidade inventada.
- ID05: dois perfis de mesmo nome permanecem separados.
- ID06: correção de identidade interrompe o uso de memória do perfil anterior.
- ID07: visitante conversa normalmente e não deixa referência vocal persistente.
- ID08: cadastro vocal exige adesão inicial, sem repetição a cada encontro.
- ID09: troca de pessoa e fala sobreposta não gravam automaticamente no perfil anterior.
- ID10: identidade vocal, mesmo aceita, não libera sozinha histórico reservado.
- ID11: excluir referência impede reconhecimento por essa referência após reinício e invalida caches.
- ID12: testes com variação de microfone, ruído e gravação reproduzida registram falsos reconhecimentos/rejeições; não declarar proteção contra imitação sem validação.

### 14.9 Sequência de entrega e pendências

E1: contratos e simulação explícita dos estados de identidade. E2: apresentações, perfis e escopos separados. Após E3: avaliar reconhecimento real, adesão e critérios de amostra; só habilitar persistência vocal quando os requisitos correspondentes estiverem implementados. E4: memórias inteligentes isoladas por pessoa.

Permanecem abertas: motor de reconhecimento, execução local/remota, critérios de qualidade e confiança, proteção/retenção das referências, confirmação adicional de histórico reservado e experiência de grupos. A aprovação do comportamento não equivale a seleção dessas tecnologias.

**Revisão 0.5-public:** incorporada proposta aprovada de identidade conversacional, adesão vocal inicial, perfis separados e competência de diálogo. Requisitos documentados; ainda não implementados.

## 15. Memória seletiva e esquecimento gradual — aprovado

### Política

Manter detalhes textuais recentes por dez dias, contados do horário original de cada mensagem. Ao expirar, preservar apenas resumos importantes e descartar detalhes passageiros; não criar arquivo oculto de transcrições antigas. Consultar uma mensagem não reinicia seu prazo. Nomes e preferências úteis, resumos relevantes e lembranças explicitamente marcadas como “lembre disso” não expiram automaticamente por essa regra. Referências vocais seguem sua política própria, não o prazo de transcrições.

Executar manutenção ao abrir o aplicativo e periodicamente durante sessões longas, sem exigir serviço em segundo plano. Dados vencidos não entram no contexto antes da revisão, mesmo quando a aplicação ficou fechada. Aplicação fechada não executa exclusão; a manutenção ocorre na próxima execução. Explicar esse comportamento nas configurações.

A seleção considera continuidade do assunto, dúvidas em aberto, recorrência, correções relevantes e pedidos explícitos. Não preservar cada detalhe sob o rótulo de “resumo”, nem reintroduzir transcrições por caches ou índices. Limites de tamanho e de quantidade dos resumos devem ser configurados e medidos antes do aceite de desempenho.

### Integridade da lembrança

- Separar afirmação do interlocutor, hipótese explorada, sugestão da IA e informação verificada externamente.
- Resposta do modelo não vira fato confirmado só por entrar na memória.
- Resumos mantêm person_id, tema, data, origem, nível de certeza e condição da origem (disponível ou expirada). Após excluir o original, conservar identificação mínima de proveniência, não uma cópia do texto descartado.
- Resumir e validar o resultado antes da exclusão, com gravação atômica e manutenção idempotente. Se a síntese falhar, não inventar resumo nem conservar detalhes indefinidamente: registrar a falha sem conteúdo pessoal, preservar registros explicitamente fixados e executar a política de expiração.
- Não apagar uma sessão ativa em uso de forma inconsistente; retirar trechos expirados também do contexto/cache conforme os limites de turno.
- Exclusão e edição devem invalidar índices, caches e resumos derivados pertinentes. Exportações manuais externas não podem ser apagadas pelo aplicativo; restauração deve reaplicar a política antes de disponibilizar dados.
- Não fingir esquecimento: se existe resumo, dizer que lembra do tema mas não dos detalhes; se nada restou, reconhecer isso e reconstruir o contexto com a pessoa.
- Recuperar só lembranças relevantes e autorizadas, não todo o histórico. Compactação de armazenamento e redução de contexto/custo são objetivos distintos.
- Preservar isolamento entre perfis. Visitantes continuam sem memória persistente; a regra de dez dias não cria retenção para visitantes.
- “Lembre disso” protege o conteúdo indicado da expiração automática, não toda a conversa; exclusão explícita ainda prevalece.

### Critérios de aceitação

- MEM01: após dez dias, detalhe passageiro deixa de aparecer no armazenamento ativo, recuperação e índices.
- MEM02: resumo importante continua acessível com contexto, origem mínima e incerteza preservados.
- MEM03: lembrete fixado permanece, mas pode ser excluído explicitamente.
- MEM04: reinício após período fechado processa vencimentos antes de recuperar memórias.
- MEM05: manutenção repetida não duplica resumos; falha não produz lembranças inventadas.
- MEM06: hipótese e sugestão da IA não viram crença/fato confirmado.
- MEM07: perguntas sobre detalhe eliminado recebem reconhecimento honesto da limitação.
- MEM08: restauração e caches não ressuscitam detalhes expirados; testes usam relógio controlado, não espera real de dez dias.

## 16. Pesquisa na internet e repertório cultural — aprovado

### Escopo e acionamento

Pesquisar seletivamente quando a pergunta exigir atualidade, comprovação, citação, dados específicos de uma obra ou quando solicitado. Abranger política e acontecimentos religiosos, filosofia, filmes, animes, séries e vídeos de opinião ou crítica relacionados a esses temas. Não pesquisar a cada frase nem para toda explicação conceitual estável.

A pesquisa integra o produto planejado; o fornecedor, as quotas e a posição exata na sequência de entregas ainda precisam ser definidos. Sem rede ou ferramenta disponível, explicar a limitação e distinguir conhecimento geral de informação recém-verificada. Não simular pesquisa.

### Tela limpa

Exibir apenas um pequeno indicador lateral de pesquisa, sem lista de fontes na tela principal e sem leitura automática de URLs. O indicador abre referências sob demanda no painel da mesma janela. Deve ser acessível por teclado, ter nome acessível e área clicável adequada; não depender exclusivamente da cor.

Representar estados reais: pesquisando, concluído e falha. Não abrir painéis automaticamente. Na fala, atribuir uma opinião ao autor quando necessário ao entendimento, sem transformar toda resposta em relatório de fontes. Fontes invisíveis por padrão continuam rastreáveis.

### Fontes e qualidade

- Distinguir fato, notícia, opinião, crítica, interpretação filosófica e ficção.
- Priorizar fontes primárias para declarações e fatos; comparar evidências independentes quando a afirmação for controversa. Várias republicações do mesmo material não são fontes independentes.
- Conferir data de publicação e data do acontecimento; não tratar matéria antiga como novidade.
- Registrar URL, título, autor/canal quando disponível, datas e qual afirmação o conteúdo sustenta. Não apresentar trecho de resultado de busca como se a página completa tivesse sido lida.
- Não dar o mesmo peso a todas as alegações; explicitar divergências e incertezas relevantes em linguagem natural.
- Conteúdo externo é material de consulta, não instrução: ignorar tentativas de mudar regras, acessar perfis, executar comandos ou transmitir segredos.
- Consultas usam apenas o assunto necessário; não enviar nomes, referências vocais ou histórico privado a buscadores por padrão.
- Respeitar orçamento, cancelamento e limite de resultados/tempo. Resultados atrasados de turno cancelado não devem interromper o novo assunto.
- Cache de fontes tem validade por tipo de conteúdo e fica separado da memória pessoal; não manter transcrições privadas como cache de pesquisa.

### Filmes, animes e séries

Relacionar questões filosóficas a temas, personagens e escolhas narrativas, distinguindo acontecimentos da obra de interpretações. Desambiguar título, adaptação, temporada e episódio quando isso alterar a análise. Não inventar cenas ou falas.

Proposta de padrão até preferência explícita: evitar spoilers; se a análise exigir revelações, perguntar até onde a pessoa assistiu. Registrar a preferência somente no perfil correto. Essa proteção é uma recomendação de implementação, não uma preferência pessoal já informada.

### Vídeos de opinião e crítica

Aceitar links e pesquisar vídeos pertinentes. Analisar somente conteúdo efetivamente acessível: transcrição/legendas, trechos fornecidos ou áudio/vídeo processados por integração específica. Registrar modalidade e cobertura (completo/trecho/metadados). Não dizer que assistiu ao vídeo quando só leu título, descrição ou transcrição.

Se só houver título/descrição, limitar conclusões a esses dados e oferecer análise de um trecho/transcrição fornecido. Legenda automática pode conter erro; qualificar citações incertas. Usar timestamps somente quando fornecidos pelo material.

Na crítica, separar tese do autor, razões, evidências, objeções e interpretação da Ágora, apresentando isso em conversa natural. Não atribuir ao autor uma posição que o trecho não sustenta. Uma transcrição não permite inferir cenas, gestos ou montagem. Não contornar acesso restrito nem reproduzir obras completas.

### Contratos e testes

Adicionar adaptador de pesquisa e resolvedor de conteúdo com cancelamento, custos, status, URL, datas, modalidade, cobertura, proveniência e limite de validade. Vincular cada fonte às afirmações apoiadas e ao turno correspondente.

- WEB01: pergunta atual aciona pesquisa; explicação estável pode responder sem pesquisa desnecessária.
- WEB02: fontes ficam ocultas na tela principal e podem ser abertas pelo indicador acessível.
- WEB03: falha ou ausência de acesso não é apresentada como verificação concluída.
- WEB04: notícia antiga, opinião e conteúdo fictício são diferenciados.
- WEB05: vídeo com apenas metadados não gera análise inventada do conteúdo.
- WEB06: transcrição parcial e legenda automática mantêm suas limitações registradas.
- WEB07: conteúdo externo não altera regras nem provoca envio de memória privada.
- WEB08: cancelamento evita resposta atrasada; teto de pesquisa evita consumo sem controle.
- WEB09: fontes recuperadas e lembranças pessoais permanecem separadas.
- WEB10: spoilers são evitados até haver contexto suficiente ou pedido explícito.

**Revisão 0.6-public:** pesquisa seletiva e repertório cultural aprovados; detalhes textuais revisados após dez dias, preservando resumos úteis e lembranças fixadas. Indicador discreto com fontes sob demanda. Documentação, não implementação.

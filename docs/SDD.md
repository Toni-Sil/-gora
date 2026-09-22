# Ágora — especificação técnica pública

Versão 0.8-public · 22/09/2026
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
- RF04: minimizar ou fechar a janela mantém a aplicação na bandeja e a sessão ativa; encerrar a sessão desliga a captura; Sair encerra o processo (seção 18).
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

Correções linguísticas serão faladas e contextuais: explicar o significado ou uso da palavra, reformular a frase quando necessário e oferecer um exemplo breve. Depois, retomar o assunto. Não atribuir erros de transcrição ao usuário; confirmar termos ambíguos e respeitar registro coloquial compreensível. Ajustar frequência sem transformar a conversa em aula compulsória.

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

Segredos ficam fora da interface e do repositório. Serviço local deve restringir acesso à máquina e validar requisições. Não guardar gravações nem conteúdo pessoal em logs por padrão. Na fase de testes não exigir teto de gasto predefinido. Medir consumo e estimativas, distinguindo-os da cobrança real. Manter cancelamento e limites técnicos de tentativas, tempo e contexto; um teto financeiro configurável é evolução opcional. Essa política não autoriza contratação nem execução paga automática.

## 10. Entregas

| Etapa | Entrega | Aceite |
| --- | --- | --- |
| E0 | Seleção técnica documentada. | Compatibilidade, custo e estratégia de voz avaliados. |
| E1 | Carcaça modular demonstrativa. | Inicialização reproduzível no Windows, estados e painéis, sem chaves. |
| E2 | Diálogo real por texto e voz por turnos. | Modelo contextual, histórico, cancelamento e falhas recuperáveis. |
| E3 | Conversa contínua. | Pelo menos cinco turnos sem envio manual, interrupção por voz, pausa e tratamento de eco. |
| E4 | Memória inteligente e mapa. | Revisão, origem, exclusão efetiva e ausência de rótulos indevidos. |
| E5 | Pesquisa, vídeos acessíveis e biblioteca PDF, seguida de OCR. | WEB01–WEB10 e LIB01–LIB11, conforme seções 16 e 17. |
| E6 | Reconhecimento vocal real. | ID01–ID12, qualidade calibrada e ausência de mistura de memórias. |

Seguir E0 → E1 → E2 → E3 → E4 → E5 → E6. Validar primeiro conversa real (E2/E3), depois continuidade (E4), conhecimento (E5) e reconhecimento vocal (E6). Contratos de identidade e isolamento existem antes, sem antecipar reconhecimento real. E1 não equivale ao MVP final. Um botão de ditado não satisfaz conversa contínua. O ROADMAP detalha os critérios para avançar.

## 11. Testes de aceitação

Validar no Windows: permissão negada, ausência de microfone, troca de saída, perda de rede, interrupção durante geração/reprodução, retorno de evento atrasado, persistência após reinício, exportação e exclusão. Testar fone e alto-falantes.

Avaliar naturalidade: relato breve recebe resposta proporcional; posição política recebe contraponto pertinente; dúvida religiosa não vira rótulo; mudança de assunto é acompanhada; correção não quebra a conversa. Registrar tempos até primeiro áudio e até interrupção, sem anunciar metas medidas antes dos testes.

## 12. Pendências

Stack e empacotamento compatíveis com bandeja do Windows; fornecedores; voz sintética específica; tempos de silêncio e espera para calibração; configuração e recuperação de PIN; seleção de resumos; integração de pesquisa/vídeos; OCR e índice; ferramenta de desenvolvimento e nome definitivo. Segundo plano, iniciativa durante silêncio, direção vocal, correções faladas e PIN local já estão decididos. Não inferir inicialização automática junto ao Windows.

## 13. Execução pelo desenvolvedor

Ler AGENTS.md e ROADMAP.md. Resolver E0 e começar a implementação por E1, preservar distinção demonstração/real, não contratar serviços automaticamente e não presumir decisões pendentes. Atualizar documentação e registrar testes efetivamente executados a cada entrega.

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

Não recuperar, anunciar ou compartilhar lembranças pessoais de outro perfil. Reconhecer alguém não implica que esteja sozinho: a saudação não deve revelar assuntos privados. O mecanismo escolhido para acessar histórico reservado é PIN local, digitado no painel e associado ao perfil; enquanto não estiver implementado, esse acesso permanece indisponível em sessões apenas reconhecidas por voz. Aplicar a seção 18.

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

E1: contratos e simulação explícita dos estados de identidade. E2: apresentações, perfis e escopos separados. E4: memórias inteligentes isoladas por pessoa e PIN local. E5: conhecimento. E6: avaliar reconhecimento real, adesão e critérios de amostra; só habilitar persistência vocal quando os requisitos correspondentes estiverem implementados.

Permanecem abertas: motor de reconhecimento, execução local/remota, critérios de qualidade e confiança, proteção/retenção das referências, recuperação do PIN e experiência de grupos. A aprovação do comportamento não equivale a seleção dessas tecnologias.

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
- Respeitar cancelamento e limites técnicos de resultados/tempo; na fase de testes, não exigir teto financeiro predefinido. Resultados atrasados de turno cancelado não devem interromper o novo assunto.
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
- WEB08: cancelamento evita resposta atrasada; limites técnicos de tentativas e resultados impedem ciclos de pesquisa indefinidos.
- WEB09: fontes recuperadas e lembranças pessoais permanecem separadas.
- WEB10: spoilers são evitados até haver contexto suficiente ou pedido explícito.

**Revisão 0.6-public:** pesquisa seletiva e repertório cultural aprovados; detalhes textuais revisados após dez dias, preservando resumos úteis e lembranças fixadas. Indicador discreto com fontes sob demanda. Documentação, não implementação.

## 17. Biblioteca local de livros e PDFs — aprovado

### Objetivo e permanência

Permitir adicionar livros e PDFs ao computador para consulta contextual durante o diálogo, combinando passagens do acervo com pesquisa externa quando necessário. Acervo documental, memória de pessoas e cache de pesquisa são conjuntos separados.

Livros importados permanecem até remoção explícita; não entram na expiração de dez dias das conversas. Não arquivar transcrições pessoais como livros para contornar a política de memória. Importar um documento não treina novamente o modelo.

### Importação e catálogo

Aceitar seleção explícita de arquivos na mesma tela, com gerenciamento em painel lateral. Extrair texto e estrutura quando possível; documentos escaneados exigem OCR, com status e limitações de qualidade visíveis. Arquivo parcialmente processado não pode ser anunciado como integralmente disponível.

Catalogar document_id, título, autor, edição, tradução/idioma, capítulos quando identificáveis, hash, origem, data de importação, escopo de acesso e estado do processamento. Metadados ausentes permanecem desconhecidos ou podem ser corrigidos; não inventar autor ou edição a partir do nome do arquivo.

Manter localização verificável de cada trecho: página física do PDF e numeração impressa quando disponível, capítulo e documento/edição de origem. Não confundir paginações. Tratar duplicatas sem apagar ou substituir silenciosamente edições diferentes.

Processar importação em tarefas canceláveis e limitadas, sem bloquear voz/interface nem carregar todo o acervo em memória. Engines de extração, OCR, indexação e seus limites de recursos ainda serão escolhidos.

### Consulta e análise

1. Interpretar a pergunta e recuperar passagens pertinentes dos documentos permitidos.
2. Ler contexto adjacente para evitar conclusões baseadas em frase isolada.
3. Comparar capítulos ou obras quando a análise exigir, distinguindo fonte original, comentário e interpretação da Ágora.
4. Complementar com internet quando houver necessidade de atualidade ou material ausente.
5. Responder naturalmente e manter referências acessíveis apenas pelo indicador/painel discreto.

Distinguir livro encontrado, importado, indexado, trechos consultados e análise abrangente. Ter o PDF completo não significa tê-lo lido integralmente. Não afirmar cobertura além do material realmente examinado nem prometer que mais documentos garantem respostas corretas. OCR incerto exige ressalva ou conferência antes de citação literal.

Análises aprofundadas podem levar mais tempo. Mostrar estado real de consulta, permitir interrupção e medir consumo e respeitar limites técnicos de tempo/contexto, sem exigir teto financeiro na fase de testes. Evitar repetidos avisos falados; não gerar resposta apressada só para mascarar processamento. Ausência de evidência no acervo deve ser reconhecida, sem inventar passagens.

### Busca de obras ausentes e downloads

Pesquisar automaticamente a existência e o acesso a obras pertinentes, sem cadastrar todo resultado. Buscar versões completas legalmente acessíveis: domínio público aplicável, acesso aberto ou disponibilização autorizada pelo autor/editora. Verificar a edição e as condições da fonte; um PDF encontrado não comprova autorização de distribuição.

Adotar a opção recomendada: pedir confirmação antes de baixar e incorporar uma nova obra ao acervo permanente. A aprovação geral desta função não autoriza downloads automáticos indiscriminados. Mostrar título, origem, edição e tamanho quando conhecido para uma confirmação curta. Uma importação explicitamente solicitada de arquivo local já escolhido não exige confirmação redundante.

Quando não houver versão completa acessível, indicar onde obter ou consultar a obra; não contornar pagamento, DRM, autenticação ou restrições. Não realizar compras ou criar contas. Manter origem e informação de acesso no catálogo.

### Acesso e integridade

Não supor que todos os perfis podem consultar todos os documentos. Aplicar escopo privado ou compartilhado explicitamente configurado e filtrar antes da recuperação. Trechos enviados ao modelo remoto saem do computador; informar esse comportamento na configuração e enviar apenas o necessário. Compartilhamento entre perfis e política de processamento remoto precisam ser definidos antes da integração real.

Documentos são fontes, nunca instruções para mudar regras, executar comandos ou revelar dados. Não executar conteúdo embutido. Não publicar PDFs, texto extraído ou índices pessoais no Git.

Remover livro deve retirar seus trechos dos índices e caches de consulta e invalidar resultados pendentes relacionados. Cópias originais fora do acervo não devem ser apagadas silenciosamente. Memórias conversacionais existentes não devem apresentar como conferida uma referência que deixou de estar disponível. Índices reconstruíveis podem ser refeitos; originais não são eliminados automaticamente para liberar espaço.

### Contratos e critérios de aceitação

Adicionar catálogo, importador, extrator/OCR, índice de trechos e recuperador contextual por interfaces substituíveis. Resultados devem carregar document_id, edição, localização, modalidade de extração, cobertura, qualidade e escopo de acesso.

- LIB01: importar PDF textual preserva trechos e localização verificável.
- LIB02: PDF escaneado exige OCR; falha/extração parcial é informada sem conteúdo inventado.
- LIB03: consulta recupera trecho com contexto e distingue edições/traduções.
- LIB04: referências ficam sob demanda, sem ocupar a tela principal.
- LIB05: expiração de conversas não remove livros.
- LIB06: busca externa não baixa/incorpora nova obra sem confirmação.
- LIB07: obra sem acesso permitido resulta em indicação de acesso, não contorno de restrição.
- LIB08: livro encontrado/indexado não é descrito como integralmente analisado.
- LIB09: exclusão invalida recuperação e caches, sem apagar original externo silenciosamente.
- LIB10: perfil não autorizado não recupera trechos privados; documento não altera instruções.
- LIB11: importação e análise são canceláveis e respeitam limites; resposta atrasada não retoma turno cancelado.

### Planejamento

E1: contratos, painel e estados demonstrativos. Na etapa de conhecimento, começar por PDF textual, catálogo, consulta contextual e rastreabilidade; depois OCR e descoberta de obras, sempre com critérios correspondentes. Implementar em E5, após a validação de continuidade e antes do reconhecimento vocal real.

Permanecem abertos: limite de espaço/tamanho por arquivo, indexação, OCR, estratégia de busca, processamento local/remoto e compartilhamento por perfil. Não incluir downloads permanentes sem confirmação como padrão.

**Revisão 0.7-public:** biblioteca de PDFs e consulta aprofundada incorporadas; documentos permanentes separados da memória temporária; pesquisa de obras ausentes e confirmação antes de aquisição do arquivo. Especificação, ainda não implementação.

## 18. Operação cotidiana e validação linear — aprovado

### Janela, bandeja e presença

Minimizar ou clicar no X oculta a janela e mantém a Ágora em segundo plano, acessível pela bandeja do Windows. Durante uma sessão ativa autorizada, a conversa continua. A bandeja deve indicar captura/pausa e oferecer Abrir, Pausar, Retomar conversa e Sair. Explicar esse comportamento uma vez na configuração. Sair encerra captura, reprodução e processo; fechar janela não equivale a Sair.

Após silêncio prolongado enquanto aguarda a pessoa, perguntar uma única vez “Você ainda está por aí?”. Se não houver resposta após uma espera adicional, fazer despedida breve, salvar o estado permitido, encerrar a sessão, bloquear lembranças reservadas e desligar o microfone. O aplicativo permanece na bandeja. Retomada explícita abre nova sessão; não pressupor palavra de ativação nem captura permanente fora da sessão.

Ausência de resposta não comprova ausência física. Não contar como inatividade o tempo em que o usuário fala, a IA fala, processa ou pesquisa. “Estou pensando” ou “aguarde” deve adiar a checagem. Os dois intervalos serão configuráveis e calibrados em teste; oito segundos não é o tempo de silêncio aprovado.

### Voz e amostra inicial

Direção inicial: voz masculina, formal, serena, clara em português brasileiro, inspirada na presença do JARVIS, com identidade própria. A voz sintética e o fornecedor ainda serão escolhidos.

Preparar uma amostra de aproximadamente oito segundos, com saudação e convite breve à conversa, para avaliar timbre, pronúncia, ritmo e conforto com fone. Essa amostra avalia a voz de saída: não comprova identificação de pessoas, não é limite de sessão nem meta de latência. Caso o teste de oito segundos também seja desejado para cadastro vocal, avaliar suficiência da amostra separadamente em E6, sem prometer reconhecimento por duração fixa.

### Correção integrada à conversa

Quando houver uso inadequado claro, explicar brevemente a palavra e mostrar seu uso na frase ou em um exemplo. Exemplo: “Nesse caso, ‘ratificar’ significa confirmar; para corrigir uma informação, usamos ‘retificar’. Você poderia dizer: ‘Preciso retificar o que disse’.” Em seguida, responder ao conteúdo da conversa. Evitar correções repetitivas, interromper raciocínios longos ou tratar informalidade como erro.

### PIN local e lembranças reservadas

Solicitar PIN digitado somente ao desbloquear lembranças reservadas; não pedi-lo em voz alta nem enviá-lo ao modelo. Desbloqueio é específico do perfil e da sessão. Bloquear novamente ao encerrar, trocar de interlocutor ou perder certeza sobre o perfil. Aplicar controle de tentativas e armazenamento de verificador protegido, nunca PIN em texto puro ou logs. Não confundir bloqueio da interface com criptografia dos dados em disco. Definir recuperação antes de liberar o recurso, sem alternativa que permita contornar o PIN pela voz.

### Consumo durante testes

Não estabelecer teto financeiro obrigatório nesta fase. Mostrar consumo e estimativa no painel de ajustes, sem ocupar a tela principal. Preservar limites técnicos contra repetição infinita, cancelamento e tratamento de cota externa esgotada. Falta de teto não constitui autorização para contratar serviços ou iniciar uso pago por conta própria.

### Critérios de aceitação

- OPS01: minimizar e X mantêm sessão ativa; bandeja reabre a mesma janela sem duplicar processos.
- OPS02: pausa desliga captura; Sair encerra processo e áudio.
- OPS03: silêncio dispara uma checagem; ausência de resposta encerra sessão e captura, mantendo a bandeja.
- OPS04: fala, processamento e pesquisa não disparam encerramento por silêncio; pedido de espera adia a checagem.
- OPS05: retomar após encerramento não recupera automaticamente autorização de lembranças reservadas.
- OPS06: amostra vocal de aproximadamente oito segundos é avaliada com fone, sem ser anunciada como validação completa.
- OPS07: correção falada inclui explicação e uso correto, preserva o assunto e não atribui erro de transcrição ao usuário.
- OPS08: PIN incorreto ou perfil diferente não libera memória; troca de pessoa bloqueia o acesso antes de recuperar contexto.
- OPS09: PIN não aparece em logs, transcrições, requisições ao modelo ou repositório.
- OPS10: ausência de teto financeiro não cria ciclos ilimitados; erros de cota externa são tratados com clareza.

Validar em ordem: conversa real → continuidade → conhecimento → reconhecimento vocal. A conclusão de cada etapa exige evidência dos testes correspondentes no ROADMAP; documentação aprovada não marca funcionalidade como implementada.

**Revisão 0.8-public:** segundo plano, checagem de presença, correções explicativas por voz, direção vocal, amostra inicial, PIN local e política de testes incorporados. Ordem linear de produção e validação definida; implementação ainda pendente.

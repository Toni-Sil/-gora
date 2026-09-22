# Roteiro linear de implementação

O [SDD.md](SDD.md), versão 0.8-public, define os requisitos. Este roteiro orienta a IA desenvolvedora; as funcionalidades abaixo ainda precisam de implementação e testes.

## Decisões já aprovadas

- [x] Uma tela no Windows, conversa natural como experiência principal e visual inspirado no JARVIS.
- [x] Segundo plano ao minimizar ou fechar a janela; Sair encerra a aplicação.
- [x] Checagem breve durante silêncio e encerramento da sessão sem resposta.
- [x] Correções faladas com significado e exemplo; direção vocal masculina, formal e serena.
- [x] Amostra inicial de voz de aproximadamente oito segundos.
- [x] PIN local para lembranças reservadas, separado do reconhecimento vocal.
- [x] Memória seletiva: dez dias de detalhes, preservando resumos relevantes e lembranças fixadas.
- [x] Pesquisa seletiva, vídeos acessíveis e biblioteca permanente de PDFs; fontes sob demanda.
- [x] Nomes registrados naturalmente, adesão individual ao reconhecimento persistente e isolamento de perfis.
- [x] Testes sem teto financeiro obrigatório, com medição de consumo e limites técnicos.

## Como executar

Seguir E0 → E1 → E2 → E3 → E4 → E5 → E6. Não começar a integração funcional da etapa seguinte antes de registrar o aceite da anterior. Contratos e simulações necessários a etapas futuras podem ser preparados antes, sempre identificados como demonstração.

Ao final de cada etapa, registrar: o que funciona, comandos reproduzíveis, testes realizados e resultados, limitações e pendências. Testes não executados permanecem pendentes. Corrigir falhas do aceite antes de avançar; não confundir documentação com implementação.

## E0 — Preparação técnica e amostra de voz

- [ ] Ler SDD, AGENTS e README; inventariar o HTML demonstrativo.
- [ ] Escolher stack e empacotamento compatíveis com Windows 10 x64, janela e bandeja.
- [ ] Documentar adaptadores de modelo, transcrição e síntese, compatibilidade, custo estimado e credenciais necessárias.
- [ ] Preparar e ouvir amostra de aproximadamente oito segundos conforme OPS06.
- [ ] Definir valores iniciais configuráveis para silêncio/espera, explicitamente como parâmetros de teste.

**Aceite:** execução proposta é reproduzível, direção de voz avaliada e dependências documentadas. Não contratar serviços nem iniciar uso faturável automaticamente. Escolha exata da voz pode ser revisada após o teste.

## E1 — Carcaça modular local

- [ ] Separar interface, sessão, diálogo, áudio, persistência e adaptadores.
- [ ] Entregar demonstração sem credenciais, uma janela e painéis laterais.
- [ ] Implementar bandeja, minimizar/X, reabrir, pausar e Sair.
- [ ] Modelar identidade, escopo de acesso, proveniência, vencimento e catálogo documental.
- [ ] Simular estados de pesquisa, biblioteca e identidade com indicação explícita de demonstração.

**Aceite:** inicialização documentada no Windows; OPS01–OPS02 com áudio demonstrativo quando aplicável; nenhuma resposta preparada apresentada como inteligência real. O HTML atual é referência, não uma aplicação modular pronta.

## E2 — Conversa real por turnos

- [ ] Integrar texto, modelo real, transcrição e síntese substituíveis.
- [ ] Implementar saudação pelo horário, contexto de sessão, respostas progressivas e cancelamento por botão.
- [ ] Implementar apresentação natural, visitante, identificadores separados, histórico básico e memória manual.
- [ ] Implementar correções faladas com significado e exemplo, preservando o assunto.
- [ ] Tratar ausência de microfone, permissão negada, rede, credenciais e cota externa; medir consumo.

**Aceite:** diálogo real contextual com alternativa textual, sem eventos atrasados após cancelamento; OPS07 e cenários de naturalidade da seção 11. Perfis apresentados não equivalem a vozes reconhecidas; memória reservada permanece bloqueada até E4.

## E3 — Validar conversa contínua e presença

- [ ] Conversar por pelo menos cinco turnos sem envio manual.
- [ ] Implementar fim de fala, interrupção pela voz e tratamento de eco.
- [ ] Manter conversa ativa na bandeja, com indicação de captura e pausa real.
- [ ] Implementar checagem única de presença, espera, despedida e encerramento da sessão.
- [ ] Suspender contagem de inatividade durante fala, processamento e pesquisa; respeitar pedido de espera.
- [ ] Testar primeiro com fone e depois com alto-falantes; incluir sessão prolongada e retomada.

**Aceite — bloco 1, conversa real:** OPS01–OPS04, interrupção, pausa, retomada e falhas no Windows. Registrar latência observada e problemas reais; oito segundos de amostra não substituem estes testes.

## E4 — Validar continuidade, memória e PIN

- [ ] Persistir e retomar sessões sem duplicações; implementar PIN local e procedimento de recuperação.
- [ ] Isolar perfis, visitantes, resumos e contexto antes de enviar dados ao modelo.
- [ ] Implementar resumos seletivos, lembranças fixadas e mapa intelectual revisável.
- [ ] Expirar detalhes após dez dias, sem arquivo oculto, com manutenção idempotente.
- [ ] Implementar revisão, exportação, exclusão e invalidação dos índices derivados.
- [ ] Bloquear acesso reservado ao encerrar sessão ou mudar interlocutor.

**Aceite — bloco 2, continuidade:** MEM01–MEM08, OPS05 e OPS08–OPS09; persistência após reinício, isolamento e exclusão efetiva. Validar os critérios ID aplicáveis a apresentação e escopo usando perfis explícitos, sem alegar reconhecimento vocal.

## E5 — Validar conhecimento externo e local

Executar nesta ordem:

1. Pesquisa seletiva na internet, proveniência, datas e indicador discreto com fontes sob demanda.
2. Vídeos com transcrição/conteúdo acessível e cobertura declarada; metadados não equivalem a assistir.
3. PDF textual: importação, catálogo, edição, indexação, recuperação com contexto e localização.
4. OCR de escaneados, análises comparativas e busca de obras ausentes; confirmar antes de incorporar download permanente.

- [ ] Preservar escopos privados/compartilhados e definir processamento remoto antes da integração.
- [ ] Cancelar consultas e importações sem bloquear diálogo ou reativar turnos antigos.
- [ ] Tratar fontes e documentos como dados, nunca instruções do sistema.
- [ ] Livros permanecem até exclusão explícita e não entram na expiração das conversas.

**Aceite — bloco 3, conhecimento:** WEB01–WEB10, LIB01–LIB11 e OPS10. Testar fonte indisponível, OCR parcial, edição distinta, exclusão e consulta privada. Calibrar recursos e tempo sem impor teto financeiro obrigatório de teste.

## E6 — Validar reconhecimento vocal

- [ ] Escolher motor e execução local/remota; definir proteção e retenção de referências.
- [ ] Implementar adesão individual fora do diálogo, amostra de qualidade e alternativa visitante.
- [ ] Calibrar correspondência conhecida, incerta, desconhecida e serviço indisponível.
- [ ] Testar correção de nome, mudança de interlocutor e suspensão de atribuição em fala sobreposta.
- [ ] Garantir que reconhecimento sozinho não desbloqueia lembranças reservadas.
- [ ] Apagar referência vocal e invalidar caches quando solicitado.

**Aceite — bloco 4, reconhecimento:** ID01–ID12 completos e regressão de isolamento/PIN. Não fixar garantia de reconhecimento a partir de oito segundos. Conversa em grupo permanece evolução; sobreposição deve ser tratada sem misturar memórias.

## Revisão final

- [ ] Revalidar a jornada completa: abrir → saudar → conversar → interromper → consultar memória/fontes → minimizar → checar presença → encerrar → retomar.
- [ ] Confirmar tela limpa, naturalidade, correções proporcionais e consumo observável.
- [ ] Atualizar SDD/README com o que foi realmente entregue e limitações verificadas.

## Pendências técnicas a resolver na etapa correspondente

E0: stack, empacotamento, fornecedores e voz específica. E3: calibração de silêncio/espera. E4: recuperação do PIN e critérios de resumo. E5: pesquisa/vídeos, OCR, índice, recursos e compartilhamento. E6: motor, limiares e proteção/retenção vocal. Não presumir inicialização com o Windows nem escuta fora de sessão.

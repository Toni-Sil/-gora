# Orientações para desenvolvimento da Ágora

## Fontes de verdade

Leia `docs/SDD.md`, `docs/ROADMAP.md` e `README.md` antes de alterar o projeto. `prototype/agora.html` é referência visual e comportamental demonstrativa. Preserve decisões aprovadas e identifique novas propostas como propostas.

## Objetivo

Interlocutora natural por voz, com profundidade em filosofia, política e religião. Uma única tela futurista; texto, transcrição, memórias e ajustes são apoio. Não transformar todas as respostas em aula ou sequência de perguntas.

## Escopo inicial

Priorizar E1: carcaça modular executável localmente em Windows, estados de sessão e adaptadores demonstrativos. O produto completo exige diálogo real e voz contínua; não marcar E2/E3 como concluídos com respostas fixas ou ditado por botão.

## Implementação

- Isolar modelo, transcrição, síntese, armazenamento e interface. Evitar dependências pesadas sem justificativa para a plataforma de destino.
- Nunca incluir chaves, tokens, gravações, histórico pessoal ou banco de dados no Git. Credenciais ficam no backend local.
- A escuta automática exige primeira autorização, sessão ativa, indicação visível e pausa que realmente interrompa a captura. Não introduzir escuta em segundo plano por suposição.
- Cancelar geração e reprodução obsoletas quando o usuário interromper. Não executar eventos de turnos antigos.
- Memórias devem ter origem e permitir edição/exclusão. Não converter exploração de argumentos em crença definitiva.
- Não atribuir erros de transcrição à linguagem do usuário.
- Manter alternativa por texto e mensagens úteis para falhas.
- Não assumir assinatura, compras ou consumo pago autorizado pela existência de orçamento. Preparar integração e instruções antes de uso faturável.
- Nenhum fornecedor, versão de dependência ou arquitetura está fechado só por aparecer como candidato no SDD. Verificar documentação atual ao escolher.

## Validação e entrega

Testar caminhos relevantes: persistência, exclusão, interrupção, permissão negada, falha de rede e limites de consumo. Registrar os testes realmente executados; áudio em Windows precisa de validação no ambiente correspondente. Atualizar roteiro e SDD quando uma decisão for aceita. Preservar alterações existentes e não mudar visibilidade, nome do repositório ou publicar o aplicativo sem pedido.

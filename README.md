# -gora

## Ágora — interlocutora intelectual por voz

Projeto para Windows com uma única tela futurista, conversas naturais sobre filosofia, política e religião, correções linguísticas discretas e memória revisável.

**Estado: especificação e protótipo demonstrativo. Ainda não há IA real conectada nem aplicativo instalado.**

### Experimentar a interface

1. Baixe o repositório em **Code → Download ZIP** e extraia a pasta.
2. Abra `prototype/agora.html` no navegador do Windows, ou execute `abrir-prototipo.cmd`.
3. Se a saudação não tocar, clique em **Ouvir saudação**.
4. Use **Escrever** para testar os exemplos. O ditado depende do navegador e pode enviar áudio ao serviço dele.

Os exemplos usam respostas fixas. Memórias e histórico ficam no navegador; exporte antes de limpar seus dados. Não forneça chaves de API ao protótipo.

### Documentação

- [Especificação completa — SDD](docs/SDD.md)
- [Etapas de implementação](docs/ROADMAP.md)
- [Instruções para a IA desenvolvedora](AGENTS.md)

### Direção aprovada

- Windows 10 x64 como ambiente de referência; aplicação e dados locais, modelo remoto inicialmente.
- Voz como principal interação, com texto alternativo e painéis laterais.
- Saudação ao abrir e escuta automática após autorização, apenas durante sessão ativa, com pausa visível.
- Fone como dispositivo principal; suporte também a caixas e microfone.
- Escolha de provedor, stack e instalador ainda pendentes; validar custo e latência antes de contratar.

### Próxima entrega

Transformar a referência visual em uma carcaça modular executável, com contratos de sessão, voz, modelo e memória. Depois conectar os serviços reais e validar conversa contínua e interrupções no Windows.

A sintaxe JavaScript do protótipo foi verificada. Áudio, microfone e aparência no equipamento real ainda precisam de validação. Este repositório não contém credenciais, gravações nem histórico de conversas.

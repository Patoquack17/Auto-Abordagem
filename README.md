https://www.loskatchorros.com.br/

# Auto-Abordagem
Auto Abordagem CVR


Auto Abordagem (MoonLoader / SA-MP)

Script para MoonLoader que automatiza o comando /abordagem em jogadores próximos.
Ele detecta automaticamente players perto do seu personagem e executa a abordagem respeitando cooldown e anti-spam, evitando flood no chat.

⚙️ Funcionamento

O script verifica constantemente os jogadores ao redor do seu personagem.
Quando um player entra na distância configurada, o script executa automaticamente:

/abordagem ID

Após a abordagem, o ID fica temporariamente registrado para evitar repetição imediata.

🧠 Sistema Anti-Spam

O script possui dois sistemas de controle:

Cooldown global: intervalo mínimo entre comandos (5 segundos).

Tempo de reabordagem: o mesmo jogador só pode ser abordado novamente após 5 minutos.

Isso evita flood no chat e mantém o comportamento mais natural.

📏 Distância de detecção

A abordagem só ocorre quando o jogador está dentro da distância configurada do seu personagem.

Padrão:

10 metros

Esse valor pode ser alterado facilmente no script.

⚡ Otimizações

Verificação rápida de jogadores próximos

Sistema de controle de IDs já abordados

Compatível com MoonLoader + SAMP.Events

Baixo impacto de performance

📦 Requisitos

GTA SA

SA-MP

MoonLoader

SAMPFUNCS

📥 Instalação

Baixe o arquivo .lua

Coloque na pasta:

GTA San Andreas/moonloader/

Inicie o jogo.

📝 Observação

O script apenas automatiza o comando /abordagem.
Ele depende das permissões e regras do servidor para funcionar corretamente.

https://www.loskatchorros.com.br/

# AUTO-PM PACOTE COMPLETO

#AUTO VIDA - COLETE (Qnd a vida ou colete chegar a nível 40 é disparado o comando  /usarkit /colete. Sempre andar com kit médico e colete é necessario ser vip!

#AUTO POLICIA

#AUTO ABORDAGEM CVR

!!!!!!


ATUALIZAÇÃO MAIS RECENTE

police_helperv2.lua
A Ultima atualização, integrado o sistema de Blacklist. N aborda o id que vc adicionar no /bladd evitando ta disparando comandos em player indesejado (amigo, outro policial na msm viatura)....

## CASO QUEIRA ADICIONAR MAIS COMANDOS, É SÓ REPETIR O CÓDIGO E MUDAR O /COMANDO EX: /VENDERVACINA /ASSALTAR.......

local actions = {

    { key = 0x31, cmd = '/abordagem',    msg = 'Abordando',          checkAbordado = true  },
    
    { key = 0x32, cmd = '/algemar',      msg = 'Algemando',          checkAbordado = false },
    
    { key = 0x33, cmd = '/prender',      msg = 'Prendendo',          checkAbordado = false },
    
    { key = 0x34, cmd = '/prenderArmas', msg = 'Prendendo armas de', checkAbordado = false },
    
    { key = 0x35, cmd = '/revistarcarga',msg = 'Revistando carga de',checkAbordado = false },
    
    { key = 0x36, cmd = '/prendercarga', msg = 'Prendendo carga de', checkAbordado = false },
}

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

SAMP.Events:
https://github.com/THE-FYP/SAMP.Lua?tab=readme-ov-file

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

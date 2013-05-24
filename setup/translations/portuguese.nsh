﻿;Language: Portuguese (2070)
;Portuguese language strings for the Windows SMPlayer NSIS installer.
;
;Save file as UTF-8 w/ BOM
;

!insertmacro LANGFILE "Portuguese" "Português"

; Startup
${LangFileString} Installer_Is_Running "O instalador já está em execução."
${LangFileString} Installer_No_Admin "Tem que iniciar a sessão como administrador para instalar este programa."
${LangFileString} SMPlayer_Is_Running "Já existe uma instância SMPlayer em execução. Feche o SMPlayer e tente novamente."

${LangFileString} OS_Not_Supported "O sistema operativo não é suportado.$\nO SMPlayer ${SMPLAYER_VERSION} requer, pelo menos, o Windows XP para funcionar corretamente.$\nQuer mesmo continuar com a instalação?"
${LangFileString} Win64_Required "Para instalar esta versão, tem que possuir um sistema de 64 bits."
${LangFileString} Existing_32bitInst "Já existe uma instalação 32 bits do SMPlayer. Tem que a desinstalar antes de efetuar uma nova instalação."
${LangFileString} Existing_64bitInst "Já existe uma instalação 64 bits do SMPlayer. Tem que a desinstalar antes de efetuar uma nova instalação."

; Welcome page
${LangFileString} WelcomePage_Title "$(^NameDA) Setup"
${LangFileString} WelcomePage_Text "Esta configuração irá ajuda-lo a instalar o $(^NameDA).$\r$\n$\r$\nÉ altamente recomendado o encerramento de quaisquer instâncias do SMPlayer antes de iniciar a instalação. Deste modo, será possível atualizar os ficheiros do programa sem ter que reiniciar o computador.$\r$\n$\r$\n$_CLICK"

; Components Page
${LangFileString} ShortcutGroupTitle "Atalhos"
${LangFileString} MPlayerGroupTitle "Componentes MPlayer"

${LangFileString} Section_SMPlayer "SMPlayer (obrigatório)"
${LangFileString} Section_SMPlayer_Desc "SMPlayer, bibliotecas partilhadas e documentação."

${LangFileString} Section_DesktopShortcut "Ambiente de trabalho"
${LangFileString} Section_DesktopShortcut_Desc "Cria um atalho para o SMPlayer no ambiente de trabalho."

${LangFileString} Section_StartMenu "Menu Iniciar"
${LangFileString} Section_StartMenu_Desc "Cria uma entrada no Menu Iniciar para o SMPlayer."

${LangFileString} Section_MPlayer "MPlayer (obrigatório)"
${LangFileString} Section_MPlayer_Desc "MPlayer; necessário para a reprodução."

${LangFileString} Section_MPlayerCodecs "Codificadores"
${LangFileString} Section_MPlayerCodecs_Desc "Codificadores opcionais para o MPlayer. (precisa de uma ligação à Internet)"

${LangFileString} Section_MEncoder_Desc "Um programa complementar ao MPlayer, utilizado para codificar ou converter emissões de vídeo e áudio."

${LangFileString} Section_IconThemes "Ícones"
${LangFileString} Section_IconThemes_Desc "Ícones adicionais para o SMPlayer."

${LangFileString} Section_Translations "Idiomas"
${LangFileString} Section_Translations_Desc "Idiomas adicionais para o SMPlayer."

${LangFileString} Section_ResetSettings_Desc "Deletes SMPlayer preferences leftover from previous installations."

${LangFileString} MPlayer_Codec_Msg "O pacote de codificadores adiciona suporte para os formatos que ainda não foram implementados no MPlayer, tais como as novas variantes RealVideo e outros formatos.$\nEstes codificadores não são necessários para os formatos mais comuns como DVDs, MPEG-1/2/4, etc."

; Upgrade/Reinstall Page
${LangFileString} Reinstall_Header_Text "Selecione o tipo de instalação"
${LangFileString} Reinstall_Header_SubText "Selecione o modo de substituição ou desinstalação."

${LangFileString} Reinstall_Msg1 "Você possui uma instalação do SMPlayer nesta pasta:"
${LangFileString} Reinstall_Msg2 "Por favor escolha o método a utilizar:"
${LangFileString} Reinstall_Overwrite "Substituir ($Inst_Type) a instalação existente"
${LangFileString} Reinstall_Uninstall "Desinstalar (remove) a instalação existente"
${LangFileString} Reinstall_Msg3_1 "Clique Iniciar para continuar."
${LangFileString} Reinstall_Msg3_2 "Clique Seguinte para continuar."
${LangFileString} Reinstall_Msg3_3 "Clique Desinstalar para continuar."
${LangFileString} Reinstall_Msg4 "Alterar definições de instalação"
${LangFileString} Reinstall_Msg5 "Reset my SMPlayer configuration"

${LangFileString} Type_Reinstall "Reinstalar"
${LangFileString} Type_Downgrade "Reverter"
${LangFileString} Type_Upgrade "Atualizar"

${LangFileString} StartBtn "Iniciar"

; Codecs Section
${LangFileString} Codecs_DL_Msg "A transferir os codificadores MPlayer..."
${LangFileString} Codecs_DL_Retry "Os codificadores MPlayer não foram instalados corretamente. Tentar novamente?"
${LangFileString} Codecs_DL_Failed "Falha ao transferir os codificadores MPlayer: '$R0'."
${LangFileString} Codecs_Inst_Failed "Falha ao instalar os codificadores MPlayer."

; Uninstaller
${LangFileString} Uninstaller_No_Admin "Esta aplicação só pode ser desinstalada no modo de administrador."
${LangFileString} Uninstaller_Aborted "Desinstalação cancelada pelo utilizador."
${LangFileString} Uninstaller_NotInstalled "Parece que o SMPlayer não está instalado no diretório '$INSTDIR'.$\r$\nContinuar (não recomendado)?"
${LangFileString} Uninstaller_64bitOnly "Esta instalação só pode ser desinstalada num sistema Windows de 64 bits."

; Vista & Later Default Programs Registration
${LangFileString} Application_Description "O SMPlayer é uma interface gráfico para o MPlayer, com funções simples como a reprodução de vídeos, DVDs e VCDs bem como outras mais avançadas(suporte a filtros MPlayer, listas e mais)."

; Misc
${LangFileString} Info_Codecs_Backup "A copiar codificadores da instalação anterior..."
${LangFileString} Info_Codecs_Restore "A restaurar codificadores da instalação anterior..."
${LangFileString} Info_Del_Files "A eliminar ficheiros..."
${LangFileString} Info_Del_Registry "A eliminar chaves de registo..."
${LangFileString} Info_Del_Shortcuts "A eliminar atalhos..."
${LangFileString} Info_Rest_Assoc "A restaurar as associações de ficheiros..."
${LangFileString} Info_RollBack "A reverter as alterações..."
${LangFileString} Info_Files_Extract "A extrair ficheiros..."

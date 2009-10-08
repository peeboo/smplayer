﻿;;
;;  Portuguese.nsh
;;
;;  Portuguese language strings for the Windows SMPlayer NSIS installer.
;;  Save file as UTF-8
;;

; Startup
LangString SMPLAYER_INSTALLER_IS_RUNNING ${LANG_PORTUGUESE} "The installer is already running."
LangString SMPLAYER_INSTALLER_PREV_ALL_USERS ${LANG_PORTUGUESE} "SMPlayer has been previously installed for all users.$\nPlease restart the installer with Administrator privileges."
LangString SMPLAYER_INSTALLER_PREV_VERSION ${LANG_PORTUGUESE} "SMPlayer has already been installed.$\nDo you want to remove the previous version before installing $(^Name)?"

; Components Page
LangString MPLAYER_CODEC_INFORMATION ${LANG_PORTUGUESE} "O pacote de codecs binários adiciona suporte para os codecs que ainda não foram implementados, tais como as novas variantes RealVideo e alguns formatos não usuais.$\nNote que estes não serão necessários para os formatos mais comuns como DVDs, MPEG-1/2/4, etc."

; MPlayer Section
LangString MPLAYER_IS_INSTALLED ${LANG_PORTUGUESE} "O MPlayer já está instalado. Re-Transferir?"
LangString MPLAYER_IS_DOWNLOADING ${LANG_PORTUGUESE} "Transferindo MPlayer..."
LangString MPLAYER_DL_FAILED ${LANG_PORTUGUESE} "Falha ao transferir MPlayer:"
LangString MPLAYER_INST_FAILED ${LANG_PORTUGUESE} "Falha ao instalar MPlayer. O MPlayer é necessário para reproduzir."

; Codecs Section
LangString CODECS_IS_INSTALLED ${LANG_PORTUGUESE} "Os codecs MPlayer já estão instalados. Re-Transferir?"
LangString CODECS_IS_DOWNLOADING ${LANG_PORTUGUESE} "Transferindo codecs MPlayer..."
LangString CODECS_DL_FAILED ${LANG_PORTUGUESE} "Falha ao transferir os codecs MPlayer:"
LangString CODECS_INST_FAILED ${LANG_PORTUGUESE} "Falha ao instalar os codecs MPlayer."

; Version information
LangString VERINFO_IS_DOWNLOADING ${LANG_PORTUGUESE} "Transferindo informações sobre a versão..."
LangString VERINFO_DL_FAILED ${LANG_PORTUGUESE} "Falha ao transferir informações sobre a versão:"
LangString VERINFO_IS_MISSING ${LANG_PORTUGUESE} "Informação sobre a versão em falta. A configuração irá utilizar a versão padrão."

; Uninstaller
LangString UNINSTALL_ABORTED ${LANG_PORTUGUESE} "Uninstall aborted by user."
LangString UNINSTALL_INSTALLED_ALL_USERS ${LANG_PORTUGUESE} "SMPlayer has been installed for all users.$\nPlease restart the uninstaller with Administrator privileges to remove it."
LangString SMPLAYER_NOT_INSTALLED ${LANG_PORTUGUESE} "It does not appear that SMPlayer is installed in the directory '$INSTDIR'.$\r$\nContinue anyway (not recommended)?"

; Vista & Later Default Programs Registration
LangString APPLICATION_DESCRIPTION ${LANG_PORTUGUESE} "SMPlayer is a complete front-end for MPlayer, from basic features like playing videos, DVDs, VCDs to more advanced features like support for MPlayer filters, edl lists, and more."
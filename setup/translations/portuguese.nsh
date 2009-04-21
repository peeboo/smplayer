;;
;;  Portuguese.nsh
;;
;;  Default language strings for the Windows SMPlayer NSIS installer.
;;
;;  Replace all text between the string with the translation.
;;
;;  Do not edit this line!
!insertmacro LANGFILE_EXT "Portuguese"
;;

; Components Page
${LangFileString} MPLAYER_CODEC_INFORMATION "O pacote de codecs bin�rios adiciona suporte para os codecs que ainda n�o foram implementados, tais como as novas variantes RealVideo e alguns formatos n�o usuais.$\nNote que estes n�o ser�o necess�rios para os formatos mais comuns como DVDs, MPEG-1/2/4, etc."

; MPlayer Section
${LangFileString} MPLAYER_IS_INSTALLED "O MPlayer j� est� instalado. Re-Transferir?"
${LangFileString} MPLAYER_IS_DOWNLOADING "Transferindo MPlayer..."
${LangFileString} MPLAYER_DL_FAILED "Falha ao transferir MPlayer:"
${LangFileString} MPLAYER_INST_FAILED "Falha ao instalar MPlayer. O MPlayer � necess�rio para reproduzir."

; Codecs Section
${LangFileString} CODECS_IS_INSTALLED "Os codecs MPlayer j� est�o instalados. Re-Transferir?"
${LangFileString} CODECS_IS_DOWNLOADING "Transferindo codecs MPlayer..."
${LangFileString} CODECS_DL_FAILED "Falha ao transferir os codecs MPlayer:"
${LangFileString} CODECS_INST_FAILED "Falha ao instalar os codecs MPlayer."

; Version information
${LangFileString} VERINFO_IS_DOWNLOADING "Transferindo informa��es sobre a vers�o..."
${LangFileString} VERINFO_DL_FAILED "Falha ao transferir informa��es sobre a vers�o:"
${LangFileString} VERINFO_IS_MISSING "Informa��o sobre a vers�o em falta. A configura��o ir� utilizar a vers�o padr�o."
;;
;;  german.nsh
;;
;;  German language strings for the Windows SMPlayer NSIS installer.
;;  Save file with ANSI encoding
;;
;;  Author: 
;;

; Startup
LangString SMPLAYER_INSTALLER_IS_RUNNING ${LANG_GERMAN} "Installationsprogramm l�uft bereits."
LangString SMPLAYER_INSTALLER_UNSUPPORTED_OS ${LANG_GERMAN} "Nicht unterst�tztes Betriebssystem.$\n$(^Name) ben�tigt mindestens Windows 2000 und funktioniert m�glicherweise nicht korrekt auf diesem System.$\nDie Installation wirklich fortsetzen?"
LangString SMPLAYER_INSTALLER_NO_ADMIN ${LANG_GERMAN} "Administratorrechte sind n�tig um dieses Programm zu installieren."
LangString SMPLAYER_INSTALLER_PREV_VERSION ${LANG_GERMAN} "SMPlayer ist bereits installiert.$\nVor der Installtion die vorherige Version l�schen $(^Name)?"

; Components Page
LangString MPLAYER_CODEC_INFORMATION ${LANG_GERMAN} "Bin�re Codec-Pakete werden eingesetzt f�r Codecs, die noch nicht nativ implementiert sind, wie neuere Varianten von RealVideo und viele ungew�hnliche Formate.$\nAchtung, nicht notwendig um die g�ngisten Formate wiederzugeben, wie DVD, MPEG-1/2/4 , etc."

; MPlayer Section
LangString MPLAYER_IS_INSTALLED ${LANG_GERMAN} "MPlayer ist bereits installiert. Erneut herunterladen?"
LangString MPLAYER_IS_DOWNLOADING ${LANG_GERMAN} "Lade MPlayer herunter..."
LangString MPLAYER_DL_FAILED ${LANG_GERMAN} "Fehler beim Herunterladen von MPlayer:"
LangString MPLAYER_INST_FAILED ${LANG_GERMAN} "Fehler beim Installieren von MPlayer. MPlayer ist erforderlich f�r die Wiedergabe."

; Codecs Section
LangString CODECS_IS_INSTALLED ${LANG_GERMAN} "MPlayer-Codecs sind bereits installiert. Erneut herunterladen?"
LangString CODECS_IS_DOWNLOADING ${LANG_GERMAN} "Lade MPlayer Codecs runter..."
LangString CODECS_DL_FAILED ${LANG_GERMAN} "Fehler beim Herunterladen der MPlayer Codecs:"
LangString CODECS_INST_FAILED ${LANG_GERMAN} "Fehler beim Installieren der MPlayer Codecs."

; Version information
LangString VERINFO_IS_DOWNLOADING ${LANG_GERMAN} "Lade Informationen der Version runter..."
LangString VERINFO_DL_FAILED ${LANG_GERMAN} "Fehler beim Herunterladen der Versionsinfo:"
LangString VERINFO_IS_MISSING ${LANG_GERMAN} "Versionsdatei fehlen Informationen �ber die Version. Setup nimmt Standardversion."

; Uninstaller
LangString UNINSTALL_NO_ADMIN ${LANG_GERMAN} "Administratorrechte sind n�tig um dieses Programm zu deinstallieren."
LangString SMPLAYER_NOT_INSTALLED ${LANG_GERMAN} "Es scheint, das SMPlayer nicht in dem Verzeichnis installiert ist '$INSTDIR'.$\r$\nTrotzdem fortfahren (nicht empfohlen)?"

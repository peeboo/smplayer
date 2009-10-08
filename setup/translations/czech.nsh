﻿;;
;;  czech.nsh
;;
;;  Czech language strings for the Windows SMPlayer NSIS installer.
;;  Save file as UTF-8
;;

; Startup
LangString SMPLAYER_INSTALLER_IS_RUNNING ${LANG_CZECH} "Instalátor již běží."
LangString SMPLAYER_INSTALLER_PREV_ALL_USERS ${LANG_CZECH} "SMPlayer byl minule nainstalován pro všechny uživatele.$\nProsím spusťte instalátor znovu s právy Administrátora."
LangString SMPLAYER_INSTALLER_PREV_VERSION ${LANG_CZECH} "SMPlayer je již nainstalován.$\nPřejete si odstranit předchozí verzi před spuštěním instalace $(^Name)?"

; Components Page
LangString MPLAYER_CODEC_INFORMATION ${LANG_CZECH} "Binární kodeky podporují formáty, které zatím nejsou implementovány nativne, napr. novejší varianty RealVideo a jiné málo používané formáty.$\nPro vetšinu bežných formátu nejsou potreba (DVD, MPEG-1/2/4, apod.)."

; MPlayer Section
LangString MPLAYER_IS_INSTALLED ${LANG_CZECH} "MPlayer je již nainstalován. Stáhnout znovu?"
LangString MPLAYER_IS_DOWNLOADING ${LANG_CZECH} "Stahuji MPlayer..."
LangString MPLAYER_DL_FAILED ${LANG_CZECH} "Nepovedlo se stáhnout MPlayer:"
LangString MPLAYER_INST_FAILED ${LANG_CZECH} "Nepovedlo se nainstalovat MPlayer. MPlayer je potrebný pro prehrávání."

; Codecs Section
LangString CODECS_IS_INSTALLED ${LANG_CZECH} "Kodeky MPlayeru jsou již nainstalovány. Stáhnout znovu?"
LangString CODECS_IS_DOWNLOADING ${LANG_CZECH} "Instaluji kodeky MPlayeru..."
LangString CODECS_DL_FAILED ${LANG_CZECH} "Nepovedlo se stáhnout kodeky MPlayeru:"
LangString CODECS_INST_FAILED ${LANG_CZECH} "Nepovedlo se nainstalovat kodeky MPlayeru."

; Version information
LangString VERINFO_IS_DOWNLOADING ${LANG_CZECH} "Stahuji informace o verzích..."
LangString VERINFO_DL_FAILED ${LANG_CZECH} "Nepovedlo se stáhnout informace o verzích:"
LangString VERINFO_IS_MISSING ${LANG_CZECH} "Verzovací soubor neobsahuje správné informace. Bude použita výchozí verze."

; Uninstaller
LangString UNINSTALL_ABORTED ${LANG_CZECH} "Odinstalace přerušena uživatelem."
LangString UNINSTALL_INSTALLED_ALL_USERS ${LANG_CZECH} "SMPlayer byl nainstalován pro všechny uživatele.$\nProsím spusťte odinstalátor znovu s právy Administrátora."
LangString SMPLAYER_NOT_INSTALLED ${LANG_CZECH} "V adresáři '$INSTDIR' není SMPlayer nainstalován .$\r$\nPokračovat (nedoporučeno)?"

; Vista & Later Default Programs Registration
LangString APPLICATION_DESCRIPTION ${LANG_CZECH} "SMPlayer je kompletní frontend pro MPlayer, podporuje vše od základních funkcí jako přehrávání videí, DVD, VCD až po pokročilé funkce jako filtry MPlayeru, edl a více."
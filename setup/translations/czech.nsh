;;
;;  czech.nsh
;;
;;  Czech language strings for the Windows SMPlayer NSIS installer.
;;  Save file with ANSI encoding
;;
;;  Author: 
;;

; Startup
LangString SMPLAYER_INSTALLER_IS_RUNNING ${LANG_CZECH} "Instal�tor ji� b��."
LangString SMPLAYER_INSTALLER_UNSUPPORTED_OS ${LANG_CZECH} "Nepodporovan� opre�n� syst�m.$\n$(^Name) vy�aduje alespo� Windows 2000 a nemusel by dob�e fungovat na va�em syst�mu.$\nOpravdu chcete pokra�ovat v instalaci?"
LangString SMPLAYER_INSTALLER_PREV_ALL_USERS ${LANG_CZECH} "SMPlayer byl minule nainstalov�n pro v�echny u�ivatele.$\nPros�m spus�te instal�tor znovu s pr�vy Administr�tora."
LangString SMPLAYER_INSTALLER_PREV_VERSION ${LANG_CZECH} "SMPlayer je ji� nainstalov�n.$\nP�ejete si odstranit p�edchoz� verzi p�ed spu�t�n�m instalace $(^Name)?"

; Components Page
LangString MPLAYER_CODEC_INFORMATION ${LANG_CZECH} "Bin�rn� kodeky podporuj� form�ty, kter� zat�m nejsou implementov�ny nativne, napr. novej�� varianty RealVideo a jin� m�lo pou��van� form�ty.$\nPro vet�inu be�n�ch form�tu nejsou potreba (DVD, MPEG-1/2/4, apod.)."

; MPlayer Section
LangString MPLAYER_IS_INSTALLED ${LANG_CZECH} "MPlayer je ji� nainstalov�n. St�hnout znovu?"
LangString MPLAYER_IS_DOWNLOADING ${LANG_CZECH} "Stahuji MPlayer..."
LangString MPLAYER_DL_FAILED ${LANG_CZECH} "Nepovedlo se st�hnout MPlayer:"
LangString MPLAYER_INST_FAILED ${LANG_CZECH} "Nepovedlo se nainstalovat MPlayer. MPlayer je potrebn� pro prehr�v�n�."

; Codecs Section
LangString CODECS_IS_INSTALLED ${LANG_CZECH} "Kodeky MPlayeru jsou ji� nainstalov�ny. St�hnout znovu?"
LangString CODECS_IS_DOWNLOADING ${LANG_CZECH} "Instaluji kodeky MPlayeru..."
LangString CODECS_DL_FAILED ${LANG_CZECH} "Nepovedlo se st�hnout kodeky MPlayeru:"
LangString CODECS_INST_FAILED ${LANG_CZECH} "Nepovedlo se nainstalovat kodeky MPlayeru."

; Version information
LangString VERINFO_IS_DOWNLOADING ${LANG_CZECH} "Stahuji informace o verz�ch..."
LangString VERINFO_DL_FAILED ${LANG_CZECH} "Nepovedlo se st�hnout informace o verz�ch:"
LangString VERINFO_IS_MISSING ${LANG_CZECH} "Verzovac� soubor neobsahuje spr�vn� informace. Bude pou�ita v�choz� verze."

; Uninstaller
LangString UNINSTALL_INSTALLED_ALL_USERS ${LANG_CZECH} "SMPlayer byl nainstalov�n pro v�echny u�ivatele.$\nPros�m spus�te odinstal�tor znovu s pr�vy Administr�tora."

; Vista & Later Default Programs Registration
LangString APPLICATION_DESCRIPTION ${LANG_CZECH} "SMPlayer je kompletn� frontend pro MPlayer, podporuje v�e od z�kladn�ch funkc� jako p�ehr�v�n� vide�, DVD, VCD a� po pokro�il� funkce jako filtry MPlayeru, edl a v�ce."
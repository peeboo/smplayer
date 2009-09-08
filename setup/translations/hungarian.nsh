;;
;;  hungarian.nsh
;;
;;  Hungarian language strings for the Windows SMPlayer NSIS installer.
;;  Save file with ANSI encoding
;;
;;  Author: 
;;

; Startup
LangString SMPLAYER_INSTALLER_IS_RUNNING ${LANG_HUNGARIAN} "A telep�to m�r fut."
LangString SMPLAYER_INSTALLER_UNSUPPORTED_OS ${LANG_HUNGARIAN} "Nem t�mogatott oper�ci�s rendszer.$\n$(^Name) legal�bb Windows 2000-et ig�nyel �s lehet, hogy nem fog megfeleloen muk�dni a rendszer�n.$\nBiztosan folytatni akarja a telep�t�st?"
LangString SMPLAYER_INSTALLER_NO_ADMIN ${LANG_HUNGARIAN} "Rendszergazdak�nt kell bejelentkeznie a program telep�t�s�hez."
LangString SMPLAYER_INSTALLER_PREV_VERSION ${LANG_HUNGARIAN} "Az SMPlayer m�r telep�tve van.$\nEl akarja t�vol�tani az elozo verzi�t $(^Name) telep�t�se elott?"

; Components Page
LangString MPLAYER_CODEC_INFORMATION ${LANG_HUNGARIAN} "A bin�ris kodek csomagok t�mogat�st ny�jtanak nat�van m�g nem t�mogatott kodekekhez, mint pl. az �jabb RealVideo vari�nsok �s sok ritka form�tum.$\nNem sz�ks�gesek a legt�bb gyakori form�tum lej�tsz�s�hoz, mint a DVD-k, MPEG-1/2/4, stb."

; MPlayer Section
LangString MPLAYER_IS_INSTALLED ${LANG_HUNGARIAN} "Az MPlayer m�r telep�tve van. �jra let�ltsem?"
LangString MPLAYER_IS_DOWNLOADING ${LANG_HUNGARIAN} "Az MPlayer let�lt�se..."
LangString MPLAYER_DL_FAILED ${LANG_HUNGARIAN} "Az MPlayer let�lt�se nem siker�lt:"
LangString MPLAYER_INST_FAILED ${LANG_HUNGARIAN} "Az MPlayer telep�t�se nem siker�lt. Az MPlayerre sz�ks�g van a lej�tsz�shoz."

; Codecs Section
LangString CODECS_IS_INSTALLED ${LANG_HUNGARIAN} "Az MPlayer kodekek m�r telep�tve vannak. �jra let�ltsem?"
LangString CODECS_IS_DOWNLOADING ${LANG_HUNGARIAN} "MPlayer kodekek let�lt�se..."
LangString CODECS_DL_FAILED ${LANG_HUNGARIAN} "Az MPlayer kodekek let�lt�se nem siker�lt:"
LangString CODECS_INST_FAILED ${LANG_HUNGARIAN} "Az MPlayer kodekek telep�t�se nem siker�lt."

; Version information
LangString VERINFO_IS_DOWNLOADING ${LANG_HUNGARIAN} "Verzi� inform�ci� let�lt�se..."
LangString VERINFO_DL_FAILED ${LANG_HUNGARIAN} "Verzi� inform�ci� let�lt�se nem siker�lt:"
LangString VERINFO_IS_MISSING ${LANG_HUNGARIAN} "A verzi� f�jlb�l hi�nyzik a verzi� inform�ci�. A telep�t� egy alap�rtelmezett verzi�t fog haszn�lni."

; Uninstaller
LangString UNINSTALL_NO_ADMIN ${LANG_HUNGARIAN} "A telep�t�s elt�vol�t�shoz rendszergazdai jogosults�g sz�ks�ges."
LangString UNINSTALL_ABORTED ${LANG_HUNGARIAN} "Az elt�vol�t�st a felhaszn�l� megszak�totta."
LangString SMPLAYER_NOT_INSTALLED ${LANG_HUNGARIAN} "Nem �gy n�z ki, mintha az SMPlayer ebbe a k�nyvt�rba lett volna telep�tve: '$INSTDIR'.$\r$\nM�gis folytassam (nem aj�nlott)?"

; Vista & Later Default Programs Registration
LangString APPLICATION_DESCRIPTION ${LANG_HUNGARIAN} "Az SMPlayer egy komplett fel�let az MPlayerhez, mindent t�mogat az alap funkci�kt�l kezdve, mint a vide�k, DVDk, VCDk lej�tsz�sa, halad� funkci�kig, mint az MPlayer sz�r�k, edl list�k �s m�g sok m�s."
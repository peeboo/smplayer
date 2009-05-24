;;
;;  hungarian.nsh
;;
;;  Hungarian language strings for the Windows SMPlayer NSIS installer.
;;  Save file with ANSI encoding
;;
;;  Author: 
;;

; Startup
LangString SMPLAYER_INSTALLER_IS_RUNNING ${LANG_HUNGARIAN} "The installer is already running."
LangString SMPLAYER_INSTALLER_UNSUPPORTED_OS ${LANG_HUNGARIAN} "Unsupported operating system.$\n$(^Name) requires at least Windows 2000 and may not work correctly on your system.$\nDo you really want to continue with the installation?"
LangString SMPLAYER_INSTALLER_NO_ADMIN ${LANG_HUNGARIAN} "You must be logged in as an administrator when installing this program."
LangString SMPLAYER_INSTALLER_PREV_VERSION ${LANG_HUNGARIAN} "SMPlayer has already been installed.$\nDo you want to remove the previous version before installing $(^Name)?"

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
LangString UNINSTALL_NO_ADMIN ${LANG_HUNGARIAN} "This installation can only be uninstalled by a user with administrator privileges."
LangString SMPLAYER_NOT_INSTALLED ${LANG_HUNGARIAN} "It does not appear that SMPlayer is installed in the directory '$INSTDIR'.$\r$\nContinue anyway (not recommended)?"
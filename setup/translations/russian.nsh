;;
;;  russian.nsh
;;
;;  Russian language strings for the Windows SMPlayer NSIS installer.
;;  Save file with ANSI encoding
;;
;;  Author: 
;;

; Startup
LangString SMPLAYER_INSTALLER_IS_RUNNING ${LANG_RUSSIAN} "��������� ��������� ��� ��������."
LangString SMPLAYER_INSTALLER_UNSUPPORTED_OS ${LANG_RUSSIAN} "���������������� ������������ �������.$\n$(^Name) ������� ��� ������� Windows 2000 � ����� ����������� �������� �� ����� �������.$\n�� ������������� ������ ���������� ���������?"
LangString SMPLAYER_INSTALLER_PREV_ALL_USERS ${LANG_RUSSIAN} "SMPlayer ��� ���������� ��������� ��� ���� �������������.$\n����������, ������������� ��������� ��������� � ������������ ��������������."
LangString SMPLAYER_INSTALLER_PREV_VERSION ${LANG_RUSSIAN} "SMPlayer ��� ����������.$\n�� ������ ������� ���������� ������ ����� ���������� $(^Name)?"

; Components Page
LangString MPLAYER_CODEC_INFORMATION ${LANG_RUSSIAN} "������ � ��������� �������� ��������� ��������� �������, �� ���������� � mplayer, ��������, RealVideo � ������ ������������� ��������.$\n�������� ��������, ��� ��� ������ �� ����� ��� ��������������� ����������� ������� �������� ����� DVD, MPEG-1/2/4 � �.�."

; MPlayer Section
LangString MPLAYER_IS_INSTALLED ${LANG_RUSSIAN} "MPlayer ��� ����������. ��������� ������?"
LangString MPLAYER_IS_DOWNLOADING ${LANG_RUSSIAN} "�������� MPlayer..."
LangString MPLAYER_DL_FAILED ${LANG_RUSSIAN} "�� ������� ��������� MPlayer:"
LangString MPLAYER_INST_FAILED ${LANG_RUSSIAN} "������ ��� ��������� MPlayer. MPlayer ��������� ��� ���������������."

; Codecs Section
LangString CODECS_IS_INSTALLED ${LANG_RUSSIAN} "�������� ������ ��� MPlayer ��� �����������. ��������� ������?"
LangString CODECS_IS_DOWNLOADING ${LANG_RUSSIAN} "�������� �������� ������� ��� MPlayer..."
LangString CODECS_DL_FAILED ${LANG_RUSSIAN} "�� ������� ��������� �������� ������ ��� MPlayer:"
LangString CODECS_INST_FAILED ${LANG_RUSSIAN} "������ ��� ��������� �������� ������� ��� MPlayer."

; Version information
LangString VERINFO_IS_DOWNLOADING ${LANG_RUSSIAN} "�������� ���������� � ������..."
LangString VERINFO_DL_FAILED ${LANG_RUSSIAN} "�� ������� ��������� ���������� � ������:"
LangString VERINFO_IS_MISSING ${LANG_RUSSIAN} "���� ������ �� �������� ������ ����������. ��������� ��������� ����� ������������ ������ �� ���������."

; Uninstaller
LangString UNINSTALL_ABORTED ${LANG_RUSSIAN} "�������� �������� �������������."
LangString UNINSTALL_INSTALLED_ALL_USERS ${LANG_RUSSIAN} "SMPlayer ���������� ��������� ��� ���� �������������.$\n����������, ������������� ��������� �������� � ������������ ��������������."
LangString SMPLAYER_NOT_INSTALLED ${LANG_RUSSIAN} "�� ������, ��� SMPlayer ���������� � ������� '$INSTDIR'.$\r$\n���������� �� ����� (�� �������������)?"

; Vista & Later Default Programs Registration
LangString APPLICATION_DESCRIPTION ${LANG_RUSSIAN} "SMPlayer - ����������� �������� ��� MPlayer, ������� �� ������� ������� ����� ��������������� �����������, DVD, VCD � ���������� ����� ������������ ����� ��������� �������� MPlayer, ������� � �.�."
﻿; Installer script for win32 SMPlayer
; Written by redxii (redxii@users.sourceforge.net)
; Tested/Developed with Unicode NSIS 2.46

!ifndef VER_MAJOR | VER_MINOR | VER_BUILD
  !error "Version information not defined (or incomplete). You must define: VER_MAJOR, VER_MINOR, VER_BUILD."
!endif

;--------------------------------
;Compressor

  SetCompressor /SOLID lzma
  SetCompressorDictSize 32

;--------------------------------
;Additional plugin folders

  !addplugindir .
  !addincludedir .

;--------------------------------
;Defines

!ifdef VER_REVISION
  !define SMPLAYER_VERSION "${VER_MAJOR}.${VER_MINOR}.${VER_BUILD}.${VER_REVISION}"
  !define SMPLAYER_PRODUCT_VERSION "${VER_MAJOR}.${VER_MINOR}.${VER_BUILD}.${VER_REVISION}"
!else ifndef VER_REVISION
  !define SMPLAYER_VERSION "${VER_MAJOR}.${VER_MINOR}.${VER_BUILD}"
  !define SMPLAYER_PRODUCT_VERSION "${VER_MAJOR}.${VER_MINOR}.${VER_BUILD}.0"
!endif

  !define SMPLAYER_APP_PATHS_KEY "Software\Microsoft\Windows\CurrentVersion\App Paths\smplayer.exe"
  !define SMPLAYER_REG_KEY "Software\SMPlayer"

  !define SMPLAYER_UNINST_EXE "uninst.exe"
  !define SMPLAYER_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMPlayer"

  ;Fallback versions
  ;These can be changed in the compiler, otherwise
  ;if not defined the values shown here will be used.
!ifndef DEFAULT_CODECS_VERSION
  !define DEFAULT_CODECS_VERSION "windows-essential-20071007"
!endif

!ifndef WITH_MPLAYER

  !ifndef DEFAULT_MPLAYER_VERSION
    !define DEFAULT_MPLAYER_VERSION "mplayer-svn-33216"
  !endif

!endif

  ;Version control
!ifndef VERSION_FILE_URL
  !define VERSION_FILE_URL "http://smplayer.sourceforge.net/mplayer-version-info"
!endif

;--------------------------------
;General

  ;Name and file
  Name "SMPlayer ${SMPLAYER_VERSION}"
  BrandingText "SMPlayer for Windows v${SMPLAYER_VERSION}"
!ifdef WITH_MPLAYER
  OutFile "smplayer-${SMPLAYER_VERSION}-win32.exe"
!else ifndef WITH_MPLAYER
  OutFile "smplayer-${SMPLAYER_VERSION}-webdl.exe"
!endif

  ;Version tab properties
  VIProductVersion "${SMPLAYER_PRODUCT_VERSION}"
  VIAddVersionKey "ProductName" "SMPlayer"
  VIAddVersionKey "ProductVersion" "${SMPLAYER_VERSION}"
  VIAddVersionKey "FileVersion" "${SMPLAYER_VERSION}"
  VIAddVersionKey "LegalCopyright" ""
!ifdef WITH_MPLAYER
  VIAddVersionKey "FileDescription" "SMPlayer Installer (Offline)"
!else ifndef WITH_MPLAYER
  VIAddVersionKey "FileDescription" "SMPlayer Installer (Web Downloader)"
!endif

  ;Default installation folder
  InstallDir "$PROGRAMFILES\SMPlayer"

  ;Get installation folder from registry if available
  InstallDirRegKey HKLM "${SMPLAYER_REG_KEY}" "Path"

  ;Vista+ XML manifest, does not affect older OSes
  RequestExecutionLevel admin

  ShowInstDetails show
  ShowUnInstDetails show

;--------------------------------
;Variables

  Var Codec_Version
  Var Dialog_Reinstall
  Var Inst_Type
  Var Is_Admin
!ifndef WITH_MPLAYER
  Var MPlayer_Version
!endif
  Var Previous_Version
  Var Previous_Version_State
  Var Reinstall_ChgSettings
  Var Reinstall_ChgSettings_State
  Var Reinstall_Message
  Var Reinstall_OverwriteButton
  Var Reinstall_OverwriteButton_State
  Var Reinstall_Uninstall
  Var Reinstall_UninstallButton
  Var Reinstall_UninstallButton_State
  Var SMPlayer_Path
  Var SMPlayer_StartMenuFolder
  Var UserName

;--------------------------------
;Interface Settings

  ;Installer/Uninstaller icons
  !define MUI_ICON "smplayer-orange-installer.ico"
  !define MUI_UNICON "smplayer-orange-uninstaller.ico"

  ; Misc
  !define MUI_WELCOMEFINISHPAGE_BITMAP "smplayer-orange-wizard.bmp"
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "smplayer-orange-wizard-un.bmp"
  !define MUI_ABORTWARNING

  ; License page
  !define MUI_LICENSEPAGE_RADIOBUTTONS

  ; Components page
  !define MUI_COMPONENTSPAGE_SMALLDESC

  ; Finish page
  !define MUI_FINISHPAGE_LINK "http://smplayer.sourceforge.net"
  !define MUI_FINISHPAGE_LINK_LOCATION "http://smplayer.sourceforge.net"
  !define MUI_FINISHPAGE_NOREBOOTSUPPORT
  !define MUI_FINISHPAGE_RUN $INSTDIR\smplayer.exe
  !define MUI_FINISHPAGE_RUN_NOTCHECKED
  !define MUI_FINISHPAGE_SHOWREADME $INSTDIR\Release_notes.txt
  !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED

  ;Language Selection Dialog Settings
  !define MUI_LANGDLL_REGISTRY_ROOT HKLM
  !define MUI_LANGDLL_REGISTRY_KEY "${SMPLAYER_UNINST_KEY}"
  !define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

  ;Memento Settings
  !define MEMENTO_REGISTRY_ROOT HKLM
  !define MEMENTO_REGISTRY_KEY "${SMPLAYER_REG_KEY}"

  ;Start Menu Settings
  !define MUI_STARTMENUPAGE_DEFAULTFOLDER "SMPlayer"
  !define MUI_STARTMENUPAGE_NODISABLE
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT HKLM
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "${SMPLAYER_UNINST_KEY}"
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "NSIS:StartMenu"

;--------------------------------
;Include Modern UI and functions

  !include MUI2.nsh
  !include FileFunc.nsh
  !include Memento.nsh
  !include nsDialogs.nsh
  !include Sections.nsh
  !include WinVer.nsh
  !include WordFunc.nsh

;--------------------------------
;Pages

  ;Install pages
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "smplayer-build\Copying.txt"

  #Upgrade/Reinstall
  Page custom PageReinstall PageReinstallLeave

  #Components
  !define MUI_PAGE_CUSTOMFUNCTION_PRE PageComponentsPre
  !insertmacro MUI_PAGE_COMPONENTS

  #Install Directory
  !define MUI_PAGE_CUSTOMFUNCTION_PRE PageDirectoryPre
  !insertmacro MUI_PAGE_DIRECTORY

  #Start Menu
  !define MUI_PAGE_CUSTOMFUNCTION_PRE PageStartMenuPre
  !insertmacro MUI_PAGE_STARTMENU "SMP_SMenu" $SMPlayer_StartMenuFolder

  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  ;Uninstall pages
  !define MUI_PAGE_CUSTOMFUNCTION_PRE un.ConfirmPagePre
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !define MUI_PAGE_CUSTOMFUNCTION_PRE un.FinishPagePre
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "Basque"
  !insertmacro MUI_LANGUAGE "Catalan"
  !insertmacro MUI_LANGUAGE "Czech"
  !insertmacro MUI_LANGUAGE "Danish"
  !insertmacro MUI_LANGUAGE "Dutch"
  !insertmacro MUI_LANGUAGE "Finnish"
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "German"
  !insertmacro MUI_LANGUAGE "Hebrew"
  !insertmacro MUI_LANGUAGE "Hungarian"
  !insertmacro MUI_LANGUAGE "Italian"
  !insertmacro MUI_LANGUAGE "Japanese"
  !insertmacro MUI_LANGUAGE "Korean"
  !insertmacro MUI_LANGUAGE "Norwegian"
  !insertmacro MUI_LANGUAGE "Polish"
  !insertmacro MUI_LANGUAGE "Portuguese"
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "SimpChinese"
  !insertmacro MUI_LANGUAGE "Slovak"
  !insertmacro MUI_LANGUAGE "Slovenian"
  !insertmacro MUI_LANGUAGE "Spanish"
  !insertmacro MUI_LANGUAGE "TradChinese"

; Custom translations for setup

  !insertmacro LANGFILE_INCLUDE "translations\english.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\basque.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\catalan.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\czech.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\danish.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\dutch.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\finnish.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\french.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\german.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\hebrew.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\hungarian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\italian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\japanese.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\korean.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\norwegian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\polish.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\portuguese.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\russian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\simpchinese.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\slovak.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\slovenian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\spanish.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\tradchinese.nsh"

;--------------------------------
;Reserve Files

  ;These files should be inserted before other files in the data block
  ;Keep these lines before any File command
  ;Only for solid compression (by default, solid compression is enabled for BZIP2 and LZMA)

  !insertmacro MUI_RESERVEFILE_LANGDLL
  ReserveFile "${NSISDIR}\Plugins\UserInfo.dll"

;--------------------------------
;Installer Sections

;--------------------------------
;Main SMPlayer files
Section $(Section_SMPlayer) SecSMPlayer

  SectionIn RO

  ${If} $Reinstall_Uninstall == 1

    ReadRegStr $R0 HKLM ${SMPLAYER_REG_KEY} "Path"

    ${If} $Reinstall_UninstallButton_State == 1
      Exec '"$R0\uninst.exe" /X'
      Quit
    ${ElseIf} $Reinstall_OverwriteButton_State == 1
      ${If} "$INSTDIR" == "$R0"
        ExecWait '"$R0\uninst.exe" /S /R _?=$R0'
      ${Else}
        ExecWait '"$R0\uninst.exe" /S /R'
      ${EndIf}
    ${EndIf}

  ${EndIf}

  SetOutPath "$INSTDIR"
  File "smplayer-build\*"

  ;SMPlayer docs
  SetOutPath "$INSTDIR\docs"
  File /r "smplayer-build\docs\*.*"

  ;Qt imageformats
  SetOutPath "$INSTDIR\imageformats"
  File /r "smplayer-build\imageformats\*.*"

  ;SMPlayer key shortcuts
  SetOutPath "$INSTDIR\shortcuts"
  File /r "smplayer-build\shortcuts\*.*"

  SetOutPath "$PLUGINSDIR"
  File 7za.exe

  ;Initialize to 0 if don't exist (based on error flag)
  ReadRegDWORD $R0 HKLM "${SMPLAYER_REG_KEY}" Installed_MPlayer
  ${If} ${Errors}
    WriteRegDWORD HKLM "${SMPLAYER_REG_KEY}" Installed_MPlayer 0x0
  ${EndIf}

  ReadRegDWORD $R0 HKLM "${SMPLAYER_REG_KEY}" Installed_Codecs
  ${If} ${Errors}
    WriteRegDWORD HKLM "${SMPLAYER_REG_KEY}" Installed_Codecs 0x0
  ${EndIf}

SectionEnd

;--------------------------------
;Shortcuts
SectionGroup $(ShortcutGroupTitle)

  ${MementoSection} $(Section_DesktopShortcut) SecDesktopShortcut

    SetOutPath "$INSTDIR"
    CreateShortCut "$DESKTOP\SMPlayer.lnk" "$INSTDIR\smplayer.exe"

  ${MementoSectionEnd}

  ${MementoSection} $(Section_StartMenu) SecStartMenuShortcut

    SetOutPath "$INSTDIR"
    !insertmacro MUI_STARTMENU_WRITE_BEGIN SMP_SMenu
      CreateDirectory "$SMPROGRAMS\$SMPlayer_StartMenuFolder"
      CreateShortCut "$SMPROGRAMS\$SMPlayer_StartMenuFolder\SMPlayer.lnk" "$INSTDIR\smplayer.exe"
      WriteINIStr    "$SMPROGRAMS\$SMPlayer_StartMenuFolder\SMPlayer on the Web.url" "InternetShortcut" "URL" "http://smplayer.sf.net"
      CreateShortCut "$SMPROGRAMS\$SMPlayer_StartMenuFolder\Uninstall SMPlayer.lnk" "$INSTDIR\${SMPLAYER_UNINST_EXE}"
    !insertmacro MUI_STARTMENU_WRITE_END

  ${MementoSectionEnd}

SectionGroupEnd

;--------------------------------
;MPlayer & MPlayer Codecs
SectionGroup $(MPlayerGroupTitle)

  Section $(Section_MPlayer) SecMPlayer

    SectionIn RO

!ifdef WITH_MPLAYER
    SetOutPath "$INSTDIR\mplayer"
    File /r "smplayer-build\mplayer\*.*"

    WriteRegDWORD HKLM "${SMPLAYER_REG_KEY}" Installed_MPlayer 0x1
!else ifndef WITH_MPLAYER
    AddSize 16800

    Call GetVerInfo

    /* Read from version-info
    If it was unable to download, set version to that defined in the
    beginning of the script. */
    ${If} ${FileExists} "$PLUGINSDIR\version-info"
      ReadINIStr $MPlayer_Version "$PLUGINSDIR\version-info" smplayer mplayer
    ${Else}
      StrCpy $MPlayer_Version ${DEFAULT_MPLAYER_VERSION}
    ${EndIf}

    retry_mplayer:

    DetailPrint $(MPlayer_DL_Msg)
    inetc::get /timeout 30000 /resume "" /banner $(MPlayer_DL_Msg) /caption $(MPlayer_DL_Msg) "http://downloads.sourceforge.net/smplayer/$MPlayer_Version.7z?big_mirror=0" \
    "$PLUGINSDIR\$MPlayer_Version.7z" /end
    Pop $R0
    StrCmp $R0 OK 0 check_mplayer

    DetailPrint $(Info_Files_Extract)
    nsExec::Exec '"$PLUGINSDIR\7za.exe" x "$PLUGINSDIR\$MPlayer_Version.7z" -y -o"$PLUGINSDIR"'

    CreateDirectory "$INSTDIR\mplayer"
    CopyFiles /SILENT "$PLUGINSDIR\$MPlayer_Version\*" "$INSTDIR\mplayer"

    check_mplayer:

    ${If} $R0 != "OK"
      DetailPrint $(MPlayer_DL_Failed)
    ${EndIf}

    IfFileExists "$INSTDIR\mplayer\mplayer.exe" mplayerInstSuccess mplayerInstFailed
      mplayerInstSuccess:
        WriteRegDWORD HKLM "${SMPLAYER_REG_KEY}" Installed_MPlayer 0x1
        Goto done
      mplayerInstFailed:
        MessageBox MB_RETRYCANCEL|MB_ICONEXCLAMATION $(MPlayer_DL_Retry) /SD IDCANCEL IDRETRY retry_mplayer
        Abort $(MPlayer_Inst_Failed)

    done:
!endif
  SectionEnd

  Section /o $(Section_MPlayerCodecs) SecCodecs

    AddSize 22300

    Call GetVerInfo

    /* Read from version-info
    If it was unable to download, set version to that defined in the
    beginning of the script. */
    ${If} ${FileExists} "$PLUGINSDIR\version-info"
      ReadINIStr $Codec_Version "$PLUGINSDIR\version-info" smplayer mplayercodecs
    ${Else}
      StrCpy $Codec_Version ${DEFAULT_CODECS_VERSION}
    ${EndIf}

    retry_codecs:

    DetailPrint $(Codecs_DL_Msg)
    inetc::get /timeout 30000 /resume "" /banner $(Codecs_DL_Msg) /caption $(Codecs_DL_Msg) "http://www.mplayerhq.hu/MPlayer/releases/codecs/$Codec_Version.zip" \
    "$PLUGINSDIR\$Codec_Version.zip" /end
    Pop $R0
    StrCmp $R0 OK 0 check_codecs

    DetailPrint $(Info_Files_Extract)
    nsExec::Exec '"$PLUGINSDIR\7za.exe" x "$PLUGINSDIR\$Codec_Version.zip" -y -o"$PLUGINSDIR"'

    CreateDirectory "$INSTDIR\mplayer\codecs"
    CopyFiles /SILENT "$PLUGINSDIR\$Codec_Version\*" "$INSTDIR\mplayer\codecs"

    check_codecs:

    ${If} $R0 != "OK"
      DetailPrint $(Codecs_DL_Failed)
    ${EndIf}

    IfFileExists "$INSTDIR\mplayer\codecs\*.dll" codecsInstSuccess codecsInstFailed
      codecsInstSuccess:
        WriteRegDWORD HKLM "${SMPLAYER_REG_KEY}" Installed_Codecs 0x1
        Goto done
      codecsInstFailed:
        MessageBox MB_RETRYCANCEL|MB_ICONEXCLAMATION $(Codecs_DL_Retry) /SD IDCANCEL IDRETRY retry_codecs
        DetailPrint $(Codecs_Inst_Failed)
        WriteRegDWORD HKLM "${SMPLAYER_REG_KEY}" Installed_Codecs 0x0
        Sleep 5000

    done:

	SectionEnd

SectionGroupEnd

;--------------------------------
;Icon themes
${MementoSection} $(Section_IconThemes) SecThemes

  SetOutPath "$INSTDIR\themes"
  File /r "smplayer-build\themes\*.*"

${MementoSectionEnd}

;--------------------------------
;Translations
SectionGroup $(Section_Translations) SecTranslations

  Section "English" SecLang_ENUS
    SectionIn RO

    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_en_US.qm"
  SectionEnd

  ${MementoSection} "العربية" SecLang_ARSY
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_ar_SY.qm"
  ${MementoSectionEnd}

  ${MementoSection} "български" SecLang_BG
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_bg.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Català" SecLang_CA
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_ca.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Čeština" SecLang_CS
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_cs.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Dansk" SecLang_DA
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_da.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Deutsch" SecLang_DE
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_de.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Ελληνικά" SecLang_ELGR
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_el_GR.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Español" SecLang_ES
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_es.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Eesti Keel" SecLang_ET
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_et.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Euskara" SecLang_EU
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_eu.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Suomi" SecLang_FI
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_fi.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Français" SecLang_FR
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_fr.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Galego" SecLang_GL
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_gl.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Magyar" SecLang_HU
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_hu.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Italiano" SecLang_IT
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_it.qm"
  ${MementoSectionEnd}

  ${MementoSection} "日本語" SecLang_JA
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_ja.qm"
  ${MementoSectionEnd}

  ${MementoSection} "ქართული" SecLang_KA
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_ka.qm"
  ${MementoSectionEnd}

  ${MementoSection} "한국어" SecLang_KO
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_ko.qm"
  ${MementoSectionEnd}

  ${MementoSection} "كوردی" SecLang_KU
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_ku.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Lietuvių" SecLang_LT
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_lt.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Mакедонски" SecLang_MK
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_mk.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Nederlands" SecLang_NL
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_nl.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Polski" SecLang_PL
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_pl.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Português" SecLang_PT
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_pt.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Português (Brasil)" SecLang_PTBR
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_pt_BR.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Română" SecLang_roRO
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_ro_RO.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Pусский" SecLang_ruRU
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_ru_RU.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Slovenčina" SecLang_SK
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_sk.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Slovenščina" SecLang_SLSI
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_sl_SI.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Cрпски" SecLang_SR
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_sr.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Svenska" SecLang_SV
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_sv.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Türkçe" SecLang_TR
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_tr.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Yкраїнська" SecLang_UKUA
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_uk_UA.qm"
  ${MementoSectionEnd}

  ${MementoSection} "Tiếng Việt" SecLang_VIVN
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_vi_VN.qm"
  ${MementoSectionEnd}

  ${MementoSection} "简体中文" SecLang_ZHCN
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_zh_CN.qm"
  ${MementoSectionEnd}

  ${MementoSection} "漢語(繁體)" SecLang_ZHTW
    SetOutPath "$INSTDIR\translations"
    File /r "smplayer-build\translations\smplayer_zh_TW.qm"
  ${MementoSectionEnd}

SectionGroupEnd

;--------------------------------
;Install/Uninstall information
Section -Post

  ;Uninstall file
  WriteUninstaller "$INSTDIR\${SMPLAYER_UNINST_EXE}"

  ;Store installed path & version
  WriteRegStr HKLM "${SMPLAYER_REG_KEY}" "Path" "$INSTDIR"
  WriteRegStr HKLM "${SMPLAYER_REG_KEY}" "Version" "${SMPLAYER_VERSION}"

  ;Allows user to use 'start smplayer.exe'
  WriteRegStr HKLM "${SMPLAYER_APP_PATHS_KEY}" "" "$INSTDIR\smplayer.exe"

  ;Default Programs Registration (Vista & later)
  ${If} ${AtLeastWinVista}
    Call RegisterDefaultPrograms
  ${EndIf}

  ;Registry Uninstall information
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "DisplayIcon" "$INSTDIR\smplayer.exe"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "DisplayVersion" "${SMPLAYER_VERSION}"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "HelpLink" "http://smplayer.berlios.de/forum"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "Publisher" "Ricardo Villalba"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "UninstallString" "$INSTDIR\${SMPLAYER_UNINST_EXE}"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "URLInfoAbout" "http://smplayer.sf.net"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "URLUpdateInfo" "http://smplayer.sf.net"
  WriteRegDWORD HKLM "${SMPLAYER_UNINST_KEY}" "NoModify" "1"
  WriteRegDWORD HKLM "${SMPLAYER_UNINST_KEY}" "NoRepair" "1"

SectionEnd

${MementoSectionDone}

;--------------------------------
;Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecSMPlayer} $(Section_SMPlayer_Desc)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktopShortcut} $(Section_DesktopShortcut_Desc)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecStartMenuShortcut} $(Section_StartMenu_Desc)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecMPlayer} $(Section_MPlayer_Desc)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCodecs} $(Section_MPlayerCodecs_Desc)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecThemes} $(Section_IconThemes_Desc)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecTranslations} $(Section_Translations_Desc)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Macros

!macro MacroAllExtensions _action
  !insertmacro ${_action} ".3gp"
  !insertmacro ${_action} ".ac3"
  !insertmacro ${_action} ".ape"
  !insertmacro ${_action} ".asf"
  !insertmacro ${_action} ".avi"
  !insertmacro ${_action} ".bin"
  !insertmacro ${_action} ".dat"
  !insertmacro ${_action} ".divx"
  !insertmacro ${_action} ".dv"
  !insertmacro ${_action} ".dvr-ms"
  !insertmacro ${_action} ".f4v"
  !insertmacro ${_action} ".flac"
  !insertmacro ${_action} ".flv"
  !insertmacro ${_action} ".hdmov"
  !insertmacro ${_action} ".iso"
  !insertmacro ${_action} ".m1v"
  !insertmacro ${_action} ".m2t"
  !insertmacro ${_action} ".m2ts"
  !insertmacro ${_action} ".m2v"
  !insertmacro ${_action} ".m3u"
  !insertmacro ${_action} ".m3u8"
  !insertmacro ${_action} ".m4v"
  !insertmacro ${_action} ".mkv"
  !insertmacro ${_action} ".mov"
  !insertmacro ${_action} ".mp3"
  !insertmacro ${_action} ".mp4"
  !insertmacro ${_action} ".mpeg"
  !insertmacro ${_action} ".mpg"
  !insertmacro ${_action} ".mpv"
  !insertmacro ${_action} ".mqv"
  !insertmacro ${_action} ".nsv"
  !insertmacro ${_action} ".ogg"
  !insertmacro ${_action} ".ogm"
  !insertmacro ${_action} ".ogv"
  !insertmacro ${_action} ".pls"
  !insertmacro ${_action} ".ra"
  !insertmacro ${_action} ".ram"
  !insertmacro ${_action} ".rec"
  !insertmacro ${_action} ".rm"
  !insertmacro ${_action} ".rmvb"
  !insertmacro ${_action} ".swf"
  !insertmacro ${_action} ".thd"
  !insertmacro ${_action} ".ts"
  !insertmacro ${_action} ".vcd"
  !insertmacro ${_action} ".vfw"
  !insertmacro ${_action} ".vob"
  !insertmacro ${_action} ".vp8"
  !insertmacro ${_action} ".wav"
  !insertmacro ${_action} ".webm"
  !insertmacro ${_action} ".wma"
  !insertmacro ${_action} ".wmv"
!macroend

!macro WriteRegStrSupportedTypes EXT
  WriteRegStr HKLM  "${SMPLAYER_REG_KEY}\Capabilities\FileAssociations" ${EXT} "MPlayerFileVideo"
!macroend

!macro MacroRemoveSMPlayer
  ;Delete desktop and start menu shortcuts
  SetDetailsPrint textonly
  DetailPrint $(Info_Del_Shortcuts)
  SetDetailsPrint listonly

  SetShellVarContext all
  Delete "$DESKTOP\SMPlayer.lnk"
  Delete "$SMPROGRAMS\$SMPlayer_StartMenuFolder\SMPlayer.lnk"
  Delete "$SMPROGRAMS\$SMPlayer_StartMenuFolder\SMPlayer on the Web.url"
  Delete "$SMPROGRAMS\$SMPlayer_StartMenuFolder\Uninstall SMPlayer.lnk"
  RMDir "$SMPROGRAMS\$SMPlayer_StartMenuFolder"

  ;Delete directories recursively except for main directory
  ;Do not recursively delete $INSTDIR
  SetDetailsPrint textonly
  DetailPrint $(Info_Del_Files)
  SetDetailsPrint listonly

  RMDir /r "$INSTDIR\docs"
  RMDir /r "$INSTDIR\imageformats"
  RMDir /r "$INSTDIR\mplayer"
  RMDir /r "$INSTDIR\shortcuts"
  RMDir /r "$INSTDIR\themes"
  RMDir /r "$INSTDIR\translations"
  Delete "$INSTDIR\*.txt"
  Delete "$INSTDIR\libgcc_s_dw2-1.dll"
  Delete "$INSTDIR\mingwm10.dll"
  Delete "$INSTDIR\Q*.dll"
  Delete "$INSTDIR\smplayer.exe"
  Delete "$INSTDIR\dxlist.exe"

  ;Delete registry keys
  SetDetailsPrint textonly
  DetailPrint $(Info_Del_Registry)
  SetDetailsPrint listonly

  DeleteRegKey HKLM "${SMPLAYER_REG_KEY}"
  DeleteRegKey HKLM "${SMPLAYER_APP_PATHS_KEY}"
  DeleteRegKey HKLM "${SMPLAYER_UNINST_KEY}"
  DeleteRegKey HKCR "MPlayerFileVideo"
  DeleteRegValue HKLM "Software\RegisteredApplications" "SMPlayer"

  SetDetailsPrint both
!macroend

;--------------------------------
;Installer functions

Function .onInit

  !ifdef PRE_RELEASE
    MessageBox MB_OK|MB_ICONINFORMATION "This is a pre-release version of SMPlayer. Please report all issues."
  !endif

  ;Check if setup is already running
  System::Call 'kernel32::CreateMutexW(i 0, i 0, t "SMPlayerSetup") i .r1 ?e'
  Pop $R0

  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION $(Installer_Is_Running)
    Abort

  ;Check for admin on older OSes
  Call CheckUserRights

  ${If} $Is_Admin == 0
    MessageBox MB_OK|MB_ICONSTOP $(Installer_No_Admin)
    Abort
  ${EndIf}

  Call LoadPreviousSettings

  ;Setup language selection
  !insertmacro MUI_LANGDLL_DISPLAY

  Call CheckPreviousVersion

  SetShellVarContext all

FunctionEnd

Function .onInstSuccess

  ${MementoSectionSave}

FunctionEnd

Function .onInstFailed

  SetDetailsPrint textonly
  DetailPrint "Rolling back changes..."
  SetDetailsPrint listonly

  !insertmacro MacroRemoveSMPlayer

  Delete "$INSTDIR\${SMPLAYER_UNINST_EXE}"
  RMDir "$INSTDIR"

FunctionEnd

Function CheckPreviousVersion

  ReadRegStr $Previous_Version HKLM "${SMPLAYER_REG_KEY}" "Version"
  ReadRegStr $SMPlayer_Path HKLM "${SMPLAYER_REG_KEY}" "Path"

  /* $Previous_Version_State Assignments:
  $Previous_Version_State=0  This installer is the same version as the installed copy
  $Previous_Version_State=1  A newer version than this installer is already installed
  $Previous_Version_State=2  An older version than this installer is already installed */
  ${VersionCompare} $Previous_Version ${SMPLAYER_VERSION} $Previous_Version_State

  ${If} $Previous_Version_State == 0
    StrCpy $Inst_Type $(Type_Reinstall)
  ${ElseIf} $Previous_Version_State == 1
    StrCpy $Inst_Type $(Type_Downgrade)
  ${ElseIf} $Previous_Version_State == 2
    StrCpy $Inst_Type $(Type_Upgrade)
  ${EndIf}

FunctionEnd

Function CheckUserRights

  ClearErrors
  UserInfo::GetName
  ${If} ${Errors}
    StrCpy $Is_Admin 1
    Return
  ${EndIf}

  Pop $UserName
  UserInfo::GetAccountType
  Pop $R0
  ${Switch} $R0
    ${Case} "Admin"
    ${Case} "Power"
      StrCpy $Is_Admin 1
      ${Break}
    ${Default}
      StrCpy $Is_Admin 0
      ${Break}
  ${EndSwitch}

FunctionEnd

Function GetVerInfo

  IfFileExists "$PLUGINSDIR\version-info" end_dl_ver_info 0
    DetailPrint $(VerInfo_DL_Msg)
    inetc::get /timeout 30000 /resume "" /silent ${VERSION_FILE_URL} "$PLUGINSDIR\version-info" /end
    Pop $R0
    StrCmp $R0 OK +2
      DetailPrint $(VerInfo_DL_Failed)

  end_dl_ver_info:

FunctionEnd

Function LoadPreviousSettings

  ;MPlayer codecs section doesn't use Memento so we need to restore it manually
  ReadRegDWORD $R0 HKLM "${SMPLAYER_REG_KEY}" "Installed_Codecs"
  ${If} $R0 == 1
    !insertmacro SelectSection ${SecCodecs}
  ${EndIf}

  ;Gets start menu folder name
  !insertmacro MUI_STARTMENU_GETFOLDER "SMP_SMenu" $SMPlayer_StartMenuFolder

  ${MementoSectionRestore}

FunctionEnd

Function PageReinstall

  ${If} $Previous_Version == ""
  ${OrIf} $SMPlayer_Path == ""
    Abort
  ${EndIf}

  nsDialogs::Create /NOUNLOAD 1018
  Pop $Dialog_Reinstall

  nsDialogs::SetRTL $(^RTL)

  !insertmacro MUI_HEADER_TEXT $(Reinstall_Header_Text) $(Reinstall_Header_SubText)

  ${NSD_CreateLabel} 0 0 225u 8u $(Reinstall_Msg1)

  ${NSD_CreateText} 10u 15u 290u 14u "$SMPlayer_Path"
  Pop $R0

  ${NSD_CreateLabel} 0 40u 100u 8u $(Reinstall_Msg2)

  ${NSD_CreateRadioButton} 10u 58u 200u 8u $(Reinstall_Overwrite)
  Pop $Reinstall_OverwriteButton
  ${NSD_CreateRadioButton} 10u 73u 200u 8u $(Reinstall_Uninstall)
  Pop $Reinstall_UninstallButton

  ${NSD_CreateCheckBox} 0 90u 100% 8u $(Reinstall_Msg4)
  Pop $Reinstall_ChgSettings

  ${NSD_CreateLabel} 0 115u 100% 16u 
  Pop $Reinstall_Message

  SendMessage $Reinstall_OverwriteButton ${BM_SETCHECK} 1 0
  EnableWindow $R0 0

  ${If} $Reinstall_ChgSettings_State == 1
    SendMessage $Reinstall_ChgSettings ${BM_SETCHECK} 1 0
  ${Endif}

  ${NSD_OnClick} $Reinstall_OverwriteButton PageReinstallUpdate
  ${NSD_OnClick} $Reinstall_UninstallButton PageReinstallUpdate
  ${NSD_OnClick} $Reinstall_ChgSettings PageReinstallUpdate

  Call PageReinstallUpdate

  StrCpy $Reinstall_Uninstall 1

  nsDialogs::Show

FunctionEnd

Function PageReinstallLeave

  ${NSD_GetState} $Reinstall_OverwriteButton $Reinstall_OverwriteButton_State
  ${NSD_GetState} $Reinstall_UninstallButton $Reinstall_UninstallButton_State
  ${NSD_GetState} $Reinstall_ChgSettings $Reinstall_ChgSettings_State

FunctionEnd

Function PageReinstallUpdate

  ${NSD_GetState} $Reinstall_OverwriteButton $Reinstall_OverwriteButton_State
  ${NSD_GetState} $Reinstall_UninstallButton $Reinstall_UninstallButton_State
  ${NSD_GetState} $Reinstall_ChgSettings $Reinstall_ChgSettings_State

  ${If} $Reinstall_OverwriteButton_State == 1

    EnableWindow $Reinstall_ChgSettings 1

    GetDlgItem $R0 $HWNDPARENT 1
    ${If} $Reinstall_ChgSettings_State != 1
      SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(StartBtn)"
      ${NSD_SetText} $Reinstall_Message $(Reinstall_Msg3_1)
    ${ElseIf} $Reinstall_ChgSettings_State == 1
      SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(^NextBtn)"
      ${NSD_SetText} $Reinstall_Message $(Reinstall_Msg3_2)
    ${EndIf}

  ${ElseIf} $Reinstall_UninstallButton_State == 1

    EnableWindow $Reinstall_ChgSettings 0
    ${NSD_SetState} $Reinstall_ChgSettings 0

    GetDlgItem $R0 $HWNDPARENT 1
    SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(^UninstallBtn)"

    ${NSD_SetText} $Reinstall_Message $(Reinstall_Msg3_3)

  ${EndIf}

FunctionEnd

Function PageComponentsPre

  ${If} $Reinstall_Uninstall == 1
  ${AndIf} $Reinstall_ChgSettings_State != 1
    Abort
  ${EndIf}

FunctionEnd

Function PageDirectoryPre

  ${If} $Reinstall_Uninstall == 1
  ${AndIf} $Reinstall_ChgSettings_State != 1
    Abort
  ${EndIf}

FunctionEnd

Function PageStartMenuPre

  ${If} $Reinstall_Uninstall == 1
  ${AndIf} $Reinstall_ChgSettings_State != 1
    Abort
  ${EndIf}

  ${IfNot} ${SectionIsSelected} ${SecStartMenuShortcut}
    Abort
  ${EndIf}

FunctionEnd

Function RegisterDefaultPrograms

  WriteRegStr HKCR "MPlayerFileVideo\DefaultIcon" "" '"$INSTDIR\smplayer.exe",1'
  WriteRegStr HKCR "MPlayerFileVideo\shell\enqueue" "" "Enqueue in SMPlayer"
  WriteRegStr HKCR "MPlayerFileVideo\shell\enqueue\command" "" '"$INSTDIR\smplayer.exe" -add-to-playlist "%1"'
  WriteRegStr HKCR "MPlayerFileVideo\shell\open" "FriendlyAppName" "SMPlayer Media Player"
  WriteRegStr HKCR "MPlayerFileVideo\shell\open\command" "" '"$INSTDIR\smplayer.exe" "%1"'

  ;Modify the list of extensions added in the MacroAllExtensions macro
  WriteRegStr HKLM "${SMPLAYER_REG_KEY}\Capabilities" "ApplicationDescription" $(Application_Description)
  WriteRegStr HKLM "${SMPLAYER_REG_KEY}\Capabilities" "ApplicationName" "SMPlayer"
  WriteRegStr HKLM "Software\RegisteredApplications" "SMPlayer" "${SMPLAYER_REG_KEY}\Capabilities"
  !insertmacro MacroAllExtensions WriteRegStrSupportedTypes

FunctionEnd

/*************************************** Uninstaller *******************************************/

Section Uninstall

  ;Make sure SMPlayer is installed from where the uninstaller is being executed.
  IfFileExists $INSTDIR\smplayer.exe smplayer_installed
    MessageBox MB_YESNO $(Uninstaller_NotInstalled) /SD IDNO IDYES smplayer_installed
    Abort $(Uninstaller_Aborted)

  smplayer_installed:

  SetDetailsPrint textonly
  DetailPrint $(Info_Rest_Assoc)
  SetDetailsPrint listonly

  ;Don't restore file associations if reinstalling
  ${un.GetParameters} $R0
  ${un.GetOptionsS} $R0 "/R" $R1

  IfErrors 0 +2
  ExecWait '"$INSTDIR\smplayer.exe" -uninstall'

  !insertmacro MacroRemoveSMPlayer

  Delete "$INSTDIR\${SMPLAYER_UNINST_EXE}"
  RMDir "$INSTDIR"

SectionEnd

;--------------------------------
;Required functions

!insertmacro un.GetParameters
!insertmacro un.GetOptions

;--------------------------------
;Uninstaller functions

Function un.onInit

  ;Check for admin (mimic old Inno Setup behavior)
  Call un.CheckUserRights

  ${If} $Is_Admin == 0
    MessageBox MB_OK|MB_ICONSTOP $(Uninstaller_No_Admin)
    Abort
  ${EndIf}

  ;Gets start menu folder name
  !insertmacro MUI_STARTMENU_GETFOLDER "SMP_SMenu" $SMPlayer_StartMenuFolder

  ;Get the stored language preference
  !insertmacro MUI_UNGETLANGUAGE

FunctionEnd

Function un.CheckUserRights

  ClearErrors
  UserInfo::GetName
  ${If} ${Errors}
    StrCpy $Is_Admin 1
    Return
  ${EndIf}

  Pop $UserName
  UserInfo::GetAccountType
  Pop $R0
  ${Switch} $R0
    ${Case} "Admin"
    ${Case} "Power"
      StrCpy $Is_Admin 1
      ${Break}
    ${Default}
      StrCpy $Is_Admin 0
      ${Break}
  ${EndSwitch}

FunctionEnd

Function un.ConfirmPagePre

  ${un.GetParameters} $R0

  ${un.GetOptionsS} $R0 "/X" $R1
  ${Unless} ${Errors}
    Abort
  ${EndUnless}

FunctionEnd

Function un.FinishPagePre

  ${un.GetParameters} $R0

  ${un.GetOptionsS} $R0 "/X" $R1
  ${Unless} ${Errors}
    Abort
  ${EndUnless}

FunctionEnd
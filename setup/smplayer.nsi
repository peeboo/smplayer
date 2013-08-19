﻿;Installer script for win32/win64 SMPlayer
;Written by redxii (redxii@users.sourceforge.net)
;Tested/Developed with Unicode NSIS 2.46.5

!ifndef VER_MAJOR | VER_MINOR | VER_BUILD
  !error "Version information not defined (or incomplete). You must define: VER_MAJOR, VER_MINOR, VER_BUILD."
!endif

!ifdef WIN64
  !define DISABLE_CODECS
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

!ifdef WIN64
  !define SMPLAYER_BUILD_DIR "smplayer-build64"
!else
  !define SMPLAYER_BUILD_DIR "smplayer-build"
!endif

  !define SMPLAYER_REG_KEY "Software\SMPlayer"
  !define SMPLAYER_APP_PATHS_KEY "Software\Microsoft\Windows\CurrentVersion\App Paths\smplayer.exe"
  !define SMPLAYER_DEF_PROGS_KEY "Software\Clients\Media\SMPlayer"

  !define SMPLAYER_UNINST_EXE "uninst.exe"
  !define SMPLAYER_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMPlayer"

  !define CODEC_VERSION "windows-essential-20071007"

;--------------------------------
;General

  ;Name and file
  Name "SMPlayer ${SMPLAYER_VERSION}"
  BrandingText "SMPlayer for Windows v${SMPLAYER_VERSION}"
!ifdef WIN64
  OutFile "output\smplayer-${SMPLAYER_VERSION}-x64.exe"
!else
  OutFile "output\smplayer-${SMPLAYER_VERSION}-win32.exe"
!endif

  ;Version tab properties
  VIProductVersion "${SMPLAYER_PRODUCT_VERSION}"
  VIAddVersionKey "ProductName" "SMPlayer"
  VIAddVersionKey "ProductVersion" "${SMPLAYER_VERSION}"
  VIAddVersionKey "FileVersion" "${SMPLAYER_VERSION}"
  VIAddVersionKey "LegalCopyright" ""
!ifdef WIN64
  VIAddVersionKey "FileDescription" "SMPlayer Installer (64-bit)"
!else
  VIAddVersionKey "FileDescription" "SMPlayer Installer (32-bit)"
!endif

  ;Default installation folder
!ifdef WIN64
  InstallDir "$PROGRAMFILES64\SMPlayer"
!else
  InstallDir "$PROGRAMFILES\SMPlayer"
!endif

  ;Get installation folder from registry if available
  InstallDirRegKey HKLM "${SMPLAYER_REG_KEY}" "Path"

  ;Vista+ XML manifest, does not affect older OSes
  RequestExecutionLevel admin

  ShowInstDetails show
  ShowUnInstDetails show

;--------------------------------
;Variables

  Var Dialog_Reinstall
  Var Inst_Type
  Var Previous_Version
  Var Previous_Version_State
  Var Reinstall_ChgSettings
  Var Reinstall_ChgSettings_State
  Var Reinstall_Message
  Var Reinstall_OverwriteButton
  Var Reinstall_OverwriteButton_State
  Var Reinstall_RemoveSettings
  Var Reinstall_RemoveSettings_State
  Var Reinstall_Uninstall
  Var Reinstall_UninstallButton
  Var Reinstall_UninstallButton_State
!ifndef DISABLE_CODECS
  Var Restore_Codecs
!endif
  Var SMPlayer_Path
  Var SMPlayer_UnStrPath
  Var SMPlayer_StartMenuFolder

;--------------------------------
;Interface Settings

  ;Installer/Uninstaller icons
  !define MUI_ICON "smplayer-orange-installer.ico"
  !define MUI_UNICON "smplayer-orange-uninstaller.ico"

  ;Misc
  !define MUI_WELCOMEFINISHPAGE_BITMAP "smplayer-orange-wizard.bmp"
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "smplayer-orange-wizard-un.bmp"
  !define MUI_ABORTWARNING

  ;Welcome page
  !define MUI_WELCOMEPAGE_TITLE $(WelcomePage_Title)
  !define MUI_WELCOMEPAGE_TEXT $(WelcomePage_Text)

  ;License page
  !define MUI_LICENSEPAGE_RADIOBUTTONS

  ;Components page
  !define MUI_COMPONENTSPAGE_SMALLDESC

  ;Finish page
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
  !include x64.nsh

;--------------------------------
;Pages

  ;Install pages
  #Welcome
  !insertmacro MUI_PAGE_WELCOME

  #License
  !insertmacro MUI_PAGE_LICENSE "license.txt"

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
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "Basque"
  !insertmacro MUI_LANGUAGE "Catalan"
  !insertmacro MUI_LANGUAGE "Croatian"
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
  !insertmacro MUI_LANGUAGE "Thai"
  !insertmacro MUI_LANGUAGE "TradChinese"

;Custom translations for setup

  !insertmacro LANGFILE_INCLUDE "translations\english.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\basque.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\catalan.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\croatian.nsh"
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
  !insertmacro LANGFILE_INCLUDE "translations\thai.nsh"
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

    ${If} $Reinstall_UninstallButton_State == 1
      Exec '"$SMPlayer_UnStrPath" /X'
      Quit
    ${ElseIf} $Reinstall_OverwriteButton_State == 1

!ifndef DISABLE_CODECS
      Call Backup_Codecs
!endif

      ${If} "$INSTDIR" == "$SMPlayer_Path"
        ExecWait '"$SMPlayer_UnStrPath" /S /R _?=$SMPlayer_Path'
      ${Else}
        ExecWait '"$SMPlayer_UnStrPath" /S /R'
      ${EndIf}

      Sleep 2500

    ${EndIf}

  ${EndIf}

  SetOutPath "$INSTDIR"
  File "${SMPLAYER_BUILD_DIR}\*"

  ;SMPlayer docs
  SetOutPath "$INSTDIR\docs"
  File /r "${SMPLAYER_BUILD_DIR}\docs\*.*"

  ;Qt imageformats
  SetOutPath "$INSTDIR\imageformats"
  File /r "${SMPLAYER_BUILD_DIR}\imageformats\*.*"

  ;SMPlayer key shortcuts
  SetOutPath "$INSTDIR\shortcuts"
  File /r "${SMPLAYER_BUILD_DIR}\shortcuts\*.*"

!ifndef DISABLE_CODECS
  SetOutPath "$PLUGINSDIR"
  File 7za.exe
!endif

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
      CreateShortCut "$SMPROGRAMS\$SMPlayer_StartMenuFolder\SMTube.lnk" "$INSTDIR\smtube.exe"
      WriteINIStr    "$SMPROGRAMS\$SMPlayer_StartMenuFolder\SMPlayer on the Web.url" "InternetShortcut" "URL" "http://smplayer.sourceforge.net"
      CreateShortCut "$SMPROGRAMS\$SMPlayer_StartMenuFolder\Uninstall SMPlayer.lnk" "$INSTDIR\${SMPLAYER_UNINST_EXE}"
    !insertmacro MUI_STARTMENU_WRITE_END

  ${MementoSectionEnd}

SectionGroupEnd

;--------------------------------
;MPlayer & MPlayer Codecs
SectionGroup $(MPlayerGroupTitle)

  Section $(Section_MPlayer) SecMPlayer

    SectionIn RO

    SetOutPath "$INSTDIR\mplayer"
    File /r /x mplayer.exe /x mencoder.exe /x mplayer64.exe /x mencoder64.exe "${SMPLAYER_BUILD_DIR}\mplayer\*.*"
!ifdef WIN64
    File /oname=mplayer.exe "${SMPLAYER_BUILD_DIR}\mplayer\mplayer64.exe"
!else
    File "${SMPLAYER_BUILD_DIR}\mplayer\mplayer.exe"
!endif

    WriteRegDWORD HKLM "${SMPLAYER_REG_KEY}" Installed_MPlayer 0x1

  SectionEnd

!ifndef DISABLE_CODECS
  Section /o $(Section_MPlayerCodecs) SecCodecs

    AddSize 22931

    ${If} $Restore_Codecs == 1
      DetailPrint $(Info_Codecs_Restore)
      CopyFiles /SILENT "$PLUGINSDIR\codecbak\*" "$INSTDIR\mplayer\codecs"
      Goto check_codecs
    ${ElseIf} ${FileExists} "$EXEDIR\${CODEC_VERSION}.zip"
      CopyFiles /SILENT "$EXEDIR\${CODEC_VERSION}.zip" "$PLUGINSDIR"
      Goto extract_codecs
    ${EndIf}

    retry_codecs_dl:

    DetailPrint $(Codecs_DL_Msg)
!ifdef USE_INETC
    inetc::get /CONNECTTIMEOUT 15000 /RESUME "" /BANNER $(Codecs_DL_Msg) /CAPTION $(Codecs_DL_Msg) \
    "http://www.mplayerhq.hu/MPlayer/releases/codecs/${CODEC_VERSION}.zip" \
    "$PLUGINSDIR\${CODEC_VERSION}.zip" /END
    Pop $R0
    StrCmp $R0 OK +4 0
!else
    NSISdl::download /TIMEOUT=15000 \
    "http://www.mplayerhq.hu/MPlayer/releases/codecs/${CODEC_VERSION}.zip" \
    "$PLUGINSDIR\${CODEC_VERSION}.zip" /END
    Pop $R0
    StrCmp $R0 "success" +4 0
!endif
      DetailPrint $(Codecs_DL_Failed)
      MessageBox MB_RETRYCANCEL|MB_ICONEXCLAMATION $(Codecs_DL_Retry) /SD IDCANCEL IDRETRY retry_codecs_dl
      Goto check_codecs

    extract_codecs:

    DetailPrint $(Info_Files_Extract)
    nsExec::Exec '"$PLUGINSDIR\7za.exe" x "$PLUGINSDIR\${CODEC_VERSION}.zip" -y -o"$PLUGINSDIR"'

    CreateDirectory "$INSTDIR\mplayer\codecs"
    CopyFiles /SILENT "$PLUGINSDIR\${CODEC_VERSION}\*" "$INSTDIR\mplayer\codecs"

    check_codecs:

    IfFileExists "$INSTDIR\mplayer\codecs\*.dll" 0 codecsInstFailed
        WriteRegDWORD HKLM "${SMPLAYER_REG_KEY}" Installed_Codecs 0x1
        Goto done
      codecsInstFailed:
        DetailPrint $(Codecs_Inst_Failed)
        WriteRegDWORD HKLM "${SMPLAYER_REG_KEY}" Installed_Codecs 0x0
        Sleep 5000

    done:

  SectionEnd
!endif

SectionGroupEnd

;--------------------------------
;Icon themes
${MementoSection} $(Section_IconThemes) SecThemes

  SetOutPath "$INSTDIR\themes"
  File /r "${SMPLAYER_BUILD_DIR}\themes\*.*"

${MementoSectionEnd}

;--------------------------------
;Translations
${MementoSection} $(Section_Translations) SecTranslations

  SetOutPath "$INSTDIR\translations"
  File /r "${SMPLAYER_BUILD_DIR}\translations\*.*"

${MementoSectionEnd}

Section /o $(Reinstall_Msg5) SecResetSettings

    NsExec::Exec '"$INSTDIR\smplayer.exe" -delete-config'

SectionEnd

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
  WriteRegStr HKLM "${SMPLAYER_APP_PATHS_KEY}" "Path" "$INSTDIR"

  ;Default Programs Registration (Vista & later)
  ${If} ${AtLeastWinVista}
    Call RegisterDefaultPrograms
  ${EndIf}

  ;Registry Uninstall information
!ifdef WIN64
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "DisplayName" "$(^Name) (x64)"
!else
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "DisplayName" "$(^Name)"
!endif
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "DisplayIcon" "$INSTDIR\smplayer.exe"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "DisplayVersion" "${SMPLAYER_VERSION}"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "HelpLink" "http://forum.smplayer.info"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "Publisher" "Ricardo Villalba"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "UninstallString" "$INSTDIR\${SMPLAYER_UNINST_EXE}"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "URLInfoAbout" "http://smplayer.sourceforge.net"
  WriteRegStr HKLM "${SMPLAYER_UNINST_KEY}" "URLUpdateInfo" "http://smplayer.sourceforge.net"
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
!ifndef DISABLE_CODECS
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCodecs} $(Section_MPlayerCodecs_Desc)
!endif
  !insertmacro MUI_DESCRIPTION_TEXT ${SecThemes} $(Section_IconThemes_Desc)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecTranslations} $(Section_Translations_Desc)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecResetSettings} $(Section_ResetSettings_Desc)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Macros

!macro MacroAllExtensions _action
  !insertmacro ${_action} ".3gp"
  !insertmacro ${_action} ".aac"
  !insertmacro ${_action} ".ac3"
  !insertmacro ${_action} ".ape"
  !insertmacro ${_action} ".asf"
  !insertmacro ${_action} ".avi"
  !insertmacro ${_action} ".bik"
  !insertmacro ${_action} ".bin"
  !insertmacro ${_action} ".dat"
  !insertmacro ${_action} ".divx"
  !insertmacro ${_action} ".dts"
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
  !insertmacro ${_action} ".mts"
  !insertmacro ${_action} ".m2v"
  !insertmacro ${_action} ".m3u"
  !insertmacro ${_action} ".m3u8"
  !insertmacro ${_action} ".m4a"
  !insertmacro ${_action} ".m4v"
  !insertmacro ${_action} ".mka"
  !insertmacro ${_action} ".mkv"
  !insertmacro ${_action} ".mov"
  !insertmacro ${_action} ".mp3"
  !insertmacro ${_action} ".mp4"
  !insertmacro ${_action} ".mpeg"
  !insertmacro ${_action} ".mpg"
  !insertmacro ${_action} ".mpv"
  !insertmacro ${_action} ".mqv"
  !insertmacro ${_action} ".nsv"
  !insertmacro ${_action} ".oga"
  !insertmacro ${_action} ".ogg"
  !insertmacro ${_action} ".ogm"
  !insertmacro ${_action} ".ogv"
  !insertmacro ${_action} ".ogx"
  !insertmacro ${_action} ".pls"
  !insertmacro ${_action} ".ra"
  !insertmacro ${_action} ".ram"
  !insertmacro ${_action} ".rec"
  !insertmacro ${_action} ".rm"
  !insertmacro ${_action} ".rmvb"
  !insertmacro ${_action} ".smk"
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
  !insertmacro ${_action} ".wtv"
!macroend

!macro WriteRegStrSupportedTypes EXT
  WriteRegStr HKLM  "${SMPLAYER_DEF_PROGS_KEY}\Capabilities\FileAssociations" ${EXT} "MPlayerFileVideo"
!macroend

!macro MacroRemoveSMPlayer
  ;Delete desktop and start menu shortcuts
  SetDetailsPrint textonly
  DetailPrint $(Info_Del_Shortcuts)
  SetDetailsPrint listonly

  SetShellVarContext all
  Delete "$DESKTOP\SMPlayer.lnk"
  Delete "$SMPROGRAMS\$SMPlayer_StartMenuFolder\SMPlayer.lnk"
  Delete "$SMPROGRAMS\$SMPlayer_StartMenuFolder\SMTube.lnk"
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
  Delete "$INSTDIR\libwinpthread-1.dll"
  Delete "$INSTDIR\mingwm10.dll"
  Delete "$INSTDIR\zlib1.dll"
  Delete "$INSTDIR\Qt*.dll"
  Delete "$INSTDIR\sample.avi"
  Delete "$INSTDIR\smplayer.exe"
  Delete "$INSTDIR\smtube.exe"
  Delete "$INSTDIR\dxlist.exe"

  ;Delete registry keys
  SetDetailsPrint textonly
  DetailPrint $(Info_Del_Registry)
  SetDetailsPrint listonly

  DeleteRegKey HKLM "${SMPLAYER_REG_KEY}"
  DeleteRegKey HKLM "${SMPLAYER_APP_PATHS_KEY}"
  DeleteRegKey HKLM "${SMPLAYER_DEF_PROGS_KEY}"
  DeleteRegKey HKLM "${SMPLAYER_UNINST_KEY}"
  DeleteRegKey HKCR "MPlayerFileVideo"
  DeleteRegValue HKLM "Software\RegisteredApplications" "SMPlayer"

  SetDetailsPrint both
!macroend

;--------------------------------
;Shared functions

!ifdef USE_RUNCHECK
!macro RunCheckMacro UN
Function ${UN}RunCheck

    retry_runcheck:
    FindWindow $0 "QWidget" "SMPlayer"
    StrCmp $0 0 notRunning
      MessageBox MB_RETRYCANCEL|MB_ICONEXCLAMATION $(SMPlayer_Is_Running) /SD IDCANCEL IDRETRY retry_runcheck
      Abort
    notrunning:

FunctionEnd
!macroend
!insertmacro RunCheckMacro ""
!insertmacro RunCheckMacro "un."
!endif

;--------------------------------
;Installer functions

Function .onInit

  ${Unless} ${AtLeastWinXP}
    MessageBox MB_YESNO|MB_ICONSTOP $(OS_Not_Supported) /SD IDNO IDYES installonoldwindows
    Abort
  installonoldwindows:
  ${EndIf}

!ifdef WIN64
  ${IfNot} ${RunningX64}
    MessageBox MB_OK|MB_ICONSTOP $(Win64_Required)
    Abort
  ${EndIf}

  SetRegView 32
  ClearErrors
  ReadRegStr $R0 HKLM "${SMPLAYER_UNINST_KEY}" "UninstallString"

  IfErrors +3 0
    MessageBox MB_OK|MB_ICONSTOP $(Existing_32bitInst)
    Abort

  SetRegView 64
!else
  ${If} ${RunningX64}
    SetRegView 64
    ClearErrors
    ReadRegStr $R0 HKLM "${SMPLAYER_UNINST_KEY}" "UninstallString"

    IfErrors +3 0
      MessageBox MB_OK|MB_ICONSTOP $(Existing_64bitInst)
      Abort

    SetRegView 32
  ${EndIf}
!endif

  ;Check if setup is already running
  System::Call 'kernel32::CreateMutexW(i 0, i 0, t "SMPlayerSetup") i .r1 ?e'
  Pop $R0

  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION $(Installer_Is_Running)
    Abort

!ifdef USE_RUNCHECK
  ;Check if SMPlayer is running
  ;Allow skipping check using /NORUNCHECK
  ${GetParameters} $R0
  ${GetOptions} $R0 "/NORUNCHECK" $R1
  IfErrors 0 +2
    Call RunCheck
!endif

  ;Check for admin on < Vista
  UserInfo::GetAccountType
  Pop $R0
  ${If} $R0 != "admin"
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
  DetailPrint $(Info_RollBack)
  SetDetailsPrint listonly

  !insertmacro MacroRemoveSMPlayer

  Delete "$INSTDIR\${SMPLAYER_UNINST_EXE}"
  RMDir "$INSTDIR"

FunctionEnd

Function CheckPreviousVersion

  ClearErrors
  ReadRegStr $Previous_Version HKLM "${SMPLAYER_REG_KEY}" "Version"
  ReadRegStr $SMPlayer_UnStrPath HKLM "${SMPLAYER_UNINST_KEY}" "UninstallString"
  ReadRegStr $SMPlayer_Path HKLM "${SMPLAYER_REG_KEY}" "Path"

  ${IfNot} ${Errors}
    StrCpy $Reinstall_Uninstall 1
  ${EndIf}

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

!ifndef DISABLE_CODECS
Function Backup_Codecs

  ${IfNot} ${SectionIsSelected} ${SecCodecs}
    Return
  ${EndIf}

  IfFileExists "$SMPlayer_Path\mplayer\codecs\*.dll" 0 NoBackup
    DetailPrint $(Info_Codecs_Backup)
    CreateDirectory "$PLUGINSDIR\codecbak"
    CopyFiles /SILENT "$SMPlayer_Path\mplayer\codecs\*" "$PLUGINSDIR\codecbak"
    StrCpy $Restore_Codecs 1
    Return
  NoBackup:
    StrCpy $Restore_Codecs 0

FunctionEnd
!endif

Function LoadPreviousSettings

  ;MPlayer codecs section doesn't use Memento so we need to restore it manually
  ;32-bit only
!ifndef DISABLE_CODECS
    ReadRegDWORD $R0 HKLM "${SMPLAYER_REG_KEY}" "Installed_Codecs"
    ${If} $R0 == 1
      !insertmacro SelectSection ${SecCodecs}
    ${EndIf}
!endif

  ;Gets start menu folder name
  !insertmacro MUI_STARTMENU_GETFOLDER "SMP_SMenu" $SMPlayer_StartMenuFolder

  ${MementoSectionRestore}

FunctionEnd

Function PageReinstall

  ${If} $Reinstall_Uninstall != 1
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

  ${NSD_CreateCheckBox} 0 102u 100% 8u $(Reinstall_Msg5)
  Pop $Reinstall_RemoveSettings

  ${NSD_CreateLabel} 0 121u 100% 16u 
  Pop $Reinstall_Message

  SendMessage $Reinstall_OverwriteButton ${BM_SETCHECK} 1 0
  EnableWindow $R0 0

  ${If} $Reinstall_ChgSettings_State == 1
    SendMessage $Reinstall_ChgSettings ${BM_SETCHECK} 1 0
  ${Endif}

  ${If} $Reinstall_RemoveSettings_State == 1
    SendMessage $Reinstall_RemoveSettings ${BM_SETCHECK} 1 0
  ${Endif}

  ${NSD_OnClick} $Reinstall_OverwriteButton PageReinstallUpdate
  ${NSD_OnClick} $Reinstall_UninstallButton PageReinstallUpdate
  ${NSD_OnClick} $Reinstall_ChgSettings PageReinstallUpdate

  Call PageReinstallUpdate

  nsDialogs::Show

FunctionEnd

Function PageReinstallLeave

  ${NSD_GetState} $Reinstall_OverwriteButton $Reinstall_OverwriteButton_State
  ${NSD_GetState} $Reinstall_UninstallButton $Reinstall_UninstallButton_State
  ${NSD_GetState} $Reinstall_ChgSettings $Reinstall_ChgSettings_State
  ${NSD_GetState} $Reinstall_RemoveSettings $Reinstall_RemoveSettings_State

  ${If} $Reinstall_RemoveSettings_State == 1
    !insertmacro SelectSection ${SecResetSettings}
  ${EndIf}

FunctionEnd

Function PageReinstallUpdate

  ${NSD_GetState} $Reinstall_OverwriteButton $Reinstall_OverwriteButton_State
  ${NSD_GetState} $Reinstall_UninstallButton $Reinstall_UninstallButton_State
  ${NSD_GetState} $Reinstall_ChgSettings $Reinstall_ChgSettings_State

  ${If} $Reinstall_OverwriteButton_State == 1

    EnableWindow $Reinstall_ChgSettings 1
    EnableWindow $Reinstall_RemoveSettings 1

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

    EnableWindow $Reinstall_RemoveSettings 0
    ${NSD_SetState} $Reinstall_RemoveSettings 0

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
  WriteRegStr HKLM "${SMPLAYER_DEF_PROGS_KEY}" "" "SMPlayer"
  WriteRegStr HKLM "${SMPLAYER_DEF_PROGS_KEY}\Capabilities" "ApplicationDescription" $(Application_Description)
  WriteRegStr HKLM "${SMPLAYER_DEF_PROGS_KEY}\Capabilities" "ApplicationName" "SMPlayer"
  WriteRegStr HKLM "Software\RegisteredApplications" "SMPlayer" "${SMPLAYER_DEF_PROGS_KEY}\Capabilities"
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

!ifdef WIN64
  ${IfNot} ${RunningX64}
    MessageBox MB_OK|MB_ICONSTOP $(Uninstaller_64bitOnly)
    Abort
  ${EndIf}

  SetRegView 64
!endif

  ;Check for admin on < Vista
  UserInfo::GetAccountType
  Pop $R0
  ${If} $R0 != "admin"
    MessageBox MB_OK|MB_ICONSTOP $(Uninstaller_No_Admin)
    Abort
  ${EndIf}

!ifdef USE_RUNCHECK
  ;Check if SMPlayer is running
  ;Allow skipping check using /NORUNCHECK
  ${un.GetParameters} $R0
  ${un.GetOptions} $R0 "/NORUNCHECK" $R1
  IfErrors 0 +2
    Call un.RunCheck
!endif

  ;Gets start menu folder name
  !insertmacro MUI_STARTMENU_GETFOLDER "SMP_SMenu" $SMPlayer_StartMenuFolder

  ;Get the stored language preference
  !insertmacro MUI_UNGETLANGUAGE

FunctionEnd

Function un.ConfirmPagePre

  ${un.GetParameters} $R0

  ${un.GetOptionsS} $R0 "/X" $R1
  ${Unless} ${Errors}
    Abort
  ${EndUnless}

FunctionEnd

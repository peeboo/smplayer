/*
** NSIS Script for SMPlayer
** by redxii (redxii1234@hotmail.com)
** Requires NSIS 2.x, tested on: 2.44
**
** This Script is set up to compile two different setups:
** - SMPlayer including MPlayer files
** - SMPlayer that downloads MPlayer from a remote server
**
** To create an installer that downloads MPlayer, no need to
** do anything special, it will default to that installer.
**
** To create an installer with the MPlayer files you need to define WITH_MPLAYER:
** makensis.exe /DWITH_MPLAYER smplayer-installer.nsi
** 
** MakeNSISW (GUI Compiler): Tools -> Settings. Add WITH_MPLAYER in Symbol Name and add to the list.
** You need to have the smplayer-build\mplayer files present
**
** Other required files:
** - 7za.exe (http://www.7zip.org)
** - inetc plugin (http://nsis.sourceforge.net/Inetc_plug-in)
*/

;--------------------------------
;Compressor

  SetCompressor /SOLID lzma
  SetCompressorDictSize 32

;--------------------------------
;Additional plugin folders

  !addplugindir plugins

;--------------------------------
;Defines & includes

!define PRODUCT_NAME "SMPlayer"
!define PRODUCT_VERSION "0.6.8"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\SMPlayer"
!define PRODUCT_STARTMENU_GROUP "SMPlayer"
!define MEMENTO_REGISTRY_ROOT HKLM
!define MEMENTO_REGISTRY_KEY Software\SMPlayer

; Fallback versions
!define DEFAULT_CODECS_VERSION "windows-essential-20071007"
!ifndef WITH_MPLAYER
!define DEFAULT_MPLAYER_VERSION "mplayer-svn-28311"
!endif

!include MUI2.nsh
!include Sections.nsh
!include Memento.nsh
!include WinVer.nsh

;--------------------------------
;Configuration

  ;General
  Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
!ifdef WITH_MPLAYER
  OutFile "smplayer_${PRODUCT_VERSION}_setup.exe"
!else
  OutFile "smplayer_${PRODUCT_VERSION}_websetup.exe"
!endif

  ;Version tab properties
  VIProductVersion "${PRODUCT_VERSION}.0"
  VIAddVersionKey "ProductName" "SMPlayer"
  VIAddVersionKey "ProductVersion" "${PRODUCT_VERSION}"
  VIAddVersionKey "Comments" "This installation was built with NSIS."
!ifdef WITH_MPLAYER
  VIAddVersionKey "FileDescription" "SMPlayer Installer (w/ MPlayer)"
!else
  VIAddVersionKey "FileDescription" "SMPlayer Installer (w/o MPlayer)"
!endif
  VIAddVersionKey "FileVersion" "${PRODUCT_VERSION}"
  VIAddVersionKey "LegalCopyright" ""

  /* Sets default install dir to $PROGRAMFILES\SMPlayer.
  If InstallDirRegKey exists (from a previous installation),
  it will default to that directory instead. */
  InstallDir "$PROGRAMFILES\SMPlayer"
  InstallDirRegKey HKLM "Software\SMPlayer" "Path"

  ;Put on a show
  ShowInstDetails show
  ShowUnInstDetails show

  ;Vista+ XML manifest, does not affect older OSes
  RequestExecutionLevel admin

;--------------------------------
;Installer Variables

  Var CODEC_VERSION
  Var IS_ADMIN
!ifndef WITH_MPLAYER
  Var MPLAYER_VERSION
!endif
  Var USERNAME

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  !define MUI_COMPONENTSPAGE_SMALLDESC
  !define MUI_LICENSEPAGE_CHECKBOX
  !define MUI_FINISHPAGE_NOREBOOTSUPPORT
  !define MUI_FINISHPAGE_RUN $INSTDIR\smplayer.exe
  !define MUI_FINISHPAGE_RUN_NOTCHECKED
  !define MUI_FINISHPAGE_RUN_PARAMETERS http://88.191.30.130:8050
  !define MUI_FINISHPAGE_SHOWREADME $INSTDIR\Release_notes.txt
  !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
  !define MUI_FINISHPAGE_SHOWREADME_TEXT "View Release Notes"
  !define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange.bmp"

  # Installer/Uninstaller icons
  !define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
  !define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall.ico"

  # Language Selection Dialog Settings
  !define MUI_LANGDLL_REGISTRY_ROOT HKLM
  !define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
  !define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

;--------------------------------
;Pages
;MUI_PAGE_WELCOME should always be first and MUI_PAGE_FINISH should be last

  # Install Pages
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "smplayer-build\Copying.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  # UnInstall Pages
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
; Languages

  !insertmacro MUI_LANGUAGE "Basque"
  !insertmacro MUI_LANGUAGE "Catalan"
  !insertmacro MUI_LANGUAGE "Czech"
  !insertmacro MUI_LANGUAGE "Danish"
  !insertmacro MUI_LANGUAGE "Dutch"
  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "Finnish"
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "German"
  !insertmacro MUI_LANGUAGE "Hebrew"
  !insertmacro MUI_LANGUAGE "Hungarian"
  !insertmacro MUI_LANGUAGE "Italian"
  !insertmacro MUI_LANGUAGE "Norwegian"
  !insertmacro MUI_LANGUAGE "Polish"
  !insertmacro MUI_LANGUAGE "Portuguese"
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "Slovak"
  !insertmacro MUI_LANGUAGE "Slovenian"
  !insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------
; Translations for setup

  !insertmacro LANGFILE_INCLUDE "translations\basque.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\catalan.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\czech.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\danish.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\dutch.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\english.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\finnish.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\french.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\german.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\hebrew.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\hungarian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\italian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\norwegian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\polish.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\portuguese.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\russian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\slovak.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\slovenian.nsh"
  !insertmacro LANGFILE_INCLUDE "translations\spanish.nsh"

;--------------------------------
;Reserve Files

  ;These files should be inserted before other files in the data block
  ;Keep these lines before any File command
  ;Only for solid compression (by default, solid compression is enabled for BZIP2 and LZMA)

  !insertmacro MUI_RESERVEFILE_LANGDLL
  ReserveFile "${NSISDIR}\Plugins\UserInfo.dll"

;--------------------------------
;Installer Types
;First in list is #1, second in list in #2, etc

  InstType "Standard installation"
  InstType "Full installation"

;------------------------------------------------------------------------------------------------
;Installer Sections

;--------------------------------
; Main SMPlayer files
Section SMPlayer SMPlayer

  SectionIn 1 2 RO
  SetOutPath "$INSTDIR"
  File "smplayer-build\*"
  File /r "smplayer-build\docs"
  File /r "smplayer-build\imageformats"
  File /r "smplayer-build\shortcuts"

  # UnInstall file
  WriteUninstaller "$INSTDIR\uninst.exe"

  # Store installed path
  WriteRegStr HKLM "Software\SMPlayer" "Path" "$INSTDIR"

  # Windows Vista+ Default Programs registration
  ${If} ${AtLeastWinVista}
  # HKEY_CLASSES_ROOT ProgId registration
    WriteRegStr HKCR "MPlayerFileVideo\DefaultIcon" "" '"$INSTDIR\smplayer.exe",1'
    WriteRegStr HKCR "MPlayerFileVideo\shell\enqueue" "" "Enqueue in SMPlayer"
    WriteRegStr HKCR "MPlayerFileVideo\shell\enqueue\command" "" '"$INSTDIR\smplayer.exe" -add-to-playlist "%1"'
    WriteRegStr HKCR "MPlayerFileVideo\shell\open" "FriendlyAppName" "SMPlayer Media Player"
    WriteRegStr HKCR "MPlayerFileVideo\shell\open\command" "" '"$INSTDIR\smplayer.exe" "%1"'

    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities" "ApplicationDescription" "SMPlayer is a complete front-end for MPlayer, from basic features like playing videos, DVDs, VCDs to more advanced features like support for MPlayer filters, edl lists, and more."
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities" "ApplicationName" "SMPlayer"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".3gp" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".ac3" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".ape" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".asf" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".avi" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".bin" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".dat" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".divx" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".dv" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".dvr-ms" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".flv" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".iso" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".m1v" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".m2v" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".m4v" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".mkv" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".mov" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".mp3" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".mp4" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".mpeg" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".mpg" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".mpv" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".mqv" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".nsv" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".ogg" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".ogm" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".ra" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".ram" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".rmvb" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".ts" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".vcd" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".vfw" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".vob" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".wav" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".wma" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\Clients\Media\SMPlayer\Capabilities\FileAssociations" ".wmv" "MPlayerFileVideo"
    WriteRegStr HKLM "Software\RegisteredApplications" "SMPlayer" "Software\Clients\Media\SMPlayer\Capabilities"
  ${EndIf}

  # Registry Uninstall information
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\smplayer.exe"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "HelpLink" "http://smplayer.sourceforge.net/forums"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "http://smplayer.sf.net"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "URLUpdateInfo" "http://smplayer.sf.net"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "Publisher" "RVM"
  WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "NoModify" "1"
  WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "NoRepair" "1"

  # Initialize to 0 if don't exist (based on error flag)
  ClearErrors
  ReadRegDWORD $R0 HKLM Software\SMPlayer Installed_MPlayer
  ${If} ${Errors}
    WriteRegDWORD HKLM Software\SMPlayer Installed_MPlayer 0x0
  ${EndIf}
  ClearErrors
  ReadRegDWORD $R0 HKLM Software\SMPlayer Installed_Codecs
  ${If} ${Errors}
    WriteRegDWORD HKLM Software\SMPlayer Installed_Codecs 0x0
  ${EndIf}

  # Copy 7zip to installer's temp directory
  SetOutPath "$PLUGINSDIR"
  File 7za.exe

SectionEnd

;--------------------------------
; Desktop shortcut
${MementoSection} "Create Desktop shortcut" DesktopIcon
  SectionIn 1 2

  SetOutPath "$INSTDIR"
  # all = global; current = current user
  SetShellVarContext all
  CreateShortCut "$DESKTOP\SMPlayer.lnk" "$INSTDIR\smplayer.exe"

${MementoSectionEnd}

;--------------------------------
; Start menu shortcuts
${MementoSection} "Create Start Menu shortcuts" StartMenuIcon
  SectionIn 1 2

  SetOutPath "$INSTDIR"
  # Start menu shortcut creation
  SetShellVarContext all
  CreateDirectory "$SMPROGRAMS\${PRODUCT_STARTMENU_GROUP}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_STARTMENU_GROUP}\SMPlayer.lnk" "$INSTDIR\smplayer.exe"
  WriteINIStr    "$SMPROGRAMS\${PRODUCT_STARTMENU_GROUP}\SMPlayer on the Web.url" "InternetShortcut" "URL" "http://smplayer.sf.net"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_STARTMENU_GROUP}\Uninstall SMPlayer.lnk" "$INSTDIR\uninst.exe"

${MementoSectionEnd}

;--------------------------------
; MPlayer Components
SectionGroup /e "MPlayer Components"

;--------------------------------
; MPlayer
!ifdef WITH_MPLAYER
  Section MPlayer MPlayer
    SectionIn 1 2 RO

    SetOutPath "$INSTDIR"
    File /r "smplayer-build\mplayer"

    WriteRegDWORD HKLM Software\SMPlayer Installed_MPlayer 0x1

  SectionEnd
!else
  Section MPlayer MPlayer
    SectionIn 1 2 RO
    AddSize 15300

    ReadRegDWORD $0 HKLM Software\SMPlayer Installed_MPlayer

    IntCmp $0 1 mplayerInstalled mplayerNotInstalled
      mplayerInstalled:
        MessageBox MB_YESNO "$(MPLAYER_IS_INSTALLED)" /SD IDNO IDYES mplayerNotInstalled IDNO done
      mplayerNotInstalled:
        ${IfNot} ${FileExists} "$PLUGINSDIR\version-info"
          Call getVerInfo
        ${EndIf}

        IfFileExists "$PLUGINSDIR\version-info" 0 noVerInfo
          ClearErrors
          ReadINIStr $MPLAYER_VERSION "$PLUGINSDIR\version-info" smplayer mplayer

          IfErrors 0 done_ver_info
            DetailPrint "$(VERINFO_IS_MISSING)"
            # Default Value if version-info exists but version string is missing from version-info
            StrCpy $MPLAYER_VERSION ${DEFAULT_MPLAYER_VERSION}
            Goto done_ver_info

        noVerInfo:
          # Default Value if version-info doesn't exist
          StrCpy $MPLAYER_VERSION ${DEFAULT_MPLAYER_VERSION}

    done_ver_info:

      DetailPrint "$(MPLAYER_IS_DOWNLOADING)"
      inetc::get /timeout 30000 /resume "" /caption "$(MPLAYER_IS_DOWNLOADING)" /banner "Downloading $MPLAYER_VERSION.7z" \
      "http://downloads.sourceforge.net/smplayer/$MPLAYER_VERSION.7z?big_mirror=0" \
      "$PLUGINSDIR\$MPLAYER_VERSION.7z"
      /* inetc::get /timeout 30000 /resume "" /caption "Downloading MPlayer..." /banner "Downloading $MPLAYER_VERSION.7z" \
      "ftp://ftp.berlios.de/pub/smplayer/test/$MPLAYER_VERSION.7z" \
      "$PLUGINSDIR\$MPLAYER_VERSION.7z" */
      # Result of download; for inetc should equal "OK" if successful
      Pop $R0
      StrCmp $R0 OK 0 check_mplayer

      # Extract
      nsExec::Exec '"$PLUGINSDIR\7za.exe" x "$PLUGINSDIR\$MPLAYER_VERSION.7z" -y -o"$PLUGINSDIR"'

      # Copy
      CreateDirectory "$INSTDIR\mplayer"
      CopyFiles /SILENT "$PLUGINSDIR\$MPLAYER_VERSION\*" "$INSTDIR\mplayer"

    check_mplayer:
      # This label does not necessarily mean there was a download error, so check first
      ${If} $R0 != "OK"
        DetailPrint "$(MPLAYER_DL_FAILED) $R0."
      ${EndIf}

      IfFileExists "$INSTDIR\mplayer\mplayer.exe" mplayerInstSuccess mplayerInstFailed
        mplayerInstSuccess:
          WriteRegDWORD HKLM Software\SMPlayer Installed_MPlayer 0x1
          Goto done
        mplayerInstFailed:
          Abort "$(MPLAYER_INST_FAILED)"

    done:

  SectionEnd
!endif

;--------------------------------
; Binary codecs
  Section /o "Optional Codecs" Codecs
    SectionIn 2
    AddSize 22300

    ReadRegDWORD $1 HKLM Software\SMPlayer Installed_Codecs

    IntCmp $1 1 mplayerCodecsInstalled mplayerCodecsNotInstalled
      mplayerCodecsInstalled:
        MessageBox MB_YESNO "$(CODECS_IS_INSTALLED)" /SD IDNO IDYES mplayerCodecsNotInstalled IDNO done
      mplayerCodecsNotInstalled:
        ${IfNot} ${FileExists} "$PLUGINSDIR\version-info"
          Call getVerInfo
        ${EndIf}

        IfFileExists "$PLUGINSDIR\version-info" 0 noVerInfo
          ClearErrors
          ReadINIStr $CODEC_VERSION "$PLUGINSDIR\version-info" smplayer mplayercodecs

          IfErrors 0 done_ver_info
            DetailPrint "$(VERINFO_IS_MISSING)"
            # Default Value if version-info exists but version string is missing from version-info
            StrCpy $CODEC_VERSION ${DEFAULT_CODECS_VERSION}
            Goto done_ver_info

        noVerInfo:
          # Default Value if version-info doesn't exist
          StrCpy $CODEC_VERSION ${DEFAULT_CODECS_VERSION}

    done_ver_info:

      DetailPrint "$(CODECS_IS_DOWNLOADING)"
      inetc::get /timeout 30000 /resume "" /caption "$(CODECS_IS_DOWNLOADING)" /banner "Downloading $CODEC_VERSION.zip" \
      "http://www.mplayerhq.hu/MPlayer/releases/codecs/$CODEC_VERSION.zip" \
      "$PLUGINSDIR\$CODEC_VERSION.zip"
      /* inetc::get /timeout 30000 /resume "" /caption "Downloading MPlayer codecs..." /banner "Downloading $CODEC_VERSION.zip" \
      "ftp://ftp.berlios.de/pub/smplayer/test/$CODEC_VERSION.zip" \
      "$PLUGINSDIR\$CODEC_VERSION.zip" */
      # Result of download; for inetc should equal "OK" if successful
      Pop $R0
      StrCmp $R0 OK 0 check_codecs

      # Extract
      nsExec::Exec '"$PLUGINSDIR\7za.exe" x "$PLUGINSDIR\$CODEC_VERSION.zip" -y -o"$PLUGINSDIR"'

      # Copy
      CreateDirectory "$INSTDIR\mplayer\codecs"
      CopyFiles /SILENT "$PLUGINSDIR\$CODEC_VERSION\*" "$INSTDIR\mplayer\codecs"

    check_codecs:
      # This label does not necessarily mean there was a download error, so check first
      ${If} $R0 != "OK"
        DetailPrint "$(CODECS_DL_FAILED) $R0."
      ${EndIf}

      IfFileExists "$INSTDIR\mplayer\codecs\*.dll" codecsInstSuccess codecsInstFailed
        codecsInstSuccess:
          WriteRegDWORD HKLM Software\SMPlayer Installed_Codecs 0x1
          Goto done
        codecsInstFailed:
          DetailPrint "$(CODECS_INST_FAILED)"
          WriteRegDWORD HKLM Software\SMPlayer Installed_Codecs 0x0
          # Pause for 5 seconds to see the error message
          Sleep 5000

    done:

	SectionEnd

SectionGroupEnd

;--------------------------------
; Icon Themes
${MementoSection} "Icon Themes" Themes

  SectionIn 1 2
  SetOutPath "$INSTDIR"
  File /r "smplayer-build\themes"

${MementoSectionEnd}

;--------------------------------
; Translations
${MementoSection} Translations Translations

  SectionIn 1 2
  SetOutPath "$INSTDIR"
  File /r "smplayer-build\translations"

${MementoSectionEnd}

${MementoSectionDone}

;--------------------------------
; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SMPlayer} "SMPlayer, shared libraries, and documentation."
  !insertmacro MUI_DESCRIPTION_TEXT ${DesktopIcon} "Creates a shortcut on the desktop."
  !insertmacro MUI_DESCRIPTION_TEXT ${StartMenuIcon} "Creates start menu shortcuts."
!ifdef WITH_MPLAYER
  !insertmacro MUI_DESCRIPTION_TEXT ${MPlayer} "The engine behind SMPlayer, required for playback."
!else
  !insertmacro MUI_DESCRIPTION_TEXT ${MPlayer} "Downloads/installs mplayer; requires an active internet connection. Required for playback."
!endif
  !insertmacro MUI_DESCRIPTION_TEXT ${Codecs} "Downloads/installs optional codecs for mplayer; requires an active internet connection."
  !insertmacro MUI_DESCRIPTION_TEXT ${Themes} "Stylish icon themes for SMPlayer."
  !insertmacro MUI_DESCRIPTION_TEXT ${Translations} "Translations for SMPlayer."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Installer Functions

Function .onInit

  /******************************************/
  /*** Check if setup is already running ****/
  /******************************************/
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "MPlayerSMPlayer") i .r1 ?e'
  Pop $R0

  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "The installer is already running."
    Abort

  /******************************************/
  /************ Privileges Check ************/
  /******************************************/
  Call getUserInfo

  # Check for admin (mimic old Inno Setup behavior... non-admin installation maybe later..)
  ${If} $IS_ADMIN == 0
    MessageBox MB_OK|MB_ICONSTOP "You must be logged in as an administrator when installing this program."
    Abort
  ${EndIf}

  /******************************************/
  /******** Uninstall previous version ******/
  /******************************************/
  ReadRegStr $R0 HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
  StrCmp $R0 "" nouninst

  MessageBox MB_YESNO|MB_ICONEXCLAMATION \
  "SMPlayer has already been installed.$\nDo you want to remove the previous version before installing SMPlayer ${PRODUCT_VERSION}?" IDNO nouninst

  ClearErrors
  ExecWait '$R0 _?=$INSTDIR' ;Do not copy the uninstaller to a temp file
  nouninst:

  !insertmacro MUI_LANGDLL_DISPLAY

  ${MementoSectionRestore}

FunctionEnd

Function .onInstSuccess

  ${MementoSectionSave}

FunctionEnd

Function .onInstFailed

  SetDetailsPrint textonly
  DetailPrint "Rolling back changes..."
  SetDetailsPrint listonly

  # Delete registry keys
  DeleteRegKey HKLM "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKCR "MPlayerFileVideo"
  DeleteRegKey HKLM "Software\Clients\Media\SMPlayer"
  DeleteRegValue HKLM "Software\RegisteredApplications" "SMPlayer"
  DeleteRegKey HKLM "Software\SMPlayer"

  # Delete desktop and start menu shortcuts
  SetShellVarContext all
  Delete "$DESKTOP\SMPlayer.lnk"
  RMDir /r "$SMPROGRAMS\${PRODUCT_STARTMENU_GROUP}"

  # Delete directories recursively except for main directory
  # Do not recursively delete $INSTDIR
  RMDir /r "$INSTDIR\docs"
  RMDir /r "$INSTDIR\imageformats"
  RMDir /r "$INSTDIR\mplayer"
  RMDir /r "$INSTDIR\shortcuts"
  RMDir /r "$INSTDIR\themes"
  RMDir /r "$INSTDIR\translations"
  Delete "$INSTDIR\*.txt"
  Delete "$INSTDIR\mingwm10.dll"
  Delete "$INSTDIR\Q*.dll"
  Delete "$INSTDIR\smplayer.exe"
  Delete "$INSTDIR\dxlist.exe"
  Delete "$INSTDIR\uninst.exe"
  RMDir "$INSTDIR"

  SetDetailsPrint both

FunctionEnd

Function .onSelChange

  SectionGetFlags ${Codecs} $R0
  ${If} $R0 != $R1
    StrCpy $R1 $R0
    IntOp $R0 $R0 & ${SF_SELECTED}
  ${If} $R0 == ${SF_SELECTED}
    MessageBox MB_OK "$(MPLAYER_CODEC_INFORMATION)"
  ${EndIf}
  ${EndIf}

FunctionEnd

Function getUserInfo

  ClearErrors
  UserInfo::GetName
  ${If} ${Errors}
    StrCpy $IS_ADMIN 1
    Return
  ${EndIf}

  Pop $USERNAME
  UserInfo::GetAccountType
  Pop $R0
  ${Switch} $R0
    ${Case} "Admin"
    ${Case} "Power"
      StrCpy $IS_ADMIN 1
      ${Break}
    ${Default}
      StrCpy $IS_ADMIN 0
      ${Break}
  ${EndSwitch}

FunctionEnd

Function getVerInfo

  DetailPrint "$(VERINFO_IS_DOWNLOADING)"
  inetc::get /timeout 30000 /resume "" /silent "http://smplayer.sourceforge.net/mplayer-version-info" \
  "$PLUGINSDIR\version-info"
  Pop $R0
  StrCmp $R0 OK +2
    DetailPrint "$(VERINFO_DL_FAILED) $R0."

FunctionEnd

;End Installer Sections
;------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------
;UnInstaller

;--------------------------------
;UnInstaller Variables

  Var un.IS_ADMIN
  Var un.USERNAME

;--------------------------------
;UnInstaller Sections

Section Uninstall

  # Make sure SMPlayer is installed from where the uninstaller is being executed.
  IfFileExists $INSTDIR\smplayer.exe smplayer_installed
    MessageBox MB_YESNO "It does not appear that SMPlayer is installed in the directory '$INSTDIR'.$\r$\nContinue anyway (not recommended)?" IDYES smplayer_installed
    Abort "Uninstall aborted by user."

  smplayer_installed:

  SetDetailsPrint textonly
  DetailPrint "Restoring file associations..."
  SetDetailsPrint listonly

  ExecWait '"$INSTDIR\smplayer.exe" -uninstall'

  # Delete registry keys
  SetDetailsPrint textonly
  DetailPrint "Deleting Registry Keys..."
  SetDetailsPrint listonly

  DeleteRegKey HKLM "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKCR "MPlayerFileVideo"
  DeleteRegKey HKLM "Software\Clients\Media\SMPlayer"
  DeleteRegValue HKLM "Software\RegisteredApplications" "SMPlayer"
  DeleteRegKey HKLM "Software\SMPlayer"

  # Delete desktop and start menu shortcuts
  SetDetailsPrint textonly
  DetailPrint "Deleting Shortcuts..."
  SetDetailsPrint listonly

  SetShellVarContext all
  Delete "$DESKTOP\SMPlayer.lnk"
  RMDir /r "$SMPROGRAMS\${PRODUCT_STARTMENU_GROUP}"

  # Delete directories recursively except for main directory
  # Do not recursively delete $INSTDIR
  SetDetailsPrint textonly
  DetailPrint "Deleting Files..."
  SetDetailsPrint listonly

  RMDir /r "$INSTDIR\docs"
  RMDir /r "$INSTDIR\imageformats"
  RMDir /r "$INSTDIR\mplayer"
  RMDir /r "$INSTDIR\shortcuts"
  RMDir /r "$INSTDIR\themes"
  RMDir /r "$INSTDIR\translations"
  Delete "$INSTDIR\*.txt"
  Delete "$INSTDIR\mingwm10.dll"
  Delete "$INSTDIR\Q*.dll"
  Delete "$INSTDIR\smplayer.exe"
  Delete "$INSTDIR\dxlist.exe"
  Delete "$INSTDIR\uninst.exe"
  RMDir "$INSTDIR"

  SetDetailsPrint both

SectionEnd

;--------------------------------
;UnInstaller Functions

Function un.onInit

  Call un.getUserInfo

  # Check for admin (mimic old Inno Setup behavior... non-admin installation maybe later..)
  ${If} $un.IS_ADMIN == 0
    MessageBox MB_OK|MB_ICONSTOP "This installation can only be uninstalled by a user with administrator privileges."
    Abort
  ${EndIf}

  # Get the stored language preference
  !insertmacro MUI_UNGETLANGUAGE

FunctionEnd

Function un.getUserInfo

  ClearErrors
  UserInfo::GetName
  ${If} ${Errors}
    StrCpy $un.IS_ADMIN 1
    Return
  ${EndIf}

  Pop $un.USERNAME
  UserInfo::GetAccountType
  Pop $R0
  ${Switch} $R0
    ${Case} "Admin"
    ${Case} "Power"
      StrCpy $un.IS_ADMIN 1
      ${Break}
    ${Default}
      StrCpy $un.IS_ADMIN 0
      ${Break}
  ${EndSwitch}

FunctionEnd
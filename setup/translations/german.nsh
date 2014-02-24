﻿;Language: German (1031)
;German language strings for the Windows SMPlayer NSIS installer.
;
;Save file as UTF-8 w/ BOM
;

!insertmacro LANGFILE "German" "Deutsch"

; Startup
${LangFileString} Installer_Is_Running "Das Installationsprogramm läuft bereits."
${LangFileString} Installer_No_Admin "Sie müssen als Administrator angemeldet sein, um dieses Programm zu installieren."
${LangFileString} SMPlayer_Is_Running "An instance of SMPlayer is running. Please exit SMPlayer and try again."

${LangFileString} OS_Not_Supported "Unsupported operating system.$\nSMPlayer ${SMPLAYER_VERSION} requires at least Windows XP and may not work correctly on your system.$\nDo you really want to continue with the installation?"
${LangFileString} Win64_Required "A 64-bit Windows operating system is required to install this software."
${LangFileString} Existing_32bitInst "An existing 32-bit installation of SMPlayer exists. You must uninstall 32-bit SMPlayer first."
${LangFileString} Existing_64bitInst "An existing 64-bit installation of SMPlayer exists. You must uninstall 64-bit SMPlayer first."

; Welcome page
${LangFileString} WelcomePage_Title "$(^NameDA)-Einrichtung"
${LangFileString} WelcomePage_Text "Setup will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close all instances of SMPlayer before starting setup. This will make it possible to update relevant program files without having to reboot your computer.$\r$\n$\r$\n$_CLICK"

; Components Page
${LangFileString} ShortcutGroupTitle "Verknüpfung"
${LangFileString} MPlayerGroupTitle "MPlayer-Komponenten"

${LangFileString} Section_SMPlayer "SMPlayer (erforderlich)"
${LangFileString} Section_SMPlayer_Desc "SMPlayer, dynamische Bibliotheken und Dokumentation."

${LangFileString} Section_DesktopShortcut "Schreibtisch"
${LangFileString} Section_DesktopShortcut_Desc "Erstellt eine Verknüpfung zum SMPlayer auf dem Schreibtisch."

${LangFileString} Section_StartMenu "Startmenü"
${LangFileString} Section_StartMenu_Desc "Erstellt einen Startmenüeintrag für den SMPlayer."

${LangFileString} Section_MPlayer "MPlayer (erforderlich)"
${LangFileString} Section_MPlayer_Desc "MPlayer – benötigt für die Wiedergabe."

${LangFileString} Section_MPlayerCodecs "Binärcodecs"
!ifdef WIN64
${LangFileString} Section_MPlayerCodecs_Desc "Binary codecs are not supported in this version."
!else
${LangFileString} Section_MPlayerCodecs_Desc "Optionale Codecs für MPlayer. (Internetverbindung benötigt für Installation)"
!endif

${LangFileString} Section_MEncoder_Desc "A companion program to MPlayer that can be used to encode or transform supported audio or video streams."

${LangFileString} Section_IconThemes "Symbolthemen"
${LangFileString} Section_IconThemes_Desc "Weitere Symbolthemen für den SMPlayer."

${LangFileString} Section_Translations "Sprachen"
${LangFileString} Section_Translations_Desc "Nicht englische Sprachdateien für den SMPlayer."

${LangFileString} Section_ResetSettings_Desc "Deletes SMPlayer preferences leftover from previous installations."

${LangFileString} MPlayer_Codec_Msg "Binärcodec-Pakete werden eingesetzt für Codecs, die noch nicht nativ implementiert sind – wie neuere Varianten von RealVideo und viele ungewöhnliche Formate.$\nHinweis: Die Pakete sind nicht notwendig, um die gängigsten Formate wiederzugeben (DVD, MPEG-1/2/4, usw.)"

; Upgrade/Reinstall Page
${LangFileString} Reinstall_Header_Text "Installationstyp auswählen"
${LangFileString} Reinstall_Header_SubText "Überschreiben- oder Entfernenmodus auswählen"

${LangFileString} Reinstall_Msg1 "You have an existing installation of SMPlayer in the following folder:"
${LangFileString} Reinstall_Msg2 "Bitte wählen, wie fortgefahren werden soll:"
${LangFileString} Reinstall_Overwrite "Overwrite ($Inst_Type) the existing installation"
${LangFileString} Reinstall_Uninstall "Uninstall (remove) the existing installation"
${LangFileString} Reinstall_Msg3_1 "Click Start when ready to proceed."
${LangFileString} Reinstall_Msg3_2 "Click Next when ready to proceed."
${LangFileString} Reinstall_Msg3_3 "Click Uninstall when ready to proceed."
${LangFileString} Reinstall_Msg4 "Change Installation Settings"
${LangFileString} Reinstall_Msg5 "Meine SMPlayer-Konfiguration zurücksetzen"

${LangFileString} Type_Reinstall "Erneut installierten"
${LangFileString} Type_Downgrade "Herunterstufen"
${LangFileString} Type_Upgrade "Aktualisierung"

${LangFileString} StartBtn "Start"

; Codecs Section
${LangFileString} Codecs_DL_Msg "MPlayer-Codecs herunterladen …"
${LangFileString} Codecs_DL_Retry "Die MPlayer-Codecs sind nicht erfolgreich installiert worden. Erneut versuchen?"
${LangFileString} Codecs_DL_Failed "Fehler beim Herunterladen der MPlayer-Codecs: »$R0«."
${LangFileString} Codecs_Inst_Failed "Fehler beim Installieren der MPlayer-Codecs."

; Uninstaller
${LangFileString} Uninstaller_No_Admin "Diese Installation kann nur von einem Benutzer mit Administrationsrechten entfernt werden."
${LangFileString} Uninstaller_Aborted "Die Deinstallation ist vom Benutzer abgebrochen worden."
${LangFileString} Uninstaller_NotInstalled "Es scheint, dass der SMPlayer nicht im Verzeichnis »$INSTDIR« installiert ist.$\r$\nTrotzdem fortfahren (nicht empfohlen)?"
${LangFileString} Uninstaller_InvalidDirectory "SMPlayer-Installation nicht gefunden"
${LangFileString} Uninstaller_64bitOnly "This installation can only be uninstalled on 64-bit Windows."

; Vista & Later Default Programs Registration
${LangFileString} Application_Description "Der SMPlayer ist eine komplette grafische Oberfläche für den MPlayer, von grundlegenden Funktionen, wie das Abspielen von Videos, DVDs, VCDs, bis zu erweiterten Funktionen, wie die Unterstützung für MPlayer-Filter, edl-Listen und vielem mehr."

; Misc
${LangFileString} Info_Codecs_Backup "Backing up codecs from previous installation..."
${LangFileString} Info_Codecs_Restore "Restoring codecs from previous installation..."
${LangFileString} Info_Del_Files "Dateien werden gelöscht …"
${LangFileString} Info_Del_Registry "Registrierungsschlüssel werden gelöscht …"
${LangFileString} Info_Del_Shortcuts "Verknüpfungen werden gelöscht …"
${LangFileString} Info_Rest_Assoc "Dateizuordnungen werden wiederhergestellt …"
${LangFileString} Info_RollBack "Rolling back changes..."
${LangFileString} Info_Files_Extract "Dateien werden entpackt …"

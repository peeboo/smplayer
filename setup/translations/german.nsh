﻿;Language: German (1031)
;German language strings for the Windows SMPlayer NSIS installer.
;
;Save file as UTF-8 w/ BOM
;

!if ! ${NSIS_PACKEDVERSION} > 0x2999999
!insertmacro LANGFILE "German" "Deutsch"
!else
!insertmacro LANGFILE "German" = "Deutsch" =
!endif

; Startup
${LangFileString} Installer_Is_Running "Das Installationsprogramm läuft bereits."
${LangFileString} Installer_No_Admin "Sie müssen als Administrator angemeldet sein, um dieses Programm zu installieren."
${LangFileString} SMPlayer_Is_Running "Eine Instanz vom SMPlayer läuft. Bitte SMPlayer beenden und erneut versuchen."

${LangFileString} OS_Not_Supported "Nicht unterstütztes Betriebssystem.$\nSMPlayer ${SMPLAYER_VERSION} benötigt mindestens Windows XP und kann nicht richtig auf Ihrem System funktionieren.$\nWollen Sie wirklich mit der Installation fortfahren?"
${LangFileString} OS_Not_Supported_VistaRequired "Nicht unterstütztes Betriebssystem.$\nSMPlayer ${SMPLAYER_VERSION} benötigt mindestens Windows Vista und kann nicht richtig auf Ihrem System funktionieren.$\nWollen Sie wirklich mit der Installation fortfahren?"
${LangFileString} Win64_Required "Ein 64-Bit-Windows-Betriebssystem ist erforderlich, um diese Software zu installieren."
${LangFileString} Existing_32bitInst "Es existiert eine vorhandene 32-Bit-Installation vom SMPlayer. Sie müssen zuerst den 32-Bit-SMPlayer deinstallieren."
${LangFileString} Existing_64bitInst "Es existiert eine vorhandene 64-Bit-Installation vom SMPlayer. Sie müssen zuerst den 64-Bit-SMPlayer deinstallieren."

; Welcome page
${LangFileString} WelcomePage_Title "$(^NameDA)-Einrichtung"
${LangFileString} WelcomePage_Text "Der Einrichtungsassistent wird Sie durch die Installation von $(^NameDA) begleiten.$\r$\n$\r$\nEs wird empfohlen, alle Instanzen des SMPlayers vor dem Beginn der Installation zu schließen. Dadurch wird es möglich, entsprechende Programmdateien, ohne einen Neustart des Rechners zu aktualisieren.$\r$\n$\r$\n$_CLICK"

; Components Page
${LangFileString} ShortcutGroupTitle "Verknüpfung"
${LangFileString} MPlayerGroupTitle "MPlayer-Komponenten"
${LangFileString} MPlayerMPVGroupTitle "Multimedia-Modul"

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
${LangFileString} Section_MPlayerCodecs_Desc "Binärcodecs werden in dieser Version nicht unterstützt."
!else
${LangFileString} Section_MPlayerCodecs_Desc "Optionale Codecs für MPlayer. (Internetverbindung benötigt für Installation)"
!endif

${LangFileString} Section_MPV_Desc "Eine funktionsreiche Abspaltung von MPlayer && MPlayer2"

${LangFileString} Section_MEncoder_Desc "Ein Begleiterprogramm zum MPlayer, das zum codieren oder zum transformieren von unterstützten Ton- oder Video-Strömen verwendet werden kann."

${LangFileString} Section_IconThemes "Symbolthemen"
${LangFileString} Section_IconThemes_Desc "Weitere Symbolthemen für den SMPlayer."

${LangFileString} Section_Translations "Sprachen"
${LangFileString} Section_Translations_Desc "Nicht englische Sprachdateien für den SMPlayer."

${LangFileString} Section_ResetSettings_Desc "Entfernt die SMPlayer-Einstellungen, welche von einer früheren Installation zurückgeblieben sind."

${LangFileString} MPlayer_Codec_Msg "Binärcodec-Pakete werden eingesetzt für Codecs, die noch nicht nativ implementiert sind – wie neuere Varianten von RealVideo und viele ungewöhnliche Formate.$\nHinweis: Die Pakete sind nicht notwendig, um die gängigsten Formate wiederzugeben (DVD, MPEG-1/2/4, usw.)"

; Upgrade/Reinstall Page
${LangFileString} Reinstall_Header_Text "Installationstyp auswählen"
${LangFileString} Reinstall_Header_SubText "Überschreiben- oder Deinstallieren-Modus auswählen"

${LangFileString} Reinstall_Msg1 "Sie haben eine vorhandene Installation, vom SMPlayer, im folgenden Ordner:"
${LangFileString} Reinstall_Msg2 "Bitte wählen, wie fortgefahren werden soll:"
${LangFileString} Reinstall_Overwrite "Die vorhandene Installation ($Inst_Type) überschreiben"
${LangFileString} Reinstall_Uninstall "Die vorhandene Installation deinstallieren (entfernen)"
${LangFileString} Reinstall_Msg3_1 "Auf Start klicken, wenn Sie bereit sind, um fortzufahren."
${LangFileString} Reinstall_Msg3_2 "Auf Weiter klicken, wenn Sie bereit sind, um fortzufahren."
${LangFileString} Reinstall_Msg3_3 "Auf Deinstallieren klicken, wenn Sie bereit sind, um fortzufahren."
${LangFileString} Reinstall_Msg4 "Installationseinstellungen ändern"
${LangFileString} Reinstall_Msg5 "Meine SMPlayer-Konfiguration zurücksetzen"

${LangFileString} Remove_Settings_Confirmation "Sind Sie sicher, dass Sie Ihre SMPlayer-Einstellungen zurücksetzen möchten? Diese Aktion kann nicht rückgängig gemacht werden."

${LangFileString} Type_Reinstall "Erneut installieren"
${LangFileString} Type_Downgrade "Herunterstufen"
${LangFileString} Type_Upgrade "Aktualisierung"

${LangFileString} StartBtn "Start"

; Codecs Section
${LangFileString} Codecs_DL_Msg "MPlayer-Codecs herunterladen …"
${LangFileString} Codecs_DL_Retry "Die MPlayer-Codecs sind nicht erfolgreich installiert worden. Erneut versuchen?"
${LangFileString} Codecs_DL_Failed "Fehler beim Herunterladen der MPlayer-Codecs: »$R0«."
${LangFileString} Codecs_Inst_Failed "Fehler beim Installieren der MPlayer-Codecs."

; Uninstaller
${LangFileString} Uninstaller_No_Admin "Diese Installation kann nur von einem Benutzer mit Administrationsrechten deinstalliert werden."
${LangFileString} Uninstaller_Aborted "Die Deinstallation ist vom Benutzer abgebrochen worden."
${LangFileString} Uninstaller_NotInstalled "Es scheint, dass der SMPlayer nicht im Verzeichnis »$INSTDIR« installiert ist.$\r$\nTrotzdem fortfahren (nicht empfohlen)?"
${LangFileString} Uninstaller_InvalidDirectory "SMPlayer-Installation nicht gefunden"
${LangFileString} Uninstaller_64bitOnly "Diese Installation kann nur auf einem 64-Bit-Windows deinstalliert werden."

; Vista & Later Default Programs Registration
${LangFileString} Application_Description "Der SMPlayer ist eine komplette grafische Oberfläche für den MPlayer, von grundlegenden Funktionen, wie das Abspielen von Videos, DVDs, VCDs, bis zu erweiterten Funktionen, wie die Unterstützung für MPlayer-Filter, edl-Listen und vielem mehr."

; Misc
${LangFileString} Info_Codecs_Backup "Codecs werden aus vorheriger Installation gesichert …"
${LangFileString} Info_Codecs_Restore "Codecs werden aus vorheriger Installation wiederhergestellt …"
${LangFileString} Info_Del_Files "Dateien werden gelöscht …"
${LangFileString} Info_Del_Registry "Registrierungsschlüssel werden gelöscht …"
${LangFileString} Info_Del_Shortcuts "Verknüpfungen werden gelöscht …"
${LangFileString} Info_Rest_Assoc "Dateizuordnungen werden wiederhergestellt …"
${LangFileString} Info_RollBack "Änderungen werden zurückgesetzt …"
${LangFileString} Info_Files_Extract "Dateien werden entpackt …"
${LangFileString} Info_SMTube_Backup "SMTube wird gesichert ..."
${LangFileString} Info_SMTube_Restore "SMTube wird aus vorheriger Installation wiederhergestellt ..."
${LangFileString} Info_MPV_Backup "mpv wird gesichert …"
${LangFileString} Info_MPV_Restore "mpv wird aus vorheriger Installation wiederhergestellt …"

; MPV
${LangFileString} MPV_DL_Msg "mpv wird heruntergeladen …"
${LangFileString} MPV_DL_Retry "mpv ist nicht erfolgreich installiert worden. Erneut versuchen?"
${LangFileString} MPV_DL_Failed "Fehler beim Herunterladen von mpv: »$R0«."
${LangFileString} MPV_Inst_Failed "Fehler beim Installieren von mpv."

; YouTube-DL
${LangFileString} YTDL_DL_Retry "youtube-dl ist nicht erfolgreich installiert worden. Erneut versuchen?"
${LangFileString} YTDL_DL_Failed "Fehler beim Herunterladen von youtube-dl: »$R0«."
${LangFileString} YTDL_Update_Check "Es wird nach Aktualisierungen für youtube-dl gesucht …"
${LangFileString} YTDL_Error_Msg1 "Warning: youtube-dl exited abnormally with exit code: $YTDL_Exit_code"
${LangFileString} YTDL_Error_Msg2 "Visual C++ 2010 Runtime (x86) is required for youtube-dl."

; SMTube
${LangFileString} SMTube_Incompatible_Msg1 "The current SMTube installation is incompatible with this version of SMPlayer."
${LangFileString} SMTube_Incompatible_Msg2 "Please upgrade to a newer version of SMTube."

; Post install
${LangFileString} Info_Cleaning_Fontconfig "Schriftzwischenspeicher wird bereinigt …"
${LangFileString} Info_Cleaning_SMPlayer "SMPlayer-Einstellungen werden bereinigt …"

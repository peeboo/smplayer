﻿;Language: French (1036)
;French language strings for the Windows SMPlayer NSIS installer.
;
;Save file as UTF-8 w/ BOM
;

!insertmacro LANGFILE "French" "Français"

; Startup
${LangFileString} Installer_Is_Running "L'installateur est déjà en cours d'exécution."
${LangFileString} Installer_No_Admin "Vous devez être connecté comme administrateur pour installer ce programme."
${LangFileString} SMPlayer_Is_Running "Une instance de SMPlayer est en cours d'exécution.  Veuillez quitter SMPlayer puis réessayer l'installation."

${LangFileString} OS_Not_Supported "Système d'exploitation non supporté.$\nSMPlayer ${SMPLAYER_VERSION} requiert au minimum Windows XP et pourrait ne pas fonctionner correctement sur votre système.$\nSouhaitez-vous vraiment continuer l'installation ?"
${LangFileString} Win64_Required "A 64-bit Windows operating system is required to install this software."
${LangFileString} Existing_32bitInst "Une installation de SMPlayer 32 bits existe.  Vous devez désinstaller SMPlayer 32 bits d'abord."
${LangFileString} Existing_64bitInst "Une installation de SMPlayer 64 bits existe.  Vous devez désinstaller SMPlayer 64 bits d'abord."

; Welcome page
${LangFileString} WelcomePage_Title "Installation de $(^NameDA)"
${LangFileString} WelcomePage_Text "Ce programme va vous guider à travers l'installation de $(^NameDA).$\r$\n$\r$\nIl est recommandé de quitter toutes les instances de SMPlayer avant de continuer. Ceci permet de mettre à jour les fichiers concernés sans avoir besoin de redémarrer votre ordinateur.$\r$\n$\r$\n$_CLICK"

; Components Page
${LangFileString} ShortcutGroupTitle "Raccourcis"
  ${LangFileString} MPlayerGroupTitle "Composants de MPlayer"

${LangFileString} Section_SMPlayer "SMPlayer (requis)"
${LangFileString} Section_SMPlayer_Desc "SMPlayer, bibliothèques partagées et documentation."

${LangFileString} Section_DesktopShortcut "Bureau"
${LangFileString} Section_DesktopShortcut_Desc "Crée un raccourci vers SMPlayer sur le bureau."

${LangFileString} Section_StartMenu "Menu Démarrer"
${LangFileString} Section_StartMenu_Desc "Crée une entrée pour SMPlayer dans le menu Démarrer."

${LangFileString} Section_MPlayer "MPlayer (requis)"
${LangFileString} Section_MPlayer_Desc "MPlayer; requis pour la lecture."

${LangFileString} Section_MPlayerCodecs "Codecs binaires"
${LangFileString} Section_MPlayerCodecs_Desc "Codecs optionnels pour MPlayer. (Connexion Internet requise durant l'installation.)"

${LangFileString} Section_MEncoder_Desc "Programme permettant d'encoder ou de convertir des flux audio et/ou vidéos supportés par MPlayer."

${LangFileString} Section_IconThemes "Thèmes d'icônes"
${LangFileString} Section_IconThemes_Desc "Thèmes d'icônes supplémentaires pour SMPlayer."

${LangFileString} Section_Translations "Langues"
${LangFileString} Section_Translations_Desc "Fichiers de langues (autres qie l'anglais) pour SMPlayer."

${LangFileString} MPlayer_Codec_Msg "Les paquets de codecs binaires ajoutent le support pour les codecs qui ne sont pas encore nativement supportés, tels que les nouvelles variantes de RealVideo et d'autres formats peu communs.$\nRemarque : Ces codecs ne sont pas nécessaires pour lire les formats communs tels que les DVD, MPE-1/2/4, etc."

; Upgrade/Reinstall Page
${LangFileString} Reinstall_Header_Text "Sélectionnez le type d'installation."
${LangFileString} Reinstall_Header_SubText "Sélectionnez le mode Remplacement ou Désinstallation."

${LangFileString} Reinstall_Msg1 "Il existe déjà une installation de SMPlayer dans le dossier suivant :"
${LangFileString} Reinstall_Msg2 "Veuillez sélectionner l'opération à effectuer :"
${LangFileString} Reinstall_Overwrite "Remplacer l'installation existante. ($Inst_Type)"
${LangFileString} Reinstall_Uninstall "Désinstaller l'installation existante. (Supprimer)"
${LangFileString} Reinstall_Msg3_1 "Cliquez sur « Démarrer » une fois prêt à continuer."
${LangFileString} Reinstall_Msg3_2 "Cliquez sur « Suivant » une fois prêt à continuer."
${LangFileString} Reinstall_Msg3_3 "Cliquez sur « Désinstaller » une fois prêt à continuer."
${LangFileString} Reinstall_Msg4 "Changer les paramètres d'installation."

${LangFileString} Type_Reinstall "Réinstaller la même version."
${LangFileString} Type_Downgrade "Installer une version plus ancienne."
${LangFileString} Type_Upgrade "Installer une version plus récente."

${LangFileString} StartBtn "Commencer"

; Codecs Section
${LangFileString} Codecs_DL_Msg "Télécharge les codecs de MPlayer..."
${LangFileString} Codecs_DL_Retry "Les codecs de MPlayer n'ont pas été correctement installés. Réessayer ?"
${LangFileString} Codecs_DL_Failed "Échec du téléchargement des codecs de MPlayer : '$R0'."
${LangFileString} Codecs_Inst_Failed "Échec de l'installation des codecs de MPlayer."

; Uninstaller
${LangFileString} Uninstaller_No_Admin "Cette installation ne peut être désinstallée que par un utilisateur ayant les privilèges d'administrateur."
${LangFileString} Uninstaller_Aborted "Désinstallation abandonnée par l'utilisateur."
${LangFileString} Uninstaller_NotInstalled "Il ne semble pas que SMPlayer soit installé dans le dossier '$INSTDIR'.$\r$\nContinuer quand même (déconseillé) ?"
${LangFileString} Uninstaller_64bitOnly "Cette installation ne peut être désinstallée qu'à partir de Windows 64 bits."

; Vista & Later Default Programs Registration
${LangFileString} Application_Description "SMPlayer est une interface utilisateur pour MPlayer, de ses fonctionnalités les plus élémentaires (telles que lire des vidéos, des DVD, des VCD) aux plus avancées (telles que le support des filtres MPlayer, les listes EDL, etc.)."

; Misc
${LangFileString} Info_Codecs_Backup "Sauvegarde les codecs de l'installation précédente..."
${LangFileString} Info_Codecs_Restore "Restaure les codecs de l'installation précédente..."
${LangFileString} Info_Del_Files "Supprime les fichiers..."
${LangFileString} Info_Del_Registry "Supprime les clés de registre..."
${LangFileString} Info_Del_Shortcuts "Supprime les raccourcis..."
${LangFileString} Info_Rest_Assoc "Restaure les associations de fichier..."
${LangFileString} Info_RollBack "Défait les changements..."
${LangFileString} Info_Files_Extract "Extrait les fichiers..."

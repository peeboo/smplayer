﻿;Language: Russian (1049)
;Russian language strings for the Windows SMPlayer NSIS installer.
;
;Save file as UTF-8 w/ BOM
;

!insertmacro LANGFILE "Russian" "Русский"

; Startup
${LangFileString} Installer_Is_Running "Программа установки уже запущена."
${LangFileString} Installer_No_Admin "Для установки программы необходимо войти в систему как администратор."
${LangFileString} SMPlayer_Is_Running "Экземпляр SMPlayer запущен. Пожалуйста, закройте SMPlayer и попытайтесь снова."

${LangFileString} OS_Not_Supported "Unsupported operating system.$\nSMPlayer ${SMPLAYER_VERSION} requires at least Windows XP and may not work correctly on your system.$\nDo you really want to continue with the installation?"
${LangFileString} Win64_Required "Для установки данного ПО требуется 64-битная ОС Windows."
${LangFileString} Existing_32bitInst "Существует 32-битная установка SMPlayer. Сначала далите 32-битный SMPlayer."
${LangFileString} Existing_64bitInst "Существует 64-битная установка SMPlayer. Сначала далите 64-битный SMPlayer."

; Welcome page
${LangFileString} WelcomePage_Title "$(^NameDA) Setup"
${LangFileString} WelcomePage_Text "Setup will guide you through the installation of $(^NameDA).$\r$\n$\r$\nIt is recommended that you close all instances of SMPlayer before starting setup. This will make it possible to update relevant program files without having to reboot your computer.$\r$\n$\r$\n$_CLICK"

; Components Page
${LangFileString} ShortcutGroupTitle "Ярлыки"
${LangFileString} MPlayerGroupTitle "Компоненты MPlayer"

${LangFileString} Section_SMPlayer "SMPlayer (необходимо)"
${LangFileString} Section_SMPlayer_Desc "SMPlayer, разделяемые библиотеки и документация."

${LangFileString} Section_DesktopShortcut "Рабочий стол"
${LangFileString} Section_DesktopShortcut_Desc "Создаёт ярлыки SMPlayer на рабочем столе."

${LangFileString} Section_StartMenu "Стартовое меню"
${LangFileString} Section_StartMenu_Desc "Создаёт ярлыки SMPlayer в стартовом меню."

${LangFileString} Section_MPlayer "MPlayer (необходимо)"
${LangFileString} Section_MPlayer_Desc "MPlayer; необходимо для воспроизведения."

${LangFileString} Section_MPlayerCodecs "Бинарные кодеки"
!ifdef WITH_CODECS
${LangFileString} Section_MPlayerCodecs_Desc "Дополнительные кодеки для MPlayer."
!else ifndef WITH_CODECS
${LangFileString} Section_MPlayerCodecs_Desc "Дополнительные кодеки для MPlayer. (Для установки требуется подключение к сети Интернет)"
!endif

${LangFileString} Section_MEncoder_Desc "Сопутствующая MPlayer программа, которую можно использовать для кодирования и преобразования поддерживаемых аудио и видео потоков."

${LangFileString} Section_IconThemes "Темы иконок"
${LangFileString} Section_IconThemes_Desc "Дополнительные темы иконок для SMPlayer."

${LangFileString} Section_Translations "Переводы"
${LangFileString} Section_Translations_Desc "Языковые файлы SMPlayer, помимо английского."

${LangFileString} MPlayer_Codec_Msg "Пакеты с бинарными кодеками добавляют поддержку кодеков, не встроенных в mplayer, например, RealVideo и других нестандартных форматов.$\nОбратите внимание, что эти кодеки не нужны для воспроизведения большинства обычных форматов вроде DVD, MPEG-1/2/4 и т.п."

; Upgrade/Reinstall Page
${LangFileString} Reinstall_Header_Text "Выберите тип установки"
${LangFileString} Reinstall_Header_SubText "Выберите режим установки поверх или удаления."

${LangFileString} Reinstall_Msg1 "Существует установка SMPlayer в следующем каталоге:"
${LangFileString} Reinstall_Msg2 "Выберите метод для продолжения:"
${LangFileString} Reinstall_Overwrite "Перезаписать ($Inst_Type) существующую установку"
${LangFileString} Reinstall_Uninstall "Удалить существующую установку"
${LangFileString} Reinstall_Msg3_1 "Нажмите Старт для продолжения."
${LangFileString} Reinstall_Msg3_2 "Нажмите Далее для продолжения."
${LangFileString} Reinstall_Msg3_3 "Нажмите Удалить для продолжения."
${LangFileString} Reinstall_Msg4 "Изменить настройки установки"

${LangFileString} Type_Reinstall "переустановить"
${LangFileString} Type_Downgrade "откатить"
${LangFileString} Type_Upgrade "обновить"

${LangFileString} StartBtn "Старт"

; Codecs Section
${LangFileString} Codecs_DL_Msg "Загрузка бинарных кодеков для MPlayer..."
${LangFileString} Codecs_DL_Retry "Не удалось успешно установить кодеки MPlayer. Попытаться ещё раз?"
${LangFileString} Codecs_DL_Failed "Не удалось загрузить бинарные кодеки для MPlayer: '$R0'."
${LangFileString} Codecs_Inst_Failed "Ошибка при установке бинарных кодеков для MPlayer."

; Version information
${LangFileString} VerInfo_DL_Msg "Загрузка информации о версии..."
${LangFileString} VerInfo_DL_Failed "Не удалось загрузить информацию о версии: '$R0'. Будет использована версия по умолчанию."

; Uninstaller
${LangFileString} Uninstaller_No_Admin "Эта установка может быть удалена только пользователем с правами администратора."
${LangFileString} Uninstaller_Aborted "Удаление прервано пользователем."
${LangFileString} Uninstaller_NotInstalled "Не похоже, что SMPlayer установлен в каталог '$INSTDIR'.$\r$\nПродолжить всё равно (не рекомендуется)?"
${LangFileString} Uninstaller_64bitOnly "Эта установка может быть удалена только на 64-битной Windows."

; Vista & Later Default Programs Registration
${LangFileString} Application_Description "SMPlayer - полноценная оболочка для MPlayer, начиная от базовых функций вроде воспроизведения видеофайлов, DVD, VCD и заканчивая более продвинутыми вроде поддержки фильтров MPlayer, списков и т.д."

; Misc
${LangFileString} Info_Del_Files "Удаление файлов..."
${LangFileString} Info_Del_Registry "Удаление ключей реестра..."
${LangFileString} Info_Del_Shortcuts "Удаление ярлыков..."
${LangFileString} Info_Rest_Assoc "Восстановление ассоциаций файлов..."
${LangFileString} Info_RollBack "Откат изменений..."
${LangFileString} Info_Files_Extract "Извлечение файлов..."

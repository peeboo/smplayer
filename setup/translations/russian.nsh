﻿;Language: Russian (1049)
;Russian language strings for the Windows SMPlayer NSIS installer.
;
;Save file as UTF-8 w/ BOM
;

!insertmacro LANGFILE "Russian" "Русский"

; Startup
${LangFileString} SMPLAYER_INSTALLER_IS_RUNNING "Программа установки уже запущена."
${LangFileString} SMPLAYER_INSTALLER_PREV_ALL_USERS "SMPlayer уже установлен глобально для всех пользователей.$\nПожалуйста, перезапустите программу установки с привилегиями администратора."
${LangFileString} SMPLAYER_INSTALLER_PREV_VERSION "SMPlayer уже установлен.$\nВы хотите удалить предыдущую версию перед установкой $(^Name)?"

; Components Page
${LangFileString} MPLAYER_CODEC_INFORMATION "Пакеты с бинарными кодеками добавляют поддержку кодеков, не встроенных в mplayer, например, RealVideo и других нестандартных форматов.$\nОбратите внимание, что эти кодеки не нужны для воспроизведения большинства обычных форматов вроде DVD, MPEG-1/2/4 и т.п."

; MPlayer Section
!ifndef WITH_MPLAYER
  ${LangFileString} MPLAYER_IS_INSTALLED "MPlayer уже установлен. Загрузить заново?"
  ${LangFileString} MPLAYER_IS_DOWNLOADING "Загрузка MPlayer..."
  ${LangFileString} MPLAYER_DL_FAILED "Не удалось загрузить MPlayer:"
  ${LangFileString} MPLAYER_INST_FAILED "Ошибка при установке MPlayer. MPlayer требуется для воспроизведения."
!endif

; Codecs Section
${LangFileString} CODECS_IS_INSTALLED "Бинарные кодеки для MPlayer уже установлены. Загрузить заново?"
${LangFileString} CODECS_IS_DOWNLOADING "Загрузка бинарных кодеков для MPlayer..."
${LangFileString} CODECS_DL_FAILED "Не удалось загрузить бинарные кодеки для MPlayer:"
${LangFileString} CODECS_INST_FAILED "Ошибка при установке бинарных кодеков для MPlayer."

; Version information
${LangFileString} VERINFO_IS_DOWNLOADING "Загрузка информации о версии..."
${LangFileString} VERINFO_DL_FAILED "Не удалось загрузить информацию о версии:"
${LangFileString} VERINFO_IS_MISSING "Файл версии не содержит нужной информации. Программа установки будет использовать версию по умолчанию."

; Uninstaller
${LangFileString} UNINSTALL_ABORTED "Удаление прервано пользователем."
${LangFileString} UNINSTALL_INSTALLED_ALL_USERS "SMPlayer установлен глобально для всех пользователей.$\nПожалуйста, перезапустите программу удаления с привилегиями администратора."
${LangFileString} SMPLAYER_NOT_INSTALLED "Не похоже, что SMPlayer установлен в каталог '$INSTDIR'.$\r$\nПродолжить всё равно (не рекомендуется)?"

; Vista & Later Default Programs Registration
${LangFileString} APPLICATION_DESCRIPTION "SMPlayer - полноценная оболочка для MPlayer, начиная от базовых функций вроде воспроизведения видеофайлов, DVD, VCD и заканчивая более продвинутыми вроде поддержки фильтров MPlayer, списков и т.д."
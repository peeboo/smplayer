﻿;Language: Arabic (1025)
;Arabic language strings for the Windows SMPlayer NSIS installer.
;
;Save file as UTF-8 w/ BOM
;

!insertmacro LANGFILE "Arabic" "العربية"

; Startup
${LangFileString} Installer_Is_Running "المثبِّت مشتغل سلفاً."
${LangFileString} Installer_No_Admin "يجب أن تكون مسجّل الدخول كمدير عند تثبيت هذا البرنامج."
${LangFileString} SMPlayer_Is_Running "توجد نافذة مشتغلة لـ SMPlayer. رجاءاً اخرج من SMPlayer و حاول مرة أخرى."

${LangFileString} OS_Not_Supported "نظام تشغيلي غير مدعوم.$\nSMPlayer ${SMPLAYER_VERSION} يتطلب على الأقل ويندوز Windows XP و قد لا يعمل بصورة صحيحة على نظامك.$\nأتريد حقاً الإستمرار بالتثبيت؟"
${LangFileString} Win64_Required "يتطلب نظام تشغيل ويندوز Windows 64-بت لتثبيت هذا البرنامج."
${LangFileString} Existing_32bitInst "يوجد حاليا تثبيت 32-بت من SMPlayer. يجب ان تزيل تثبيت SMPlayer 32-بت أولاً."
${LangFileString} Existing_64bitInst "يوجد حاليا تثبيت 64-بت من SMPlayer. يجب ان تزيل تثبيت SMPlayer 64-بت أولاً."

; Welcome page
${LangFileString} WelcomePage_Title "إعداد $(^NameDA)"
${LangFileString} WelcomePage_Text "سيرشدك برنامج الإعداد أثناء تثبيت $(^NameDA).$\r$\n$\r$\nيستحسن أن تغلق كل نوافذ SMPlayer قبل بدء الإعداد. هذا سيجعل بالإمكان تحديث ملفات البرنامج المعنية دون الحاجة الى إعادة تشغيل الحاسوب.$\r$\n$\r$\n$_CLICK"

; Components Page
${LangFileString} ShortcutGroupTitle "الإختصارات"
${LangFileString} MPlayerGroupTitle "مكونات MPlayer"
${LangFileString} MPlayerMPVGroupTitle "محرّك متعدد الوسائط"

${LangFileString} Section_SMPlayer "SMPlayer (مطلوب)"
${LangFileString} Section_SMPlayer_Desc "SMPlayer و مكتبات المشاركَة و الوثائق."

${LangFileString} Section_DesktopShortcut "سطح المكتب"
${LangFileString} Section_DesktopShortcut_Desc "يُنشيء اختصاراً لـ SMPlayer على سطح المكتب."

${LangFileString} Section_StartMenu "قائمة البدء"
${LangFileString} Section_StartMenu_Desc "يُنشيء خانة لـ SMPlayer في قائمة البدء."

${LangFileString} Section_MPlayer "MPlayer (مطلوب)"
${LangFileString} Section_MPlayer_Desc "MPlayer. مطلوب للتشغيل."

${LangFileString} Section_MPlayerCodecs "مرمِّزات ثنائية"
!ifdef WIN64
${LangFileString} Section_MPlayerCodecs_Desc "المرمِّزات الثنائية غير مدعومة في هذا الإصدار."
!else
${LangFileString} Section_MPlayerCodecs_Desc "مرمِّزات اختيارية لـ MPlayer. (تتطلب اتصال انترنت للتثبيت)"
!endif

${LangFileString} Section_MPV_Desc "اقتسام غني الخواص من MPlayer && MPlayer2"

${LangFileString} Section_MEncoder_Desc "برنامج مُرافِق لـ MPlayer و يمكن استخدامه لترميز أو تحويل دفقات الصوت أو الفيديو المدعومة."

${LangFileString} Section_IconThemes "سِمات آيقونية"
${LangFileString} Section_IconThemes_Desc "سِمات آيقونية إضافية لـ SMPlayer."

${LangFileString} Section_Translations "اللغات"
${LangFileString} Section_Translations_Desc "ملفات بلغات غير الانكليزية لـ SMPlayer."

${LangFileString} Section_ResetSettings_Desc "يحذف تفضيلات SMPlayer المتروكة من تثبيتات سابقة."

${LangFileString} MPlayer_Codec_Msg "حُزَم المرمِّزات الثنائية تضيف دعماً للمرمِّزات التي لم تنفَّذ داخلياً بعد، مثل الصيغ الجديدة من RealVideo و الكثير من الصيغ غير المتعارفة.$\nلاحِظ انها ليست ضرورية لتشغيل معظم الصيغ المتعارَفة مثل الدي في دي و MPEG-1/2/4 و غيرها."

; Upgrade/Reinstall Page
${LangFileString} Reinstall_Header_Text "اختر نوع التثبيت"
${LangFileString} Reinstall_Header_SubText "اختر نمط الكتابة على التثبيت السابق او ازالة التثبيت."

${LangFileString} Reinstall_Msg1 "لديك تثبيت موجود من SMPlayer في المجلد التالي:"
${LangFileString} Reinstall_Msg2 "رجاءاً اختر كيفية المواصَلة:"
${LangFileString} Reinstall_Overwrite "الكتابة على ($Inst_Type) التثبيت الموجود"
${LangFileString} Reinstall_Uninstall "ازالة التثبيت (ازالة) للتثبيت الموجود"
${LangFileString} Reinstall_Msg3_1 "اضغط البدء عندما تكون مستعداً للمواصَلة."
${LangFileString} Reinstall_Msg3_2 "اضغط التالي عندما تكون مستعداً للمواصَلة."
${LangFileString} Reinstall_Msg3_3 "اضغط إزالة التثبيت عندما تكون مستعداً للمواصَلة."
${LangFileString} Reinstall_Msg4 "غيِّر إعدادات التثبيت"
${LangFileString} Reinstall_Msg5 "صفِّر إعداداتي لـ SMPlayer"

${LangFileString} Remove_Settings_Confirmation "Are you sure you want to reset your SMPlayer settings? This action cannot be reversed."

${LangFileString} Type_Reinstall "أعِد التثبيت"
${LangFileString} Type_Downgrade "إنزال المرتبة"
${LangFileString} Type_Upgrade "الترقية"

${LangFileString} StartBtn "البدء"

; Codecs Section
${LangFileString} Codecs_DL_Msg "تحميل مرمِّزات MPlayer..."
${LangFileString} Codecs_DL_Retry "لم تثبَّت مرمِّزات MPlaer بنجاح. إعادة المحاولة؟"
${LangFileString} Codecs_DL_Failed "فشل تحميل مرمِّزات MPlayer: '$R0'."
${LangFileString} Codecs_Inst_Failed "فشل تثبيت مرمِّزات MPlaer."

; Uninstaller
${LangFileString} Uninstaller_No_Admin "يمكن إزالة تثبيت هذا التثبيت من قبَل مستخدم لديه صلاحيات مدير."
${LangFileString} Uninstaller_Aborted "أُحبِطت إزالة التثبيت من قبَل المستخدم."
${LangFileString} Uninstaller_NotInstalled "لا يبدو أن SMPlayer مثبت في المجلد '$INSTDIR'.$\r$\nالإستمرار على أية حال (غير مستحسَن)؟"
${LangFileString} Uninstaller_InvalidDirectory "لا يمكن العثور على تثبيت SMPlayer."
${LangFileString} Uninstaller_64bitOnly "يمكن إزالة تثبيت هذا التثبيت على نظام ويندوز Windows 64-بت فقط."

; Vista & Later Default Programs Registration
${LangFileString} Application_Description "SMPlayer هو واجهة-طرفية متكاملة لـ MPlaer، ابتداءا من الميزات الأساسية مثل تشغيل مقاطع الفيديو و اقراص دي في دي DVD و اقراص الفيديو، وصولاً الى الميزات الأكثر تقدماً مثل دعم مرشحات MPlayer و قوائم edl و غير ذلك."

; Misc
${LangFileString} Info_Codecs_Backup "النَسْخ الإحتياطي للمرمِّزات من تثبيت سابق..."
${LangFileString} Info_Codecs_Restore "استعادة المرمِّزات من تثبيت سابق..."
${LangFileString} Info_Del_Files "حذف الملفات..."
${LangFileString} Info_Del_Registry "حذف مفاتيح التسجيل..."
${LangFileString} Info_Del_Shortcuts "حذف الإختصارات..."
${LangFileString} Info_Rest_Assoc "استعادة ارتباطات الملفات..."
${LangFileString} Info_RollBack "عكس التغييرات..."
${LangFileString} Info_Files_Extract "استخراج الملفات..."
${LangFileString} Info_SMTube_Backup "الخزن الإحتياطي لـ SMTube..."
${LangFileString} Info_SMTube_Restore "استعادة SMTube من تثبيت سابق..."
${LangFileString} Info_MPV_Backup "Backing up mpv..."
${LangFileString} Info_MPV_Restore "Restoring mpv from previous installation..."

; MPV
${LangFileString} MPV_DL_Msg "Downloading mpv..."
${LangFileString} MPV_DL_Retry "mpv was not successfully installed. Retry?"
${LangFileString} MPV_DL_Failed "Failed to download mpv: '$R0'."
${LangFileString} MPV_Inst_Failed "Failed to install mpv."

; YouTube-DL
${LangFileString} YTDL_DL_Retry "youtube-dl was not successfully installed. Retry?"
${LangFileString} YTDL_DL_Failed "Failed to download youtube-dl: '$R0'."
${LangFileString} YTDL_Update_Check "Checking for youtube-dl updates..."

; Post install
${LangFileString} Info_Cleaning_Fontconfig "Cleaning fontconfig cache..."
${LangFileString} Info_Cleaning_SMPlayer "Cleaning SMPlayer settings..."

﻿;Language: Japanese (1041)
;Japanese language strings for the Windows SMPlayer NSIS installer.
;
;Save file as UTF-8 w/ BOM
;

!insertmacro LANGFILE "Japanese" "日本語"

; Startup
${LangFileString} Installer_Is_Running "インストーラーは既に実行中です。"
${LangFileString} Installer_No_Admin "このプログラムをインストールするときは管理者としてログインする必要があります。"
${LangFileString} SMPlayer_Is_Running "SMPlayer のインスタンスが実行中です。SMPlayer を終了してやり直してください。"

${LangFileString} OS_Not_Supported "サポートされていないオペレーティング システムです。$\nSMPlayer ${SMPLAYER_VERSION} は Windows XP 以上を必要とし、お使いのシステムでは正常に動作しない可能性があります。$\n本当にインストールを続行しますか?"
${LangFileString} Win64_Required "このソフトウェアをインストールするには 64 ビットの Windows オペレーティング システムが必要です。"
${LangFileString} Existing_32bitInst "32 ビットの SMPlayer が既にインストールされています。先に 32 ビットの SMPlayer をアンインストールする必要があります。"
${LangFileString} Existing_64bitInst "64 ビットの SMPlayer が既にインストールされています。先に 64 ビットの SMPlayer をアンインストールする必要があります。"

; Welcome page
${LangFileString} WelcomePage_Title "$(^NameDA) のセットアップ"
${LangFileString} WelcomePage_Text "セットアップは $(^NameDA) のインストールをご案内します。$\r$\n$\r$\nセットアップの開始前にすべての SMPlayer のインスタンスを閉じることが推奨されます。これによりお使いのコンピューターを再起動する必要なく関連するプログラム ファイルを更新することが可能になります。$\r$\n$\r$\n$_CLICK"

; Components Page
${LangFileString} ShortcutGroupTitle "ショートカット"
${LangFileString} MPlayerGroupTitle "MPlayer コンポーネント"
${LangFileString} MPlayerMPVGroupTitle "マルチメディア エンジン"

${LangFileString} Section_SMPlayer "SMPlayer (必須)"
${LangFileString} Section_SMPlayer_Desc "SMPlayer、共有ライブラリ、およびドキュメントです。"

${LangFileString} Section_DesktopShortcut "デスクトップ"
${LangFileString} Section_DesktopShortcut_Desc "デスクトップに SMPlayer へのショートカットを作成します。"

${LangFileString} Section_StartMenu "[スタート] メニュー"
${LangFileString} Section_StartMenu_Desc "SMPlayer の [スタート] メニュー エントリを作成します。"

${LangFileString} Section_MPlayer "MPlayer (必須)"
${LangFileString} Section_MPlayer_Desc "再生のために必要な MPlayer です。"

${LangFileString} Section_MPlayerCodecs "バイナリ コーデック"
!ifdef WIN64
${LangFileString} Section_MPlayerCodecs_Desc "バイナリ コーデックはこのバージョンではサポートされていません。"
!else
${LangFileString} Section_MPlayerCodecs_Desc "MPlayer のオプション コーデックです。(インストールにはインターネット接続が必要です)"
!endif

${LangFileString} Section_MPV_Desc "MPlayer と MPlayer2 の機能豊富なフォークです"

${LangFileString} Section_MEncoder_Desc "サポートされたオーディオまたはビデオ ストリームのエンコードや変換に使用できる MPlayer の姉妹プログラムです。"

${LangFileString} Section_IconThemes "アイコン テーマ"
${LangFileString} Section_IconThemes_Desc "SMPlayer の追加アイコン テーマです。"

${LangFileString} Section_Translations "言語"
${LangFileString} Section_Translations_Desc "SMPlayer の英語以外のの言語ファイルです。"

${LangFileString} Section_ResetSettings_Desc "前のインストールから残っている SMPlayer の環境設定を削除します。"

${LangFileString} MPlayer_Codec_Msg "バイナリ コーデック パッケージは新しい RealVideo 派生や多くの希少なフォーマットなど、まだ自然には実装されていないコーデックへのサポートを追加します。$\nDVD、MPEG-1/2/4 などの最も一般的なフォーマットの再生には必要でないことにご注意ください。"

; Upgrade/Reinstall Page
${LangFileString} Reinstall_Header_Text "インストールの種類の選択"
${LangFileString} Reinstall_Header_SubText "上書きまたはアンインストール モードを選択します。"

${LangFileString} Reinstall_Msg1 "以下のフォルダーに既存 SMPlayer のインストールがあります:"
${LangFileString} Reinstall_Msg2 "続行する方法を選択してください:"
${LangFileString} Reinstall_Overwrite "既存のインストールを上書き ($Inst_Type) する"
${LangFileString} Reinstall_Uninstall "既存のインストールをアンインストール (削除) する"
${LangFileString} Reinstall_Msg3_1 "続行するには [開始] をクリックします。"
${LangFileString} Reinstall_Msg3_2 "続行するには [次へ] をクリックします。"
${LangFileString} Reinstall_Msg3_3 "続行するには [アンインストール] をクリックします。"
${LangFileString} Reinstall_Msg4 "インストール構成を変更する"
${LangFileString} Reinstall_Msg5 "SMPlayer の設定をリセットする"

${LangFileString} Remove_Settings_Confirmation "Are you sure you want to reset your SMPlayer settings? This action cannot be reversed."

${LangFileString} Type_Reinstall "再インストール"
${LangFileString} Type_Downgrade "ダウングレード"
${LangFileString} Type_Upgrade "アップグレード"

${LangFileString} StartBtn "開始"

; Codecs Section
${LangFileString} Codecs_DL_Msg "MPlayer コーデックをダウンロードしています..."
${LangFileString} Codecs_DL_Retry "MPlayer コーデックは正常にインストールされませんでした。再試行しますか?"
${LangFileString} Codecs_DL_Failed "MPlayer コーデックのダウンロードに失敗しました: '$R0'。"
${LangFileString} Codecs_Inst_Failed "MPlayer コーデックのインストールに失敗しました。"

; Uninstaller
${LangFileString} Uninstaller_No_Admin "このインストールは管理者特権のあるユーザーによってのみアンインストールできます。"
${LangFileString} Uninstaller_Aborted "アンインストールはユーザーによって中止されました。"
${LangFileString} Uninstaller_NotInstalled "ディレクトリ '$INSTDIR' に SMPlayer がインストールされているように見えません。$\r$\nこのまま続行しますか (推奨されません)?"
${LangFileString} Uninstaller_InvalidDirectory "SMPlayer のインストールが見つかりません。"
${LangFileString} Uninstaller_64bitOnly "このインストールは 64 ビットの Windows でのみアンインストールできます。"

; Vista & Later Default Programs Registration
${LangFileString} Application_Description "SMPlayer はビデオ、DVD、VCD の再生のような基本的な機能から MPlayer フィルター、edl リストなどへのサポートのような高度な機能まで、MPlayer の完全なフロントエンドです。"

; Misc
${LangFileString} Info_Codecs_Backup "以前のインストールからのコーデックをバックアップしています..."
${LangFileString} Info_Codecs_Restore "以前のインストールからのコーデックを復元しています..."
${LangFileString} Info_Del_Files "ファイルを削除しています..."
${LangFileString} Info_Del_Registry "レジストリ キーを削除しています..."
${LangFileString} Info_Del_Shortcuts "ショートカットを削除しています..."
${LangFileString} Info_Rest_Assoc "ファイルの関連付けを復元しています..."
${LangFileString} Info_RollBack "変更を元に戻しています..."
${LangFileString} Info_Files_Extract "ファイルを展開しています..."
${LangFileString} Info_SMTube_Backup "SMTube をバックアップしています..."
${LangFileString} Info_SMTube_Restore "以前のインストールからの SMTube を復元しています..."
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

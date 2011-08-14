﻿;Language: Japanese (1041)
;Japanese language strings for the Windows SMPlayer NSIS installer.
;
;Save file as UTF-8 w/ BOM
;

!insertmacro LANGFILE "Japanese" "日本語"

; Startup
${LangFileString} SMPLAYER_INSTALLER_IS_RUNNING "インストーラーは既に実行中です。"
${LangFileString} SMPLAYER_INSTALLER_NO_ADMIN "このプログラムのインストール時には管理者としてログインする必要があります。"

; Components Page
${LangFileString} SMPLAYER_SECSMPLAYER_TITLE "SMPlayer (必須)"
${LangFileString} SMPLAYER_SECSMPLAYER_DESC "SMPlayer、共有ライブラリ、およびドキュメントです。"

${LangFileString} SMPLAYER_SHORTCUTGROUP_TITLE "ショートカット"
${LangFileString} SMPLAYER_SECDESKTOPSHORTCUT_TITLE "デスクトップ"
${LangFileString} SMPLAYER_SECDESKTOPSHORTCUT_DESC "デスクトップに SMPlayer へのショートカットを作成します。"
${LangFileString} SMPLAYER_SECSTARTMENU_TITLE "スタートメニュー"
${LangFileString} SMPLAYER_SECSTARTMENU_DESC "SMPlayer の [スタート] メニュー エントリを作成します。"

${LangFileString} SMPLAYER_MPLAYERGROUP_TITLE "MPlayer コンポーネント"
${LangFileString} SMPLAYER_SECMPLAYER_TITLE "MPlayer (必須)"
!ifdef WITH_MPLAYER
${LangFileString} SMPLAYER_SECMPLAYER_DESC "再生のために必要な MPlayer です。"
!else ifndef WITH_MPLAYER
${LangFileString} SMPLAYER_SECMPLAYER_DESC "再生のために必要な MPlayer です。(インストールにはインターネット接続が必要です)"
!endif
${LangFileString} SMPLAYER_SECCODECS_TITLE "バイナリ コーデック"
${LangFileString} SMPLAYER_SECCODECS_DESC "MPlayer のオプション コーデックです。(インストールにはインターネット接続が必要です)"
${LangFileString} SMPLAYER_SECCODECS_DESC_2 "MPlayer のオプション コーデックです。"

${LangFileString} SMPLAYER_SECMENCODER_DESC "A companion program to MPlayer that can be used to encode or transform supported audio or video streams."

${LangFileString} SMPLAYER_SECTHEMES_TITLE "アイコン テーマ"
${LangFileString} SMPLAYER_SECTHEMES_DESC "SMPlayer の追加アイコン テーマです。"

${LangFileString} SMPLAYER_SECTRANSLATIONS_TITLE "ローカライズ"
${LangFileString} SMPLAYER_SECTRANSLATIONS_DESC "非英語のローカライズです。"

${LangFileString} MPLAYER_CODEC_INFORMATION "バイナリ コーデック パッケージは新しい RealVideo 派生や多くの希少なフォーマットなど、まだ自然には実装されていないコーデックへのサポートを追加します。$\nDVD、MPEG-1/2/4などの最も一般的なフォーマットの再生には必要でないことにご注意ください。"

; Upgrade/Reinstall Page
${LangFileString} REINSTALL_HEADER_TEXT "既にインストールされています"
${LangFileString} REINSTALL_HEADER_SUBTEXT "SMPlayer をインストールする方法を選択します。"
${LangFileString} REINSTALL_HEADER_SUBTEXT_MAINT "実行するメンテナンス オプションを選択します。"

${LangFileString} REINSTALL_CHGSETTINGS "設定の変更 (詳細設定)"
${LangFileString} REINSTALL_UNKNOWN_VALUE "不明な PREVIOUS_VERSION_STATE の値です、中止しています"

${LangFileString} REINSTALL_OLDVER_DESCRIPTION "お使いのシステムには SMPlayer の古いバージョンがインストールされています。続行するには実行したい操作を選択して [次へ] をクリックします。"
${LangFileString} REINSTALL_OLDVER_UPGRADE "以前の設定を使用して SMPlayer をアップグレードする (推奨)"

${LangFileString} REINSTALL_NEWVER_DESCRIPTION "SMPlayer の新しいバージョンが既にインストールされています! 古いバージョンへのダウングレードは推奨されません。続行するには実行したい操作を選択して [次へ] をクリックします。"
${LangFileString} REINSTALL_NEWVER_DOWNGRADE "以前の設定を使用して SMPlayer をダウングレードする (推奨)"

${LangFileString} REINSTALL_SAMEVER_DESCRIPTION "SMPlayer ${SMPLAYER_VERSION} が既にインストールされています。続行するには実行したい操作を選択して [次へ] をクリックします。"
${LangFileString} REINSTALL_SAMEVER_ADDREMREINST "コンポーネントを追加/削除/再インストールする"
${LangFileString} REINSTALL_SAMEVER_UNINSTSMP "SMPlayer をアンインストールする"

; MPlayer Section
${LangFileString} MPLAYER_IS_DOWNLOADING "MPlayer をダウンロードしています..."
${LangFileString} MPLAYER_DL_RETRY "MPlayer は正常にインストールされませんでした。再試行しますか?"
${LangFileString} MPLAYER_DL_FAILED "MPlayer のダウンロードに失敗しました: '$R0'。"
${LangFileString} MPLAYER_INST_FAILED "MPlayer のインストールに失敗しました。MPlayer は再生に必要です。"

; Codecs Section
${LangFileString} CODECS_IS_DOWNLOADING "MPlayer コーデックをダウンロードしています..."
${LangFileString} CODECS_DL_RETRY "MPlayer コーデックは正常にインストールされませんでした。再試行しますか?"
${LangFileString} CODECS_DL_FAILED "MPlayer コーデックのダウンロードに失敗しました: '$R0'。"
${LangFileString} CODECS_INST_FAILED "MPlayer コーデックのインストールに失敗しました。"

; Version information
${LangFileString} VERINFO_IS_DOWNLOADING "バージョン情報をダウンロードしています..."
${LangFileString} VERINFO_DL_FAILED "バージョン情報のダウンロードに失敗しました: '$R0'。既定のバージョンを使用しています。"

; Uninstaller
${LangFileString} UNINSTALL_NO_ADMIN "このインストールは管理者特権のあるユーザーによってのみアンインストールできます。"
${LangFileString} UNINSTALL_ABORTED "アンインストールはユーザーによって注視されました。"
${LangFileString} SMPLAYER_NOT_INSTALLED "ディレクトリ '$INSTDIR' に SMPlayer がインストールされているように見えません。$\r$\nこのまま続行しますか (推奨されません)?"

; Vista & Later Default Programs Registration
${LangFileString} APPLICATION_DESCRIPTION "SMPlayer はビデオ、DVD、VCD の再生のような基本的な機能から MPlayer フィルター、edl リストなどへのサポートのような高度な機能まで、MPlayer の完全なフロントエンドです。"

; Misc
${LangFileString} INFO_DEL_FILES "Deleting Files..."
${LangFileString} INFO_DEL_REGISTRY "Deleting Registry Keys..."
${LangFileString} INFO_DEL_SHORTCUTS "Deleting Shortcuts..."
${LangFileString} INFO_REST_ASSOC "Restoring file associations..."
${LangFileString} INFO_FILE_EXTRACT "Extracting files..."

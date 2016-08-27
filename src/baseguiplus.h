/*  smplayer, GUI front-end for mplayer.
    Copyright (C) 2006-2016 Ricardo Villalba <rvm@users.sourceforge.net>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#ifndef BASEGUIPLUS_H
#define BASEGUIPLUS_H

#include "basegui.h"
#include "widgetactions.h"
#include <QSystemTrayIcon>
#include <QPoint>
#include "guiconfig.h"

#define SCREENS_SUPPORT
//#define DETACH_VIDEO_OPTION

#define SEND_AUDIO_OPTION

#ifdef SEND_AUDIO_OPTION
#include "deviceinfo.h"
#endif

class QMenu;
class PlaylistDock;

class TimeSliderAction;
class VolumeSliderAction;
class TimeLabelAction;
class InfoWindow;
class GlobalShortcuts;

class BaseGuiPlus : public BaseGui
{
	Q_OBJECT

public:
	BaseGuiPlus( QWidget* parent = 0, Qt::WindowFlags flags = 0);
	~BaseGuiPlus();

	virtual bool startHidden();

#ifdef SCREENS_SUPPORT
	/* virtual void toggleFullscreen(bool); */
#endif

public slots:
#ifdef GLOBALSHORTCUTS
	virtual void showPreferencesDialog();
#endif

protected:
	virtual void retranslateStrings();
	virtual void populateMainMenu();

	void loadConfig();
	void saveConfig();
	void updateShowAllAct();

	virtual void aboutToEnterFullscreen();
	virtual void aboutToExitFullscreen();
	virtual void aboutToEnterCompactMode();
	virtual void aboutToExitCompactMode();

	virtual void closeEvent( QCloseEvent * e );

	// Functions for other GUI's
	TimeSliderAction * createTimeSliderAction(QWidget * parent);
	VolumeSliderAction * createVolumeSliderAction(QWidget * parent);
	TimeLabelAction * createTimeLabelAction(TimeLabelAction::TimeLabelType type, QWidget * parent);

#ifdef SCREENS_SUPPORT
	bool isVideoDetached();
#endif

protected slots:
	// Reimplemented methods
	virtual void closeWindow();
	virtual void setWindowCaption(const QString & title);
	virtual void resizeWindow(int w, int h);
	virtual void updateMediaInfo();
	// New
	virtual void trayIconActivated(QSystemTrayIcon::ActivationReason);
	virtual void toggleShowAll();
	virtual void showAll(bool b);
	virtual void showAll();
	virtual void quit();

#if DOCK_PLAYLIST
	virtual void showPlaylist(bool b);
	void playlistClosed();

#if !USE_DOCK_TOPLEVEL_EVENT
	void dockVisibilityChanged(bool visible);
#else
	void dockTopLevelChanged(bool floating);
#endif

	void stretchWindow();
	void shrinkWindow();
#endif

#ifdef SCREENS_SUPPORT
	void updateSendToScreen();
	void sendVideoToScreen(int screen);

	void detachVideo(bool);

	void showScreensInfo();
#endif

#ifdef SEND_AUDIO_OPTION
	void updateSendAudioMenu();
	void sendAudioClicked();
#endif

#ifdef GLOBALSHORTCUTS
	void updateGlobalShortcuts();
#endif

protected:
	QSystemTrayIcon * tray;
	QMenu * context_menu;

	MyAction * quitAct;
	MyAction * showTrayAct;
	MyAction * showAllAct;

#ifdef DETACH_VIDEO_OPTION
	MyAction * detachVideoAct;
#endif

#ifdef SCREENS_SUPPORT
	MyAction * showScreensInfoAct;
	QMenu * sendToScreen_menu;
	MyActionGroup * sendToScreenGroup;

	InfoWindow * screens_info_window;
	QLabel * detached_label;
#endif

#ifdef SEND_AUDIO_OPTION
	DeviceList audio_devices;
	QMenu * sendAudio_menu;
	MyAction * sendAudioAct;
#endif

#ifdef GLOBALSHORTCUTS
	GlobalShortcuts * global_shortcuts;
#endif

	// To save state
	QPoint mainwindow_pos;
	bool mainwindow_visible;

	QPoint playlist_pos;
	bool trayicon_playlist_was_visible;

	//QPoint infowindow_pos;
	//bool infowindow_visible;

	int widgets_size; // To be able to restore the original size after exiting from compact mode

#if DOCK_PLAYLIST
	PlaylistDock * playlistdock;
	bool fullscreen_playlist_was_visible;
	bool fullscreen_playlist_was_floating;
	bool compact_playlist_was_visible;
	bool ignore_playlist_events;
#endif
};

#endif

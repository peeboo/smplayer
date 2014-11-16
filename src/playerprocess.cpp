/*  smplayer, GUI front-end for mplayer.
    Copyright (C) 2006-2014 Ricardo Villalba <rvm@users.sourceforge.net>

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

#include "playerprocess.h"
#include "mplayerprocess.h"
#include "mpvprocess.h"
#include <QFileInfo>
#include <QDebug>

PlayerProcess::PlayerProcess(QObject * parent) : MyProcess(parent) {
#if NOTIFY_SUB_CHANGES
	qRegisterMetaType<SubTracks>("SubTracks");
#endif

#if NOTIFY_AUDIO_CHANGES
	qRegisterMetaType<Tracks>("Tracks");
#endif

#if NOTIFY_CHAPTER_CHANGES
	qRegisterMetaType<Chapters>("Chapters");
#endif
}

void PlayerProcess::writeToStdin(QString text) {
	if (isRunning()) {
		qDebug("PlayerProcess::writeToStdin: %s", text.toUtf8().constData());
		#ifdef Q_OS_WIN
		write( text.toUtf8() + "\n");
		#else
		write( text.toLocal8Bit() + "\n");
		#endif
	} else {
		qWarning("PlayerProcess::writeToStdin: process not running");
	}
}

PlayerProcess * PlayerProcess::createPlayerProcess(const QString & player_bin, QObject * parent) {
	PlayerProcess * proc = 0;

	if (PlayerID::player(player_bin) == PlayerID::MPLAYER) {
		qDebug() << "PlayerProcess::createPlayerProcess: creating MplayerProcess";
		proc = new MplayerProcess(parent);
	} else {
		qDebug() << "PlayerProcess::createPlayerProcess: creating MPVProcess";
		proc = new MPVProcess(parent);
	}

	return proc;
}

#include "moc_playerprocess.cpp"

/*  smplayer, GUI front-end for mplayer.
    Copyright (C) 2006-2012 Ricardo Villalba <rvm@users.sourceforge.net>

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

#include "myapplication.h"
#include <QFile>
#include <QTime>
#include <QDir>

#include "smplayer.h"
#include "global.h"
#include "helper.h"
#include "paths.h"

#include <stdio.h>

using namespace Global;

#ifdef LOG_SMPLAYER
BaseGui * basegui_instance = 0;

QFile output_log;

void myMessageOutput( QtMsgType type, const char *msg ) {
	static QStringList saved_lines;
	static QString orig_line;
	static QString line2;
	static QRegExp rx_log;

	if (pref) {
		if (!pref->log_smplayer) return;
		rx_log.setPattern(pref->log_filter);
	} else {
		rx_log.setPattern(".*");
	}

	line2.clear();

	orig_line = QString::fromUtf8(msg);

	switch ( type ) {
		case QtDebugMsg:
			if (rx_log.indexIn(orig_line) > -1) {
				#ifndef NO_DEBUG_ON_CONSOLE
				fprintf( stderr, "Debug: %s\n", orig_line.toLocal8Bit().data() );
				#endif
				line2 = orig_line;
			}
			break;
		case QtWarningMsg:
			#ifndef NO_DEBUG_ON_CONSOLE
			fprintf( stderr, "Warning: %s\n", orig_line.toLocal8Bit().data() );
			#endif
			line2 = "WARNING: " + orig_line;
			break;
		case QtFatalMsg:
			#ifndef NO_DEBUG_ON_CONSOLE
			fprintf( stderr, "Fatal: %s\n", orig_line.toLocal8Bit().data() );
			#endif
			line2 = "FATAL: " + orig_line;
			abort();                    // deliberately core dump
		case QtCriticalMsg:
			#ifndef NO_DEBUG_ON_CONSOLE
			fprintf( stderr, "Critical: %s\n", orig_line.toLocal8Bit().data() );
			#endif
			line2 = "CRITICAL: " + orig_line;
			break;
	}

	if (line2.isEmpty()) return;

	line2 = "["+ QTime::currentTime().toString("hh:mm:ss:zzz") +"] "+ line2;

	if (basegui_instance) {
		if (!saved_lines.isEmpty()) {
			// Send saved lines first
			for (int n=0; n < saved_lines.count(); n++) {
				basegui_instance->recordSmplayerLog(saved_lines[n]);
			}
			saved_lines.clear();
		}
		basegui_instance->recordSmplayerLog(line2);
	} else {
		// GUI is not created yet, save lines for later
		saved_lines.append(line2);
	}

	if (pref) {
		if (pref->save_smplayer_log) {
			// Save log to file
			if (!output_log.isOpen()) {
				// FIXME: the config path may not be initialized if USE_LOCKS is not defined
				output_log.setFileName( Paths::configPath() + "/smplayer_log.txt" );
				output_log.open(QIODevice::WriteOnly);
			}
			if (output_log.isOpen()) {
				QString l = line2 + "\r\n";
				output_log.write(l.toUtf8().constData());
				output_log.flush();
			}
		}
	}
}
#endif

int main( int argc, char ** argv ) 
{
	MyApplication a( "smplayer", argc, argv );
	/*
	if (a.isRunning()) { 
		qDebug("Another instance is running. Exiting.");
		return 0;
	}
	*/

	a.setQuitOnLastWindowClosed(false);
	//a.connect( &a, SIGNAL( lastWindowClosed() ), &a, SLOT( quit() ) );

#if QT_VERSION >= 0x040400
	// Enable icons in menus
	QCoreApplication::setAttribute(Qt::AA_DontShowIconsInMenus, false);
#endif

	// Sets the config path
	QString config_path;

#ifdef PORTABLE_APP
	config_path = a.applicationDirPath();
#else
	// If a smplayer.ini exists in the app path, will use that path
	// for the config file by default
	if (QFile::exists( a.applicationDirPath() + "/smplayer.ini" ) ) {
		config_path = a.applicationDirPath();
		qDebug("main: using existing %s", QString(config_path + "/smplayer.ini").toUtf8().data());
	}
#endif

	QStringList args = a.arguments();
	int pos = args.indexOf("-config-path");
	if ( pos != -1) {
		if (pos+1 < args.count()) {
			pos++;
			config_path = args[pos];
			// Delete from list
			args.removeAt(pos);
			args.removeAt(pos-1);
		} else {
			printf("Error: expected parameter for -config-path\r\n");
			return SMPlayer::ErrorArgument;
		}
	}

#if defined(LOG_SMPLAYER) && !defined(GUI_CHANGE_ON_RUNTIME)
    qInstallMsgHandler( myMessageOutput );
#endif

	SMPlayer * smplayer = new SMPlayer(config_path);
	SMPlayer::ExitCode c = smplayer->processArgs( args );
	if (c != SMPlayer::NoExit) {
		return c;
	}

#ifdef LOG_SMPLAYER
	basegui_instance = smplayer->gui();
#endif
	smplayer->start();

	int r = a.exec();

#ifdef LOG_SMPLAYER
	basegui_instance = 0;
#endif

	delete smplayer;

#ifdef LOG_SMPLAYER
	if (output_log.isOpen()) output_log.close();
#endif

	return r;
}


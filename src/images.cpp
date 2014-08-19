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

#include "images.h"
#include <QFile>
#include <QDebug>

#ifdef USE_RESOURCES
#include <QResource>
#endif

#ifdef SMCODE
#include "global.h"
#include "preferences.h"
#include "paths.h"
using namespace Global;
#endif

QString Images::current_theme;
QString Images::themes_path;

#ifdef USE_RESOURCES
QString Images::last_resource_loaded;

QString Images::resourceFilename() {
	QString filename = QString::null;

	if ((!themes_path.isEmpty()) && (!current_theme.isEmpty())) {
		filename = themes_path +"/"+ current_theme +"/"+ current_theme +".rcc";
	}

	qDebug() << "Images::resourceFilename:" << filename;

	return filename;
}
#endif

void Images::setTheme(const QString & name) {
	current_theme = name;

#ifdef SMCODE
	QString dir = Paths::configPath() + "/themes/" + name;
	if (QFile::exists(dir)) {
		setThemesPath(Paths::configPath() + "/themes/");
	} else {
		setThemesPath(Paths::themesPath());
	}
#endif

#ifdef USE_RESOURCES
	if (!last_resource_loaded.isEmpty()) {
		qDebug() << "Images::setTheme: unloading" << last_resource_loaded;
		QResource::unregisterResource(last_resource_loaded);
		last_resource_loaded = QString::null;
	}

	QString rs_file = resourceFilename();
	if (QFile::exists(rs_file)) {
		qDebug() << "Images::setTheme: loading" << rs_file;
		QResource::registerResource(rs_file);
		last_resource_loaded = rs_file;
	}
#endif
}

void Images::setThemesPath(const QString & folder) {
	themes_path = folder;
	qDebug() << "Images::setThemesPath:" << themes_path;
}

QString Images::file(const QString & name) {
#ifdef SMCODE
	if (current_theme != pref->iconset) {
		setTheme(pref->iconset);
	}
#endif

#ifdef USE_RESOURCES
	QString icon_name = ":/" + current_theme + "/"+ name + ".png";
#else
	QString icon_name = themes_path +"/"+ current_theme + "/"+ name + ".png";
#endif
	if (!QFile::exists(icon_name)) {
		icon_name = ":/icons-png/" + name + ".png";
	}

	qDebug() << "Images::file:" << icon_name;
	return icon_name;
}


QPixmap Images::icon(QString name, int size, bool png) {
	QString icon_name = file(name);
	QPixmap p(icon_name);

	if (!p.isNull()) {
		if (size != -1) {
			p = resize(&p, size);
		}
	}

	return p;
}

QPixmap Images::resize(QPixmap *p, int size) {
	return QPixmap::fromImage( (*p).toImage().scaled(size,size,Qt::IgnoreAspectRatio,Qt::SmoothTransformation) );
}

QPixmap Images::flip(QPixmap *p) {
	return QPixmap::fromImage( (*p).toImage().mirrored(true, false) );
}

QPixmap Images::flippedIcon(QString name, int size, bool png) {
	QPixmap p = icon(name, size, png);
	p = flip(&p);
	return p;
}

QIcon Images::multiIcon(QString name, QString fallback_icon) {
	QPixmap pix = Images::icon(name);
	if (pix.isNull()) return Images::icon(fallback_icon);

	QIcon icon;
	int w = pix.width();
	int h = pix.height();
	icon.addPixmap(pix.copy(0, 0, w, h/4 ), QIcon::Normal, QIcon::Off);
	//icon.setPixmap(pix.copy(0, h/4, w, h/4 ), MyIcon::MouseOver, MyIcon::Off);
	//icon.setPixmap(pix.copy(0, h/2, w, h/4 ), MyIcon::MouseDown, MyIcon::Off);
	icon.addPixmap(pix.copy(0, 3*h/4, w, h/4 ), QIcon::Disabled, QIcon::Off);
	return icon;
}

#ifdef SMCODE
QString Images::styleSheet(){
	QString filename;
	filename = themesDirectory() + "/main.css";
	QFile file(filename);
	if (file.exists()) {
		file.open(QFile::ReadOnly | QFile::Text);
		QString css = QString::fromUtf8(file.readAll().constData());
		return css;
	}
	else
		return "";
}

QString Images::themesDirectory(){
	QString skin = pref->iconset;
	QString dirname;
	if (!skin.isEmpty()) {
		dirname = Paths::configPath() + "/themes/" + skin;
		if (!QFile::exists(dirname)) {
			dirname = Paths::themesPath() + "/" + skin ;
		}
	}
	return dirname;
}
#endif

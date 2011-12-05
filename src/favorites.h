/*  smplayer, GUI front-end for mplayer.
    Copyright (C) 2006-2011 Ricardo Villalba <rvm@escomposlinux.org>

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

#ifndef _FAVORITES_H_
#define _FAVORITES_H_

#include <QObject>
#include <QString>
#include <QList>

class QMenu;
class QAction;
class QWidget;

class Favorite 
{
public:
	Favorite() {}
	Favorite(QString name, QString file, QString icon = QString::null) { _name = name; _file = file; _icon = icon; };
	virtual ~Favorite() {};

	void setName(QString name) { _name = name; };
	void setFile(QString file) { _file = file; };
	void setIcon(QString file) { _icon = file; };

	QString name() { return _name; };
	QString file() { return _file; }
	QString icon() { return _icon; };

protected:
	QString _name, _file, _icon;
};

typedef QList<Favorite> FavoriteList;

class Favorites : public QObject
{
	Q_OBJECT
public:
	Favorites(QString filename, QWidget * parent = 0);
	~Favorites();

	QMenu * menu();
	QAction * editAct() { return edit_act; };
	QAction * jumpAct() { return jump_act; };
	QAction * nextAct() { return next_act; };
	QAction * previousAct() { return previous_act; };

public slots:
	void next();
	void previous();

signals:
	void activated(QString filemane);

protected:
	void save();
	void load();
	void createMenu();
	void updateMenu();
	void populateMenu();

	int findFile(QString filename);

	// Mark current action in the menu
	void markCurrent();

protected slots:
	void triggered_slot(QAction * action);
	virtual void edit();
	virtual void jump();

protected:
	FavoriteList f_list;
	QString _filename;
	QMenu * _menu;
	QAction * edit_act;
	QAction * jump_act;
	QAction * next_act;
	QAction * previous_act;

	QWidget * parent_widget;

	// Current (or last) file clicked
	QString current_file;

	// Last item selected in the jump dialog
	int last_item;
};

#endif


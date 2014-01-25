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

#ifndef OSCLIENT_H
#define OSCLIENT_H

#include "maiaXmlRpcClient.h"

class OSSubtitle {
public:
	QString movie, releasename, link, iso639, language, date;
	QString format, comments, detail, rating, files, user;
};

class OSClient : public QObject {
	Q_OBJECT

public:
	OSClient(QObject* parent = 0);
	void setProxy(const QNetworkProxy & proxy);

public slots:
	void setServer(const QString & server);
	void search(const QString & hash, qint64 file_size);
	QList<OSSubtitle> subtitleList() { return s_list; };

private slots:
	void login();
	void doSearch();

	void gotFault(int, const QString &);

	void responseLogin(QVariant &);
	void responseSearch(QVariant &);

signals:
	void loggedIn();
	void loginFailed();
	void searchFinished();
	void searchFailed();
	void errorFound(int, const QString &);

private:
	MaiaXmlRpcClient *rpc;
	QString token;
	bool logged_in;
	QString search_hash;
	qint64 search_size;
	QList <OSSubtitle> s_list;
};

#endif

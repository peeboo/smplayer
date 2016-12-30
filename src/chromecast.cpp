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

#include "chromecast.h"
#include "links.h"
#include <QUrl>
#include <QFileInfo>
#include <QDesktopServices>
#include <QNetworkInterface>
#include <QProcess>
#include <QDebug>

Chromecast * Chromecast::instance_obj = 0;

Chromecast * Chromecast::instance() {
	if (instance_obj == 0) {
		instance_obj = new Chromecast();
	}
	return instance_obj;
}

void Chromecast::deleteInstance() {
	if (instance_obj) {
		delete instance_obj;
	}
}


Chromecast::Chromecast(QObject * parent)
	: QObject(parent)
	, server_process(0)
{
}

Chromecast::~Chromecast() {
	if (server_process) {
		stopServer();
	}
}

void Chromecast::openStream(const QString & url, const QString & title) {
	QDesktopServices::openUrl(QUrl(URL_CHROMECAST "/?title=" + title.toUtf8().toBase64() +
		"&url=" + url.toUtf8().toBase64()));
}

void Chromecast::openLocal(const QString & file, const QString & title) {
	qDebug() << "Chromecast::openLocal:" << file;

	QFileInfo fi(file);
	QString dir = fi.absolutePath();
	QString filename = fi.fileName();

	qDebug() << "Chromecast::openLocal: dir:" << dir;
	qDebug() << "Chromecast::openLocal: filename:" << filename;

	QString local_address = defaultLocalAddress();
	qDebug() << "Chromecast::openLocal: chosen address:" << local_address;

	if (!local_address.isEmpty()) {
		// Run web server
		startServer(dir);


		QString url = local_address + ":8000/" + filename;
		qDebug() << "Chromecast::openLocal: url:" << url;
		/*
		QDesktopServices::openUrl(QUrl(URL_CHROMECAST "/?title=" + title.toUtf8().toBase64() +
			"&url=" + url.toUtf8().toBase64()));
		*/
	}
}

QStringList Chromecast::localAddresses() {
	QStringList l;

	foreach(const QHostAddress &address, QNetworkInterface::allAddresses()) {
		if (address.protocol() == QAbstractSocket::IPv4Protocol && address != QHostAddress(QHostAddress::LocalHost)) {
			l << address.toString();
		}
	}

	return l;
}

QString Chromecast::defaultLocalAddress() {
	QString local_address;

	QStringList addresses = localAddresses();
	qDebug() << "Chromecast::defaultLocalAddress: all IPv4 addresses:" << addresses;

	foreach(QString address, addresses) {
		//qDebug() << "Chromecast::defaultLocalAddress: address:" << address;
		if (address.startsWith("192.") && !address.endsWith(".1")) {
			local_address = address;
			break;
		}
	}

	if (local_address.isEmpty() && !addresses.isEmpty()) local_address = addresses[0];
	return local_address;
}

void Chromecast::startServer(const QString & doc_root) {
#ifdef Q_OS_LINUX
	qDebug("Chromecast::startServer");

	if (server_process == 0) {
		server_process = new QProcess(this);
		server_process->setProcessChannelMode( QProcess::MergedChannels );
		connect(server_process, SIGNAL(readyReadStandardOutput()), this, SLOT(readProcessOutput()));
		connect(server_process, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(processFinished(int, QProcess::ExitStatus)));
	}

	if (server_process->state() != QProcess::NotRunning) {
		//stopServer();
	}

	QString prog;
	QStringList args;

	prog = "webfsd";
	args << "-F" << "-d" << "-4" << "-p" << "8010" << "-r" << doc_root;

	server_process->start(prog, args);
#endif
}


void Chromecast::stopServer() {
	qDebug("Chromecast::stopServer");

	if (server_process) {
		server_process->terminate();
		if (!server_process->waitForFinished(5000)) {
			server_process->kill();
		}
	}
}

// Slots
void Chromecast::readProcessOutput() {
	QByteArray line;
	while (server_process->canReadLine()) {
		line = server_process->readLine().trimmed();
		qDebug() << "Chromecast::readProcessOutput: line:" << line;
	}
}

void Chromecast::processFinished(int exit_code, QProcess::ExitStatus exit_status) {
	qDebug() << "Chromecast::processFinished: exit_code:" << exit_code << "exit_status:" << exit_status;
}

#include "moc_chromecast.cpp"

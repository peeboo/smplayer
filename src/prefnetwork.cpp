/*  smplayer, GUI front-end for mplayer.
    Copyright (C) 2006-2017 Ricardo Villalba <rvm@users.sourceforge.net>

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

#include "prefnetwork.h"
#include "preferences.h"
#include "images.h"
#include <QNetworkProxy>

#ifdef YOUTUBE_SUPPORT
#include "retrieveyoutubeurl.h"
#endif

#ifdef CHROMECAST_SUPPORT
#include "chromecast.h"
#endif

PrefNetwork::PrefNetwork(QWidget * parent, Qt::WindowFlags f)
	: PrefWidget(parent, f )
{
	setupUi(this);

	proxy_type_combo->addItem( tr("HTTP"), QNetworkProxy::HttpProxy);
	proxy_type_combo->addItem( tr("SOCKS5"), QNetworkProxy::Socks5Proxy);

#ifdef YOUTUBE_SUPPORT
	yt_quality_combo->addItem( "240p (flv)", RetrieveYoutubeUrl::FLV_240p );

	yt_quality_combo->addItem( "360p (flv)", RetrieveYoutubeUrl::FLV_360p );
	yt_quality_combo->addItem( "360p (mp4)", RetrieveYoutubeUrl::MP4_360p );
	yt_quality_combo->addItem( "360p (webm)", RetrieveYoutubeUrl::WEBM_360p );

	yt_quality_combo->addItem( "480p (flv)", RetrieveYoutubeUrl::FLV_480p );
	yt_quality_combo->addItem( "480p (webm)", RetrieveYoutubeUrl::WEBM_480p );

	yt_quality_combo->addItem( "720p (mp4)", RetrieveYoutubeUrl::MP4_720p );
	yt_quality_combo->addItem( "720p (webm)", RetrieveYoutubeUrl::WEBM_720p );

	yt_quality_combo->addItem( "1080p (mp4)", RetrieveYoutubeUrl::MP4_1080p );
	yt_quality_combo->addItem( "1080p (webm)", RetrieveYoutubeUrl::WEBM_1080p );
#endif

	connect(streaming_type_combo, SIGNAL(currentIndexChanged(int)), this, SLOT(streaming_type_combo_changed(int)));

#ifndef YOUTUBE_SUPPORT
	youtube_box->hide();
#endif

	retranslateStrings();
}

PrefNetwork::~PrefNetwork()
{
}

QString PrefNetwork::sectionName() {
	return tr("Network");
}

QPixmap PrefNetwork::sectionIcon() {
	return Images::icon("pref_network");
}

void PrefNetwork::retranslateStrings() {
	retranslateUi(this);

	int streaming_item = streaming_type_combo->currentIndex();
	streaming_type_combo->clear();
	streaming_type_combo->addItem(tr("Disabled"), Preferences::NoStreaming);
	#ifdef MPV_SUPPORT
	streaming_type_combo->addItem(tr("Auto"), Preferences::StreamingAuto);
	#endif
	#ifdef YOUTUBE_SUPPORT
	streaming_type_combo->addItem("YouTube", Preferences::StreamingYT);
	#endif
	#ifdef MPV_SUPPORT
	streaming_type_combo->addItem("mpv + youtube-dl", Preferences::StreamingYTDL);
	#endif
	streaming_type_combo->setCurrentIndex(streaming_item);

	createHelp();
}

void PrefNetwork::setData(Preferences * pref) {
	use_proxy_check->setChecked(pref->use_proxy);
	proxy_hostname_edit->setText(pref->proxy_host);
	proxy_port_spin->setValue(pref->proxy_port);
	proxy_username_edit->setText(pref->proxy_username);
	proxy_password_edit->setText(pref->proxy_password);

	setProxyType(pref->proxy_type);

	setStreamingType(pref->streaming_type);
#ifdef YOUTUBE_SUPPORT
	setYTQuality( pref->yt_quality );
	yt_user_agent_edit->setText( pref->yt_user_agent );
#endif

#ifdef CHROMECAST_SUPPORT
	Chromecast * cc = Chromecast::instance();
	QString local_ip = cc->localAddress();
	//if (local_ip.isEmpty()) local_ip = cc->findLocalAddress();
	local_ip_edit->setText(local_ip);
	port_spin->setValue(cc->serverPort());
	directory_listing_check->setChecked(cc->directoryListing());
#endif
}

void PrefNetwork::getData(Preferences * pref) {
	requires_restart = false;

	pref->use_proxy = use_proxy_check->isChecked();
	pref->proxy_host = proxy_hostname_edit->text();
	pref->proxy_port = proxy_port_spin->value();
	pref->proxy_username = proxy_username_edit->text();
	pref->proxy_password = proxy_password_edit->text();

	pref->proxy_type = proxyType();

	pref->streaming_type = streamingType();
#ifdef YOUTUBE_SUPPORT
	pref->yt_quality = YTQuality();
	pref->yt_user_agent = yt_user_agent_edit->text();
#endif

#ifdef CHROMECAST_SUPPORT
	Chromecast * cc = Chromecast::instance();
	cc->setLocalAddress(local_ip_edit->text());
	cc->setServerPort(port_spin->value());
	cc->setDirectoryListing(directory_listing_check->isChecked());
#endif
}

void PrefNetwork::setProxyType(int type) {
	int index = proxy_type_combo->findData(type);
	if (index == -1) index = 0;
	proxy_type_combo->setCurrentIndex(index);
}

int PrefNetwork::proxyType() {
	int index = proxy_type_combo->currentIndex();
	return proxy_type_combo->itemData(index).toInt();
}

#ifdef YOUTUBE_SUPPORT
void PrefNetwork::setYTQuality(int q) {
	yt_quality_combo->setCurrentIndex(yt_quality_combo->findData(q));
}

int PrefNetwork::YTQuality() {
	int index = yt_quality_combo->currentIndex();
    return yt_quality_combo->itemData(index).toInt();
}
#endif

void PrefNetwork::setStreamingType(int type) {
	int i = streaming_type_combo->findData(type);
	if (i < 0) i = 0;
	streaming_type_combo->setCurrentIndex(i);
}

int PrefNetwork::streamingType() {
	int i = streaming_type_combo->currentIndex();
	return streaming_type_combo->itemData(i).toInt();
}

void PrefNetwork::streaming_type_combo_changed(int i) {
	//qDebug() << "PrefNetwork::streaming_type_combo_changed:" << i;
	youtube_box->setEnabled(i == Preferences::StreamingYT || i == Preferences::StreamingAuto);
}

void PrefNetwork::createHelp() {
	clearHelp();

	addSectionTitle(tr("YouTube"));

	setWhatsThis(streaming_type_combo, tr("Support for video sites"),
		"<ul>"
		"<li><b>" + tr("Disabled") +":</b> " + tr("support for video sites is turned off") +"</li>"+
		#ifdef MPV_SUPPORT
		"<li><b>" + tr("Auto") +":</b> " + tr("it will try to use mpv + youtube-dl only for the sites that require it") +"</li>"+
		#endif
		#ifdef YOUTUBE_SUPPORT
		"<li><b>YouTube:</b> " + tr("only the internal support for YouTube will be used") +"</li>"+
		#endif
		#ifdef MPV_SUPPORT
		"<li><b>mpv + youtube-dl:</b> " +tr("uses mpv + youtube-dl for all sites") +"</li>"+
		#endif
		"</ul>"
	);

	/*
	setWhatsThis(yt_support_check, tr("Enable Youtube internal support"),
		tr("If this option is checked, SMPlayer will try to play videos from Youtube URLs.") );
	*/

	setWhatsThis(yt_quality_combo, tr("Playback quality"),
		tr("Select the preferred quality for YouTube videos.") );

	setWhatsThis(yt_user_agent_edit, tr("User agent"),
		tr("Set the user agent that SMPlayer will use when connecting to YouTube.") );

#ifdef MPV_SUPPORT
	/*
	setWhatsThis(streaming_check, tr("Enable mpv's support for streaming sites"),
		tr("If this option is checked, SMPlayer will try to play videos from "
           "streaming sites like Youtube, Dailymotion, Vimeo, Vevo, etc.") + "<br>"+
		tr("Requires mpv and youtube-dl.") );
	*/
#endif

	addSectionTitle(tr("Proxy"));

	setWhatsThis(use_proxy_check, tr("Enable proxy"),
		tr("Enable/disable the use of the proxy.") );

	setWhatsThis(proxy_hostname_edit, tr("Host"),
		tr("The host name of the proxy.") );

	setWhatsThis(proxy_port_spin, tr("Port"),
		tr("The port of the proxy.") );

	setWhatsThis(proxy_username_edit, tr("Username"),
		tr("If the proxy requires authentication, this sets the username.") );

	setWhatsThis(proxy_password_edit, tr("Password"),
		tr("The password for the proxy. <b>Warning:</b> the password will be saved "
           "as plain text in the configuration file.") );

	setWhatsThis(proxy_type_combo, tr("Type"),
		tr("Select the proxy type to be used.") );

}

#include "moc_prefnetwork.cpp"

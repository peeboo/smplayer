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

#include <QDir>
#include <QDebug>
#include "inforeader.h"
#include "deviceinfo.h"

void MPVProcess::addArgument(const QString & /*a*/) {
}

void MPVProcess::setMedia(const QString & media, bool is_playlist) {
	arg << "--term-playing-msg="
			"MPV_VERSION=${=mpv-version:}\n"
			"INFO_VIDEO_WIDTH=${=width}\nINFO_VIDEO_HEIGHT=${=height}\n"
			"INFO_VIDEO_ASPECT=${=video-aspect}\n"
//			"INFO_VIDEO_DSIZE=${=dwidth}x${=dheight}\n"
			"INFO_VIDEO_FPS=${=container-fps:${=fps}}\n"
//			"INFO_VIDEO_BITRATE=${=video-bitrate}\n"
			"INFO_VIDEO_FORMAT=${=video-format}\n"
			"INFO_VIDEO_CODEC=${=video-codec}\n"

//			"INFO_AUDIO_BITRATE=${=audio-bitrate}\n"
//			"INFO_AUDIO_FORMAT=${=audio-format}\n" // old
			"INFO_AUDIO_FORMAT=${=audio-codec-name}\n"
			"INFO_AUDIO_CODEC=${=audio-codec}\n"
//			"INFO_AUDIO_RATE=${=audio-samplerate}\n" // old
			"INFO_AUDIO_RATE=${=audio-params/samplerate}\n"
//			"INFO_AUDIO_NCH=${=audio-channels}\n" // old
			"INFO_AUDIO_NCH=${=audio-params/channel-count}\n"

//			"INFO_LENGTH=${=length}\n"
			"INFO_LENGTH=${=duration:${=length}}\n"

			"INFO_DEMUXER=${=current-demuxer:${=demuxer}}\n"
			"INFO_SEEKABLE=${=seekable}\n"
			"INFO_TITLES=${=disc-titles}\n"
			"INFO_CHAPTERS=${=chapters}\n"
			"INFO_TRACKS_COUNT=${=track-list/count}\n"

			"METADATA_TITLE=${metadata/by-key/title:}\n"
			"METADATA_ARTIST=${metadata/by-key/artist:}\n"
			"METADATA_ALBUM=${metadata/by-key/album:}\n"
			"METADATA_GENRE=${metadata/by-key/genre:}\n"
			"METADATA_DATE=${metadata/by-key/date:}\n"
			"METADATA_TRACK=${metadata/by-key/track:}\n"
			"METADATA_COPYRIGHT=${metadata/by-key/copyright:}\n"

			"INFO_MEDIA_TITLE=${=media-title:}\n"
			"INFO_STREAM_PATH=${stream-path}\n";

#ifdef CUSTOM_STATUS
	arg << "--term-status-msg=STATUS: ${=time-pos} / ${=duration:${=length:0}} P: ${=pause} B: ${=paused-for-cache} I: ${=core-idle} VB: ${=video-bitrate:0} AB: ${=audio-bitrate:0}";
#endif

	if (is_playlist) {
		arg << "--playlist=" + media;
	} else {
		arg << media;
	}

#ifdef CAPTURE_STREAM
	capturing = false;
#endif

#ifdef OSD_WITH_TIMER
	if (!osd_timer) {
		osd_timer = new QTimer(this);
		osd_timer->setInterval(500);
		connect(osd_timer, SIGNAL(timeout()), this, SLOT(displayInfoOnOSD()));
	}
#endif
}

void MPVProcess::setFixedOptions() {
	arg << "--no-config";
	arg << "--no-quiet";
	arg << "--terminal";
	arg << "--no-msg-color";
	arg << "--input-file=/dev/stdin";
	//arg << "--no-osc";
	//arg << "--msg-level=vd=v";
}

void MPVProcess::disableInput() {
	arg << "--no-input-default-bindings";
	if (isOptionAvailable("--input-vo-keyboard")) {
		arg << "--input-vo-keyboard=no";
	} else {
		arg << "--input-x11-keyboard=no";
	}
	arg << "--no-input-cursor";
	arg << "--cursor-autohide=no";
}

bool MPVProcess::isOptionAvailable(const QString & option) {
	static QStringList option_list;
	static QString mpv_bin;

	if (option_list.isEmpty() || mpv_bin != executable()) {
		InfoReader * ir = InfoReader::obj(executable());
		ir->getInfo();
		option_list = ir->optionList();
		mpv_bin = executable();
		//qDebug() << "MPVProcess::isOptionAvailable: option_list:" << option_list;
	}

	return option_list.contains(option);
}

void MPVProcess::addVFIfAvailable(const QString & vf, const QString & value) {
	InfoReader * ir = InfoReader::obj(executable());
	ir->getInfo();
	if (ir->vfList().contains(vf)) {
		QString s = "--vf-add=" + vf;
		if (!value.isEmpty()) s += "=" + value;
		arg << s;
	} else {
		QString f = vf +"="+ value;
		qDebug("MPVProcess::addVFIfAvailable: filter %s is not used because it's not available", f.toLatin1().constData());
	}
}

void MPVProcess::messageFilterNotSupported(const QString & filter_name) {
	QString text = tr("the '%1' filter is not supported by mpv").arg(filter_name);
	writeToStdin(QString("show_text \"%1\" 3000").arg(text));
}

void MPVProcess::enableScreenshots(const QString & dir, const QString & templ, const QString & format) {
	if (!templ.isEmpty()) {
		arg << "--screenshot-template=" + templ;
	}

	if (!format.isEmpty()) {
		arg << "--screenshot-format=" + format;
	}

	if (!dir.isEmpty()) {
		QString d = QDir::toNativeSeparators(dir);
		if (!isOptionAvailable("--screenshot-directory")) {
			qDebug() << "MPVProcess::enableScreenshots: the option --screenshot-directory is not available in this version of mpv";
			qDebug() << "MPVProcess::enableScreenshots: changing working directory to" << d;
			setWorkingDirectory(d);
		} else {
			arg << "--screenshot-directory=" + d;
		}
	}
}

void MPVProcess::setOption(const QString & option_name, const QVariant & value) {
	if (option_name == "cache") {
		int cache = value.toInt();
		if (cache > 31) {
			arg << "--cache=" + value.toString();
		} else {
			arg << "--cache=no";
		}
	}
	else
	if (option_name == "cache_auto") {
		arg << "--cache=auto";
	}
	else
	if (option_name == "ss") {
		arg << "--start=" + value.toString();
	}
	else
	if (option_name == "endpos") {
		arg << "--length=" + value.toString();
	}
	else
	if (option_name == "loop") {
		QString o = value.toString();
		if (o == "0") o = "inf";
		arg << "--loop=" + o;
	}
	else
	if (option_name == "ass") {
		arg << "--sub-ass";
	}
	else
	if (option_name == "noass") {
		arg << "--no-sub-ass";
	}
	else
	if (option_name == "sub-fuzziness") {
		QString v;
		switch (value.toInt()) {
			case 1: v = "fuzzy"; break;
			case 2: v = "all"; break;
			default: v = "exact";
		}
		arg << "--sub-auto=" + v;
	}
	else
	if (option_name == "audiofile") {
		arg << "--audio-file=" + value.toString();
	}
	else
	if (option_name == "delay") {
		arg << "--audio-delay=" + value.toString();
	}
	else
	if (option_name == "subdelay") {
		arg << "--sub-delay=" + value.toString();
	}
	else
	if (option_name == "sub") {
		arg << "--sub-file=" + value.toString();
	}
	else
	if (option_name == "subpos") {
		arg << "--sub-pos=" + value.toString();
	}
	else
	if (option_name == "font") {
		arg << "--osd-font=" + value.toString();
	}
	else
	if (option_name == "subcp") {
		QString cp = value.toString();
		if (!cp.startsWith("enca")) cp = "utf8:" + cp;
		arg << "--sub-codepage=" + cp;
	}
	else
	if (option_name == "osdlevel") {
		arg << "--osd-level=" + value.toString();
	}
	else
	if (option_name == "sws") {
		arg << "--sws-scaler=lanczos";
	}
	else
	if (option_name == "channels") {
		arg << "--audio-channels=" + value.toString();
	}
	else
	if (option_name == "subfont-text-scale" || option_name == "ass-font-scale") {
		arg << "--sub-scale=" + value.toString();
	}
	else
	if (option_name == "ass-line-spacing") {
		QString line_spacing = "--ass-line-spacing";
		if (isOptionAvailable("--sub-ass-line-spacing")) line_spacing = "--sub-ass-line-spacing";
		arg << line_spacing + "=" + value.toString();
	}
	else
	if (option_name == "stop-xscreensaver") {
		bool stop_ss = value.toBool();
		if (stop_ss) arg << "--stop-screensaver"; else arg << "--no-stop-screensaver";
	}
	else
	if (option_name == "correct-pts") {
		bool b = value.toBool();
		if (b) arg << "--correct-pts"; else arg << "--no-correct-pts";
	}
	else
	if (option_name == "idx") {
		arg << "--index=default";
	}
	else
	if (option_name == "softvol") {
		if (value.toString() == "off") {
			if (isOptionAvailable("--volume-max")) {
				arg << "--volume-max=100";
			}
		} else {
			int v = value.toInt();
			if (v < 100) v = 100;
			if (isOptionAvailable("--volume-max")) {
				arg << "--volume-max=" + QString::number(v);
			} else {
				arg << "--softvol=yes";
				arg << "--softvol-max=" + QString::number(v);
			}
		}
	}
	else
	if (option_name == "subfps") {
		arg << "--sub-fps=" + value.toString();
	}
	else
	if (option_name == "forcedsubsonly") {
		arg << "--sub-forced-only";
	}
	else
	if (option_name == "prefer-ipv4" || option_name == "prefer-ipv6" ||
	    option_name == "dr" || option_name == "double" ||
	    option_name == "adapter" || option_name == "edl" ||
	    option_name == "slices" || option_name == "colorkey" ||
	    option_name == "subcc" || option_name == "vobsub" ||
	    option_name == "zoom" || option_name == "flip-hebrew" ||
	    option_name == "autoq")
	{
		// Ignore
	}
	else
	if (option_name == "tsprog") {
		// Unsupported
	}
	else
	if (option_name == "dvdangle") {
		/*
		arg << "--dvd-angle=" + value.toString();
		*/
	}
	else
	if (option_name == "threads") {
		arg << "--vd-lavc-threads=" + value.toString();
	}
	else
	if (option_name == "skiploopfilter") {
		arg << "--vd-lavc-skiploopfilter=all";
	}
	else
	if (option_name == "keepaspect" || option_name == "fs") {
		bool b = value.toBool();
		if (b) arg << "--" + option_name; else arg << "--no-" + option_name;
	}
	else
	if (option_name == "vo") {
		QString vo = value.toString();
		if (vo.endsWith(",")) vo.chop(1);
		#ifndef Q_OS_WIN
		if (isOptionAvailable("--xv-adaptor")) {
			QRegExp rx("xv:adaptor=(\\d+)");
			if (rx.indexIn(vo) > -1) {
				QString adaptor = rx.cap(1);
				vo = "xv";
				arg << "--xv-adaptor=" + adaptor;
			}
		}
		#endif
		arg << "--vo=" + vo + ",";
	}
	else
	if (option_name == "ao") {
		QString ao = value.toString();

		QStringList l;
		if (ao.contains(":")) l = DeviceInfo::extractDevice(ao);
		if (l.count() > 0) ao = l[0];

		if (isOptionAvailable("--audio-device")) {
			if (l.count() == 3) {
				#ifndef Q_OS_WIN
				if (l[0] == "pulse") {
					arg << "--audio-device=pulse/" + l[2];
				}
				#if USE_MPV_ALSA_DEVICES
				else
				if (l[0] == "alsa") {
					arg << "--audio-device=alsa/" + l[1];
				}
				#endif
				#else
				if (l[0] == "dsound") {
					arg << "--audio-device=dsound/" + l[1];
				}
				else
				if (l[0] == "wasapi") {
					arg << "--audio-device=wasapi/" + l[1];
				}
				#endif
			}
		} else {
			#ifndef Q_OS_WIN
			if (l.count() > 1) {
				if (l[0] == "alsa") {
					ao = "alsa:device=[hw:" + l[1] + "]";
				}
				else
				if (l[0] == "pulse") {
					ao = "pulse::" + l[1];
				}
			}
			#endif
		}
		arg << "--ao=" + ao + ",";
	}
	else
	if (option_name == "vc") {
		qDebug() << "MPVProcess::setOption: video codec ignored";
	}
	else
	if (option_name == "ac") {
		qDebug() << "MPVProcess::setOption: audio codec ignored";
	}
	else
	if (option_name == "afm") {
		QString s = value.toString();
		if (s == "hwac3") arg << "--ad=spdif:ac3,spdif:dts";
	}
	else
	if (option_name == "enable_streaming_sites_support") {
		if (isOptionAvailable("--ytdl")) {
			if (value.toBool()) arg << "--ytdl"; else arg << "--ytdl=no";
		}
	}
	else
	if (option_name == "fontconfig") {
		if (isOptionAvailable("--use-text-osd")) {
			bool b = value.toBool();
			if (b) arg << "--use-text-osd=yes"; else arg << "--use-text-osd=no";
		}
	}
	else
	if (option_name == "verbose") {
		arg << "-v";
		verbose = true;
	}
	else
	if (option_name == "mute") {
		arg << "--mute=yes";
	}
	else
	if (option_name == "scaletempo") {
		if (isOptionAvailable("--audio-pitch-correction")) {
			bool enabled = value.toBool();
			if (enabled) arg << "--audio-pitch-correction=yes"; else arg << "--audio-pitch-correction=no";
		}
	}
	else
	if (option_name == "vf-add") {
		if (!value.isNull()) arg << "--vf-add=" + value.toString();
	}
	else
	if (option_name == "af-add") {
		if (!value.isNull()) arg << "--af-add=" + value.toString();
	}
	else
	if (option_name == "wid" ||
	    option_name == "aid" || option_name == "vid" ||
	    option_name == "volume" ||
	    option_name == "ass-styles" || option_name == "ass-force-style" ||
	    option_name == "embeddedfonts" ||
	    option_name == "osd-scale" ||
	    option_name == "speed" ||
	    option_name == "contrast" || option_name == "brightness" ||
	    option_name == "hue" || option_name == "saturation" || option_name == "gamma" ||
	    option_name == "monitorpixelaspect" || option_name == "monitoraspect" ||
	    option_name == "mc" ||
	    option_name == "framedrop" ||
	    option_name == "priority" ||
	    option_name == "hwdec" ||
	    option_name == "autosync" ||
	    option_name == "dvd-device" || option_name == "cdrom-device" ||
	    option_name == "demuxer" ||
	    option_name == "frames" ||
	    option_name == "user-agent" || option_name == "referrer" ||
	    option_name == "ab-loop-a" || option_name == "ab-loop-b")
	{
		QString s = "--" + option_name;
		if (!value.isNull()) s += "=" + value.toString();
		arg << s;
	}
	else
	{
		qDebug() << "MPVProcess::setOption: unknown option:" << option_name;
	}
}

void MPVProcess::addUserOption(const QString & option) {
	qDebug() << "MPVProcess::addUserOption:" << option;

	// Remove quotes
	QString s = option;
	if (s.count("=\"") == 1 && s.endsWith("\"")) {
		s.replace("=\"", "=");
		s.chop(1);
	}
	else
	if (s.startsWith("\"") && s.endsWith("\"")) {
		s.remove(0, 1);
		s.chop(1);
	}

	qDebug() << "MPVProcess::addUserOption: s:" << s;

	arg << s;
	if (option == "-v") {
		verbose = true;
	}
}

void MPVProcess::addVF(const QString & filter_name, const QVariant & value) {
	QString option = value.toString();

	if ((filter_name == "harddup") || (filter_name == "hue")) {
		// ignore
	}
	else
	if (filter_name == "eq2") {
		arg << "--vf-add=eq";
	}
	else
	if (filter_name == "blur") {
		addVFIfAvailable("lavfi", "[unsharp=la=-1.5:ca=-1.5]");
	}
	else
	if (filter_name == "sharpen") {
		addVFIfAvailable("lavfi", "[unsharp=la=1.5:ca=1.5]");
	}
	else
	if (filter_name == "noise") {
		addVFIfAvailable("lavfi", "[noise=alls=9:allf=t]");
	}
	else
	if (filter_name == "deblock") {
		addVFIfAvailable("lavfi", "[pp=" + option +"]");
	}
	else
	if (filter_name == "dering") {
		addVFIfAvailable("lavfi", "[pp=dr]");
	}
	else
	if (filter_name == "phase") {
		addVFIfAvailable("lavfi", "[phase=" + option +"]");
	}
	else
	if (filter_name == "postprocessing") {
		addVFIfAvailable("lavfi", "[pp]");
	}
	else
	if (filter_name == "hqdn3d") {
		QString o;
		if (!option.isEmpty()) o = "=" + option;
		addVFIfAvailable("lavfi", "[hqdn3d" + o +"]");
	}
	else
	if (filter_name == "yadif") {
		if (option == "1") {
			arg << "--vf-add=yadif=field";
		} else {
			arg << "--vf-add=yadif";
		}
	}
	else
	if (filter_name == "kerndeint") {
		addVFIfAvailable("lavfi", "[kerndeint=" + option +"]");
	}
	else
	if (filter_name == "lb" || filter_name == "l5") {
		addVFIfAvailable("lavfi", "[pp=" + filter_name +"]");
	}
	else
	if (filter_name == "subs_on_screenshots") {
		// Ignore
	}
	else
	if (filter_name == "rotate") {
		if (option == "0") {
			arg << "--vf-add=rotate=270,flip";
		}
		else
		if (option == "1") {
			arg << "--vf-add=rotate=90";
		}
		else
		if (option == "2") {
			arg << "--vf-add=rotate=270";
		}
		else
		if (option == "3") {
			arg << "--vf-add=rotate=90,flip";
		}
	}
	else {
		if (filter_name == "pp") {
			QString s;
			if (option.isEmpty()) s = "[pp]"; else s = "[pp=" + option + "]";
			addVFIfAvailable("lavfi", s);
		} else {
			QString s = filter_name;
			if (!option.isEmpty()) s += "=" + option;
			arg << "--vf-add=" + s;
		}
	}
}

void MPVProcess::addStereo3DFilter(const QString & in, const QString & out) {
	arg << "--vf-add=stereo3d=" + in + ":" + out;
}

void MPVProcess::addAF(const QString & filter_name, const QVariant & value) {
	QString option = value.toString();

	if (filter_name == "volnorm") {
		QString s = "drc";
		if (!option.isEmpty()) s += "=" + option;
		arg << "--af-add=" + s;
	}
	else
	if (filter_name == "channels") {
		if (option == "2:2:0:1:0:0") arg << "--af-add=channels=2:[0-1,0-0]";
		else
		if (option == "2:2:1:0:1:1") arg << "--af-add=channels=2:[1-0,1-1]";
		else
		if (option == "2:2:0:1:1:0") arg << "--af-add=channels=2:[0-1,1-0]";
	}
	else
	if (filter_name == "pan") {
		if (option == "1:0.5:0.5") {
			arg << "--af-add=pan=1:[0.5,0.5]";
		}
	}
	else
	if (filter_name == "equalizer") {
		previous_eq = option;
		arg << "--af-add=equalizer=" + option;
	}
	else
	if (filter_name == "extrastereo") {
		arg << "--af-add=lavfi=[extrastereo]";
	}
	else
	if (filter_name == "karaoke") {
		/* Not supported anymore */
		/* Ignore */
	}
	else {
		QString s = filter_name;
		if (!option.isEmpty()) s += "=" + option;
		arg << "--af-add=" + s;
	}
}

void MPVProcess::quit() {
	writeToStdin("quit 0");
}

void MPVProcess::setVolume(int v) {
	writeToStdin("set volume " + QString::number(v));
}

void MPVProcess::setOSD(int o) {
	writeToStdin("osd " + QString::number(o));
}

void MPVProcess::setAudio(int ID) {
	writeToStdin("set aid " + QString::number(ID));
}

void MPVProcess::setVideo(int ID) {
	writeToStdin("set vid " + QString::number(ID));
}

void MPVProcess::setSubtitle(int /*type*/, int ID) {
	writeToStdin("set sid " + QString::number(ID));
}

void MPVProcess::disableSubtitles() {
	writeToStdin("set sid no");
}

void MPVProcess::setSecondarySubtitle(int ID) {
	writeToStdin("set secondary-sid " + QString::number(ID));
}

void MPVProcess::disableSecondarySubtitles() {
	writeToStdin("set secondary-sid no");
}

void MPVProcess::setSubtitlesVisibility(bool b) {
	writeToStdin(QString("set sub-visibility %1").arg(b ? "yes" : "no"));
}

void MPVProcess::seek(double secs, int mode, bool precise) {
	QString s = "seek " + QString::number(secs) + " ";
	switch (mode) {
		case 0 : s += "relative "; break;
		case 1 : s += "absolute-percent "; break;
		case 2 : s += "absolute "; break;
	}
	if (precise) s += "exact"; else s += "keyframes";
	writeToStdin(s);
}

void MPVProcess::mute(bool b) {
	writeToStdin(QString("set mute %1").arg(b ? "yes" : "no"));
}

void MPVProcess::setPause(bool b) {
	writeToStdin(QString("set pause %1").arg(b ? "yes" : "no"));
}

void MPVProcess::frameStep() {
	writeToStdin("frame_step");
}

void MPVProcess::frameBackStep() {
	writeToStdin("frame_back_step");
}

void MPVProcess::showOSDText(const QString & text, int duration, int level) {
	QString str = QString("show_text \"%1\" %2 %3").arg(text).arg(duration).arg(level);
	writeToStdin(str);
}

void MPVProcess::showFilenameOnOSD() {
#ifdef OSD_WITH_TIMER
	toggleInfoOnOSD();
#else
	showOSDText("${filename}", 2000, 0);
#endif
}

void MPVProcess::showTimeOnOSD() {
#ifdef OSD_WITH_TIMER
	osd_timer->stop();
#endif
	writeToStdin("show_text \"${time-pos} ${?duration:/ ${duration} (${percent-pos}%)}\" 2000 0");
}

#ifdef OSD_WITH_TIMER
void MPVProcess::toggleInfoOnOSD() {
	if (!osd_timer->isActive()) {
		osd_timer->start();
		displayInfoOnOSD();
	} else {
		osd_timer->stop();
		showOSDText("", 100, 0);
	}
}

void MPVProcess::displayInfoOnOSD() {
	QString b1 = "{\\\\b1}";
	QString b0 = "{\\\\b0}";
	QString tab = "\\\\h\\\\h\\\\h\\\\h\\\\h";
	QString nl = "\\n";

	QString s = "${osd-ass-cc/0}{\\\\fs14}" +
		b1 + tr("File:") + b0 +" ${filename}" + nl +
		"${time-pos} ${?duration:/ ${duration} (${percent-pos}%)}" + nl + nl +
		//b1 + tr("Title:") + b0 + " ${media-title}" + nl + nl +
		b1 + tr("Video:") + b0 + " ${video-codec}" + nl +
		tab + b1 + tr("Resolution:") + b0 +" ${=width}x${=height}" + nl +
		tab + b1 + tr("Frames per second:") + b0 + " ${container-fps:${fps}} " + b1 + tr("Estimated:") + b0 + " ${estimated-vf-fps}" + nl +
		//tab + b1 + tr("Display FPS:") + b0 + " ${display-fps}" + nl +
		tab + b1 + tr("Aspect Ratio:") + b0 + " ${video-params/aspect}" + nl +
		tab + b1 + tr("Bitrate:") + b0 + " ${video-bitrate}" + nl +
		tab + b1 + tr("Dropped frames:") + b0 + " ${drop-frame-count}" + nl +
		nl +

		b1 + tr("Audio:") + b0 + " ${audio-codec}" + nl + 
		tab + b1 + tr("Bitrate:") + b0 + " ${audio-bitrate}" + nl +
		tab + b1 + tr("Sample Rate:") + b0 + " ${audio-params/samplerate} Hz" + nl +
		tab + b1 + tr("Channels:") + b0 + " ${audio-params/channel-count}" + nl +
		nl +

		b1 + tr("Audio/video synchronization:") + b0 + " ${avsync}" + nl +
		b1 + tr("Cache fill:") + b0 + " ${cache:0}%" + nl +
		b1 + tr("Used cache:") + b0 + " ${cache-used:0}" + nl;

	if (!osd_media_info.isEmpty()) s = osd_media_info;

	showOSDText(s, 2000, 0);

	if (!isRunning()) osd_timer->stop();
}
#endif

void MPVProcess::setContrast(int value) {
	writeToStdin("set contrast " + QString::number(value));
}

void MPVProcess::setBrightness(int value) {
	writeToStdin("set brightness " + QString::number(value));
}

void MPVProcess::setHue(int value) {
	writeToStdin("set hue " + QString::number(value));
}

void MPVProcess::setSaturation(int value) {
	writeToStdin("set saturation " + QString::number(value));
}

void MPVProcess::setGamma(int value) {
	writeToStdin("set gamma " + QString::number(value));
}

void MPVProcess::setChapter(int ID) {
	writeToStdin("set chapter " + QString::number(ID));
}

void MPVProcess::nextChapter() {
	writeToStdin("add chapter 1");
}

void MPVProcess::previousChapter() {
	writeToStdin("add chapter -1");
}

void MPVProcess::setExternalSubtitleFile(const QString & filename) {
	writeToStdin("sub_add \""+ filename +"\"");
	//writeToStdin("print_text ${track-list}");
	writeToStdin("print_text \"INFO_TRACKS_COUNT=${=track-list/count}\"");
}

void MPVProcess::setSubPos(int pos) {
	writeToStdin("set sub-pos " + QString::number(pos));
}

void MPVProcess::setSubScale(double value) {
	writeToStdin("set sub-scale " + QString::number(value));
}

void MPVProcess::setSubStep(int value) {
	writeToStdin("sub_step " + QString::number(value));
}

void MPVProcess::seekSub(int value) {
	writeToStdin("sub-seek " + QString::number(value));
}

void MPVProcess::setSubForcedOnly(bool b) {
	writeToStdin(QString("set sub-forced-only %1").arg(b ? "yes" : "no"));
}

void MPVProcess::setSpeed(double value) {
	writeToStdin("set speed " + QString::number(value));
}

#ifdef MPLAYER_SUPPORT
void MPVProcess::enableKaraoke(bool /*b*/) {
	/*
	if (b) writeToStdin("af add karaoke"); else writeToStdin("af del karaoke");
	*/
	messageFilterNotSupported("karaoke");
}
#endif

void MPVProcess::enableExtrastereo(bool b) {
	if (b) writeToStdin("af add lavfi=[extrastereo]"); else writeToStdin("af del lavfi=[extrastereo]");
}

void MPVProcess::enableVolnorm(bool b, const QString & option) {
	if (b) writeToStdin("af add drc=" + option); else writeToStdin("af del drc=" + option);
}

void MPVProcess::setAudioEqualizer(const QString & values) {
	if (values == previous_eq) return;

	if (!previous_eq.isEmpty()) {
		writeToStdin("af del equalizer=" + previous_eq);
	}
	writeToStdin("af add equalizer=" + values);
	previous_eq = values;
}

void MPVProcess::setAudioDelay(double delay) {
	writeToStdin("set audio-delay " + QString::number(delay));
}

void MPVProcess::setSubDelay(double delay) {
	writeToStdin("set sub-delay " + QString::number(delay));
}

void MPVProcess::setLoop(int v) {
	QString o;
	switch (v) {
		case -1: o = "no"; break;
		case 0: o = "inf"; break;
		default: o = QString::number(v);
	}
	writeToStdin(QString("set loop %1").arg(o));
}

void MPVProcess::setAMarker(int sec) {
	writeToStdin(QString("set ab-loop-a %1").arg(sec));
}

void MPVProcess::setBMarker(int sec) {
	writeToStdin(QString("set ab-loop-b %1").arg(sec));
}

void MPVProcess::clearABMarkers() {
	writeToStdin("set ab-loop-a no");
	writeToStdin("set ab-loop-b no");
}

void MPVProcess::takeScreenshot(ScreenshotType t, bool include_subtitles) {
	writeToStdin(QString("screenshot %1 %2").arg(include_subtitles ? "subtitles" : "video").arg(t == Single ? "single" : "each-frame"));
}

#ifdef CAPTURE_STREAM
void MPVProcess::switchCapturing() {
	if (!capture_filename.isEmpty()) {
		if (!capturing) {
			QString f = capture_filename;
			#ifdef Q_OS_WIN
			// I hate Windows
			f = f.replace("\\", "\\\\");
			#endif
			writeToStdin("set stream-capture \"" + f + "\"");
		} else {
			writeToStdin("set stream-capture \"\"");
		}
		capturing = !capturing;
	}
}
#endif

void MPVProcess::setTitle(int ID) {
	writeToStdin("set disc-title " + QString::number(ID));
}

#if DVDNAV_SUPPORT
void MPVProcess::discSetMousePos(int x, int y) {
	qDebug("MPVProcess::discSetMousePos: %d %d", x, y);
	//writeToStdin(QString("discnav mouse_move %1 %2").arg(x).arg(y));
	// mouse_move doesn't accept options :?

	// For some reason this doesn't work either...
	// So it's not possible to select options in the dvd menus just
	// because there's no way to pass the mouse position to mpv, or it
	// ignores it.
	writeToStdin(QString("mouse %1 %2").arg(x).arg(y));
	//writeToStdin("discnav mouse_move");
}

void MPVProcess::discButtonPressed(const QString & button_name) {
	writeToStdin("discnav " + button_name);
}
#endif

void MPVProcess::setAspect(double aspect) {
	writeToStdin("set video-aspect " + QString::number(aspect));
}

void MPVProcess::setFullscreen(bool b) {
	writeToStdin(QString("set fullscreen %1").arg(b ? "yes" : "no"));
}

#if PROGRAM_SWITCH
void MPVProcess::setTSProgram(int ID) {
	qDebug("MPVProcess::setTSProgram: function not supported");
}
#endif

void MPVProcess::toggleDeinterlace() {
	writeToStdin("cycle deinterlace");
}

void MPVProcess::askForLength() {
	writeToStdin("print_text \"INFO_LENGTH=${=length}\"");
}

void MPVProcess::setOSDScale(double value) {
	writeToStdin("set osd-scale " + QString::number(value));
}

void MPVProcess::changeVF(const QString & filter, bool enable, const QVariant & option) {
	qDebug() << "MPVProcess::changeVF:" << filter << enable;

	QString f;
	if (filter == "letterbox") {
		f = QString("expand=aspect=%1").arg(option.toDouble());
	}
	else
	if (filter == "noise") {
		f = "lavfi=[noise=alls=9:allf=t]";
	}
	else
	if (filter == "blur") {
		f = "lavfi=[unsharp=la=-1.5:ca=-1.5]";
	}
	else
	if (filter == "sharpen") {
		f = "lavfi=[unsharp=la=1.5:ca=1.5]";
	}
	else
	if (filter == "deblock") {
		f = "lavfi=[pp=" + option.toString() +"]";
	}
	else
	if (filter == "dering") {
		f = "lavfi=[pp=dr]";
	}
	else
	if (filter == "phase") {
		f = "lavfi=[phase=" + option.toString() +"]";
	}
	else
	if (filter == "postprocessing") {
		f = "lavfi=[pp]";
	}
	else
	if (filter == "hqdn3d") {
		QString o = option.toString();
		if (!o.isEmpty()) o = "=" + o;
		f = "lavfi=[hqdn3d" + o +"]";
	}
	else
	if (filter == "rotate") {
		QString o = option.toString();
		if (o == "0") {
			f = "rotate=270,flip";
		}
		else
		if (o == "1") {
			f = "rotate=90";
		}
		else
		if (o == "2") {
			f = "rotate=270";
		}
		else
		if (o == "3") {
			f = "rotate=90,flip";
		}
	}
	else
	if (filter == "flip" || filter == "mirror") {
		f = filter;
	}
	else
	if (filter == "scale" || filter == "gradfun") {
		f = filter;
		QString o = option.toString();
		if (!o.isEmpty()) f += "=" + o;
	}
	else
	if (filter == "lb" || filter == "l5") {
		f = "lavfi=[pp=" + filter +"]";
	}
	else
	if (filter == "yadif") {
		if (option.toString() == "1") {
			f = "yadif=field";
		} else {
			f = "yadif";
		}
	}
	else
	if (filter == "kerndeint") {
		f = "lavfi=[kerndeint=" + option.toString() +"]";
	}
	else {
		qDebug() << "MPVProcess::changeVF: unknown filter:" << filter;
	}

	if (!f.isEmpty()) {
		writeToStdin(QString("vf %1 \"%2\"").arg(enable ? "add" : "del").arg(f));
	}
}

void MPVProcess::changeStereo3DFilter(bool enable, const QString & in, const QString & out) {
	QString filter = "stereo3d=" + in + ":" + out;
	writeToStdin(QString("vf %1 \"%2\"").arg(enable ? "add" : "del").arg(filter));
}

void MPVProcess::setSubStyles(const AssStyles & styles, const QString &) {
	QString sub_font = "--sub-text-font";
	if (isOptionAvailable("--sub-font")) sub_font = "--sub-font";

	QString sub_color = "--sub-text-color";
	if (isOptionAvailable("--sub-color")) sub_color = "--sub-color";

	QString sub_shadow_color = "--sub-text-shadow-color";
	if (isOptionAvailable("--sub-shadow-color")) sub_shadow_color = "--sub-shadow-color";

	QString sub_back_color = "--sub-text-back-color";
	if (isOptionAvailable("--sub-back-color")) sub_back_color = "--sub-back-color";

	QString sub_border_color = "--sub-text-border-color";
	if (isOptionAvailable("--sub-border-color")) sub_border_color = "--sub-border-color";

	QString sub_border_size = "--sub-text-border-size";
	if (isOptionAvailable("--sub-border-size")) sub_border_size = "--sub-border-size";

	QString sub_shadow_offset = "--sub-text-shadow-offset";
	if (isOptionAvailable("--sub-shadow-offset")) sub_shadow_offset = "--sub-shadow-offset";

	QString font = styles.fontname;
	//arg << "--sub-text-font=" + font.replace(" ", "");
	arg << sub_font + "=" + font;
	arg << sub_color + "=#" + ColorUtils::colorToAARRGGBB(styles.primarycolor);

	if (styles.borderstyle == AssStyles::Outline) {
		arg << sub_shadow_color + "=#" + ColorUtils::colorToAARRGGBB(styles.backcolor);
	} else {
		arg << sub_back_color + "=#" + ColorUtils::colorToAARRGGBB(styles.outlinecolor);
	}
	arg << sub_border_color + "=#" + ColorUtils::colorToAARRGGBB(styles.outlinecolor);

	arg << sub_border_size + "=" + QString::number(styles.outline * 2.5);
	arg << sub_shadow_offset + "=" + QString::number(styles.shadow * 2.5);

	if (isOptionAvailable("--sub-text-font-size")) {
		arg << "--sub-text-font-size=" + QString::number(styles.fontsize * 2.5);
	}

	if (isOptionAvailable("--sub-text-bold")) {
		arg << QString("--sub-text-bold=%1").arg(styles.bold ? "yes" : "no");
	}

	if (isOptionAvailable("--sub-text-italic")) {
		arg << QString("--sub-text-italic=%1").arg(styles.italic ? "yes" : "no");
	}

	QString halign;
	switch (styles.halignment) {
		case AssStyles::Left: halign = "left"; break;
		case AssStyles::Right: halign = "right"; break;
	}

	QString valign;
	switch (styles.valignment) {
		case AssStyles::VCenter: valign = "center"; break;
		case AssStyles::Top: valign = "top"; break;
	}

	if (!halign.isEmpty() || !valign.isEmpty()) {
		if (isOptionAvailable("--sub-text-align-x")) {
			if (!halign.isEmpty()) arg << "--sub-text-align-x=" + halign;
			if (!valign.isEmpty()) arg << "--sub-text-align-y=" + valign;
		}
	}
}

void MPVProcess::setChannelsFile(const QString & filename) {
	arg << "--dvbin-file=" + filename;
}

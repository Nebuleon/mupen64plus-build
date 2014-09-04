#/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
# *   Mupen64plus - Makefile                                                *
# *   Mupen64Plus homepage: http://code.google.com/p/mupen64plus/           *
# *   Copyright (C) 2014 Paul Cercueil                                      *
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# *   This program is distributed in the hope that it will be useful,       *
# *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
# *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
# *   GNU General Public License for more details.                          *
# *                                                                         *
# *   You should have received a copy of the GNU General Public License     *
# *   along with this program; if not, write to the                         *
# *   Free Software Foundation, Inc.,                                       *
# *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.          *
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

CFLAGS := 
# put -Dname=value in CFLAGS for conditional compilation
OPTFLAGS := -O3
# put -O3 in OPTFLAGS if you want linking to be faster, or -O3 -flto for runtime

MAKE_ENV := CFLAGS="$(CFLAGS)" OPTFLAGS="$(OPTFLAGS)"

.PHONY: clean all opk core input audio ui out/default.gcw0.desktop input-sdl audio-sdl rsp-hle mupen64plus video-gles2n64
all:   core input audio rsp ui video
input: input-sdl
audio: audio-sdl
rsp:   rsp-hle
ui:    mupen64plus
video: video-rice

core: out
	+$(MAKE_ENV) make -C ../mupen64plus-core/projects/unix all
	cp ../mupen64plus-core/projects/unix/libmupen64plus.so.2.0.0 out/libmupen64plus.so.2.0.0
	ln -sf libmupen64plus.so.2.0.0 out/libmupen64plus.so.2

mupen64plus: out
	+$(MAKE_ENV) make -C ../mupen64plus-ui-console/projects/unix all
	cp ../mupen64plus-ui-console/projects/unix/mupen64plus out/$@

video-rice: out
	+$(MAKE_ENV) make -C ../mupen64plus-video-rice/projects/unix all
	cp ../mupen64plus-video-rice/projects/unix/mupen64plus-video-rice.so out/mupen64plus-video-rice.so

rsp-hle input-sdl audio-sdl: out
	+$(MAKE_ENV) make -C ../mupen64plus-$@/projects/unix all
	cp ../mupen64plus-$@/projects/unix/mupen64plus-$@.so out/mupen64plus-$@.so

out:
	cp -r ../mupen64plus-core/data $@
	cp ../mupen64plus-video-rice/data/RiceVideoLinux.ini $@/RiceVideoLinux.ini
	cp ../mupen64plus-input-sdl/data/InputAutoCfg.ini $@/InputAutoCfg.ini

clean:
	$(MAKE_ENV) make -C ../mupen64plus-core/projects/unix clean
	$(MAKE_ENV) make -C ../mupen64plus-input-sdl/projects/unix clean
	$(MAKE_ENV) make -C ../mupen64plus-audio-sdl/projects/unix clean
	$(MAKE_ENV) make -C ../mupen64plus-rsp-hle/projects/unix clean
	$(MAKE_ENV) make -C ../mupen64plus-ui-console/projects/unix clean
	$(MAKE_ENV) make -C ../mupen64plus-video-rice/projects/unix clean
	rm -rf out

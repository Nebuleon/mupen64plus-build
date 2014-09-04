HOW TO USE THIS REPOSITORY
==========================

Clone this repository into your local filesystem first:

$ cd <somewhere>
$ git clone https://github.com/Nebuleon/mupen64plus-build.git

The other Mupen64Plus repositories should be cloned next to this one in your
filesystem. You can pick the fork of each repository that you want to build.

For example, to use this repository with the official Mupen64Plus repositories
you can issue these commands:

$ git clone https://github.com/mupen64plus/mupen64plus-core.git
$ git clone https://github.com/mupen64plus/mupen64plus-ui-console.git
$ git clone https://github.com/mupen64plus/mupen64plus-input-sdl.git
$ git clone https://github.com/mupen64plus/mupen64plus-audio-sdl.git
$ git clone https://github.com/mupen64plus/mupen64plus-video-rice.git
$ git clone https://github.com/mupen64plus/mupen64plus-rsp-hle.git

To use this repository with Nebuleon's version of the Mupen64Plus repositories
that work on MIPS, you can issue these commands:

$ git clone https://github.com/Nebuleon/mupen64plus-core.git
$ git clone https://github.com/Nebuleon/mupen64plus-ui-console.git
$ git clone https://github.com/Nebuleon/mupen64plus-input-sdl.git
$ git clone https://github.com/Nebuleon/mupen64plus-audio-sdl.git
$ git clone https://github.com/mupen64plus/mupen64plus-video-rice.git
$ git clone https://github.com/Nebuleon/mupen64plus-video-gles2n64.git
$ git clone https://github.com/Nebuleon/mupen64plus-rsp-hle.git

BUILDING FOR PC
===============

Building for PC uses the Make file called Makefile. You will need to install
gcc, GNU make, SDL 1.2 or 2.0 development libraries, OpenGL 2.0 development
libraries, as well as possibly other things.

You should leave GCW Zero branches before building for PC, in the following
repositories:
* mupen64plus-core
* mupen64plus-input-sdl

To build:

$ cd mupen64plus-build
$ make

Binaries will go to 'out/'. Rice will be built as the video plugin, as well as
the other required plugins and the console UI.

BUILDING FOR GCW ZERO
=====================

Building for the GCW Zero uses the Make file called Makefile.gcw0. You will
need to install the GCW Zero toolchain from http://www.gcw-zero.com/develop .

You should enter GCW Zero branches before building for the GCW Zero, in the
following repositories:
* mupen64plus-core
* mupen64plus-input-sdl

To build:

$ cd mupen64plus-build
$ make -f Makefile.gcw0

Binaries will go to 'out/', and an OPK file will be dropped in the build
directory itself. GLES2n64 will be built as the video plugin, as well as the
other required plugins and the console UI, for MIPS32 processors.

GUIDE TO NEBULEON'S REPOSITORIES
================================

Changes to the official Mupen64Plus code are required for things to compile
and run properly on the GCW Zero. Where the changes are not GCW Zero-specific,
they are in the 'master' branch; otherwise, they are in a 'gcw0' branch.

- mupen64plus-core:

  'master' contains changes to the Makefile to unofficially support compiling
  for MIPS as well as to allow overriding the path of SDL_CONFIG via the
  environment, as required by GCW Zero cross-compilation.

  'gcw0' contains changes to stop using (full) OpenGL straight in the core,
  allowing OpenGL ES to be initialised by gles2n64. It also contains a fix for
  a crash that occurs when setting the floating-point rounding mode.

  'neb-dynarec' is a deprecated branch as of 2014-09-04, which has become too
  complicated for its own good.

  When building for the GCW Zero, please use a local branch based on 'gcw0'
  with any JIT work you wish to use merged on top of it.

- mupen64plus-ui-console, mupen64plus-audio-sdl, mupen64plus-rsp-hle:

  'master' contains changes to the Makefile to unofficially support compiling
  for MIPS as well as to allow overriding the path of SDL_CONFIG via the
  environment, as required by GCW Zero cross-compilation.

  There are no other changes. The code is cross-platform.

- mupen64plus-input-sdl:

  'master' contains the input mapping for PC, including the keyboard mapping.

  'gcw0' contains the input mapping for the GCW Zero, mapping its buttons to
  the closest thing that exists on the N64 controller.
  (Start is Start on the GCW Zero; A and B, the analog nub and the d-pad are
  the same, but other buttons are different. See the commits for more
  information, as this may change.)

- mupen64plus-video-gles2n64:

  'master' is the only branch. It contains similar fixes to build for MIPS, as
  well as some other fixes that were cherry-picked.

Rice Video is not in Nebuleon's repositories, because it is not intended to be
built for the GCW Zero. It is only built for PC.

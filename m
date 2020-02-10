From: chris@reproducible-builds.org (Chris Lamb)
Date: Mon, 10 Feb 2020 18:37:12 +0000
Subject: [cip-dev] January 2020 in Reproducible Builds
Message-ID: <4ceff222-29c8-4861-a37e-e38f8fe03a8c@www.fastmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

====================================================================

        o
      ?   ?      January 2020 in Reproducible Builds
     o     o
      ?   ?      https://reproducible-builds.org/reports/2020-01/
        o

====================================================================

Welcome to the January 2020 report from the Reproducible Builds
project. In this month's issue, we cover:

* Upstream news & event coverage ? Reproducing the Telegram
  messenger, etc.

* Software development ? Updates and improvements to our tooling

* Distribution work ? More work in Debian, openSUSE & friends

* Misc news ? From our mailing list & how to get in touch


(Q: But what are reproducible builds...?)

Whilst anyone can inspect the source code of free software for
malicious flaws, almost all software is distributed to end users as
pre-compiled binaries. The motivation behind the reproducible builds
effort is to ensure no flaws have been introduced during this
compilation process by promising identical results are always generated
from a given source, thus allowing multiple third-parties to come to a
consensus on whether a build was compromised.

If you are interested in contributing, please visit the Contribute [1]
page on our website.

  [1] https://reproducible-buids.org/contribute/


Upstream news & event coverage
==============================

The Telegram [2] messaging application has documented full instructions
[3] for verifying that its original source code is exactly the same
code that is used to build the versions available on the Apple App
Store and Google Play.

 [2] https://telegram.org/
 [3] https://core.telegram.org/reproducible-builds

Reproducible builds were mentioned in a panel on Software Distribution
with Sam Hartman, Richard Fontana, & Eben Moglen [4] at the Software
Freedom Law Center's 15h Anniversary Fall Conference [6] (at ~35m21s).

 [4] https://www.youtube.com/watch?v=rMinFopJMW0&t=2121s
 [6] https://www.softwarefreedom.org/events/2019/annual-conference/

Vagrant Cascadian will present a talk at SCALE 18x [7] in Pasadena,
California on March 8th titled "There and Back Again, Reproducibly" [8].

 [7] https://www.socallinuxexpo.org/scale/18x
 [8] https://www.socallinuxexpo.org/scale/18x/presentations/there-and-back-again-reproducibly

Matt Graeber [9] (@mattifestation) posted on Twitter that:

> If you weren't aware of the reason Portable Executable [11] timestamps
> in Win 10 binaries were nonsensical, Raymond's post explains the reason:
> to support reproducible builds.

... referencing an article by Raymond Chen from January 2018 [12]
which, amongst other things, mentions:

> One of the changes to the Windows engineering system begun in Windows
> 10 is the move toward reproducible builds.

 [9] https://medium.com/@mattifestation
 [11] https://en.wikipedia.org/wiki/Portable_Executable
 [12] https://devblogs.microsoft.com/oldnewthing/20180103-00/?p=97705

Jan Nieuwenhuizen announced the release of GNU Mes 0.22 [13] which
produced a bit-for-bit identical "mescc-mes-static" binary with the
mes-rb5 package within the GNU Guix operating system. Vagrant
Cascadian subsequently uploaded this version of Mes to Debian.

 [13] https://lists.reproducible-builds.org/pipermail/rb-general/2020-January/001787.html


Software development
====================

diffoscope
----------

diffoscope [17] is our in-depth and content-aware diff-like utility
that can locate and diagnose reproducibility issues. It is run
countless times a day on our testing infrastructure [18] and is
essential for identifying fixes and causes of nondeterministic
behaviour.

 [17] https://diffoscope.org
 [18] https://tests.reproducible-builds.org/debian/reproducible.html

This month, diffoscope versions 135 and 136 were uploaded to Debian
unstable by Chris Lamb. He also made the following changes to
diffoscope itself, including:

* New features:

    * Support external difference tools such as Meld [19], etc. similar
      to git-difftool(1). [20]
    * Extract resources.arsc files as well as classes.dex from
      Android .apk files to ensure that we show differences there. [21]
    * Fallback to the regular .zip container format for .apk files
      if apktool is not available. [22][23][24][25]
    * Drop --max-report-size-child and --max-diff-block-lines-
      parent; scheduled for removal in January 2018. [26]
    * Append a comment to a difference if we fallback to a less-
      informative container format but we are missing a tool. [27][28]

* Bug fixes:

    * No longer raise a KeyError exception if we request an invalid
      member from a directory container. [29]

* Documentation/workflow improvements:

    * Clarify that "install X" in various outputs actually refers to
      system-level packages. [30]
    * Add a note to the Contributing documentation to suggest enable
      concurrency when running the tests locally. [31]
    * Include the CONTRIBUTING.md file in the PyPI.org [32] release.
      [33][34]

* Logging improvements:

    * Log a debug-level message if we cannot open a file as container
      due to a missing tool to assist in diagnosing issues. [35]
    * Correct a debug message related to compare_meta calls to quote
      the arguments correctly. [36]
    * Add the current PATH environment variable to the "Normalising
      locale..." debug-level message. [37]
    * Print the Starting diffoscope $VERSION line as the first line
      of the log as we are, well, starting diffoscope. [38]
    * If we don't know the HTML output name, don't emit an
      enigmatically truncated HTML output for debug message. [39]

* Tests:

    * Don't exhaustively output the entire HTML report when testing the
      regression for #875281; parsing the JSON and pruning the
      tree should be enough. [41]
    * Refresh and update the fixtures for the .ico tests to match the
      latest version of Imagemagick [42] in Debian unstable. [43]

* Code improvements:

    * Add a .git-blame-ignore-revs file to improve the output of
      git-blame(1) by ignoring large changes when introducing the Black
      [44] source code reformatter and update the CONTRIBUTING.md guide
      on how to optionally use it locally. [45]
    * Add a noqa line to avoid a false-positive Flake8 [46] "unused
      import" warning. [47]
    * Move logo.svg to under the doc/ directory [48] and make
      setup.py executable [49].
    * Tidy diffoscope.main's configure method. [50][51][52][53]
    * Drop an assertion that is guaranteed by parallel if conditional
      [54] and an unused "Difference" import from the APK
      comparator. [55]
    * Turn down the volume for a recommendation in a comment. [56]
    * Rename the diffoscope.locale module to diffoscope.environ as
      we are modifying things beyond just the locale (eg. calling tzset
      [57], etc.) [58]
    * Factor-out the generation of foo not available in path comment
      messages into the exception that raises them [59] and factor out
      running all of our many zipinfo into a new method [60].

* trydiffoscope [61] is the web-based version of diffoscope. This
  month, Chris Lamb fixed the PyPI.org [62] release by adding the
  trydiffoscope script itself to the MANIFEST file and performing
  another release cycle. [63]

In addition, Marc Herbert adjusted the cbfstool [64] tests to search
for expected keywords in the output, rather than specific output
[65], fixed a misplaced debugging line [66] and added a "Testing"
section to the CONTRIBUTING.rst [67] file. Vagrant Cascadian
updated to diffoscope 135 [68] in GNU Guix [69].

 [19] https://meldmerge.org/
 [20] https://salsa.debian.org/reproducible-builds/diffoscope/issues/87
 [21] https://salsa.debian.org/reproducible-builds/diffoscope/issues/27
 [22] https://salsa.debian.org/reproducible-builds/diffoscope/commit/bbbb322
 [23] https://salsa.debian.org/reproducible-builds/diffoscope/commit/6710868
 [24] https://salsa.debian.org/reproducible-builds/diffoscope/commit/85c2100
 [25] https://salsa.debian.org/reproducible-builds/diffoscope/commit/b1b9977
 [26] https://salsa.debian.org/reproducible-builds/diffoscope/commit/fee25e5
 [27] https://salsa.debian.org/reproducible-builds/diffoscope/commit/0615036
 [28] https://salsa.debian.org/reproducible-builds/diffoscope/commit/88bc142
 [29] https://salsa.debian.org/reproducible-builds/diffoscope/commit/7765669
 [30] https://salsa.debian.org/reproducible-builds/diffoscope/commit/c99cd9b
 [31] https://salsa.debian.org/reproducible-builds/diffoscope/commit/9d88cda
 [32] https://pypi.org/
 [33] https://salsa.debian.org/reproducible-builds/diffoscope/commit/0e5a0c5
 [34] https://salsa.debian.org/reproducible-builds/diffoscope/commit/aa9db34
 [35] https://salsa.debian.org/reproducible-builds/diffoscope/commit/5757c8b
 [36] https://salsa.debian.org/reproducible-builds/diffoscope/commit/3e3a18d
 [37] https://salsa.debian.org/reproducible-builds/diffoscope/commit/600831b
 [38] https://salsa.debian.org/reproducible-builds/diffoscope/commit/9a200bc
 [39] https://salsa.debian.org/reproducible-builds/diffoscope/commit/b709d89
 [41] https://salsa.debian.org/reproducible-builds/diffoscope/issues/84
 [42] https://imagemagick.org/
 [43] https://salsa.debian.org/reproducible-builds/diffoscope/commit/614b0d1
 [44] https://black.readthedocs.io/en/stable/
 [45] https://salsa.debian.org/reproducible-builds/diffoscope/commit/4e40f75
 [46] https://flake8.pycqa.org/en/latest/
 [47] https://salsa.debian.org/reproducible-builds/diffoscope/commit/8993168
 [48] https://salsa.debian.org/reproducible-builds/diffoscope/commit/f8f0d14
 [49] https://salsa.debian.org/reproducible-builds/diffoscope/commit/efb7bdc
 [50] https://salsa.debian.org/reproducible-builds/diffoscope/commit/d377d3b
 [51] https://salsa.debian.org/reproducible-builds/diffoscope/commit/d2e283c
 [52] https://salsa.debian.org/reproducible-builds/diffoscope/commit/d658583
 [53] https://salsa.debian.org/reproducible-builds/diffoscope/commit/8eb852a
 [54] https://salsa.debian.org/reproducible-builds/diffoscope/commit/722d735
 [55] https://salsa.debian.org/reproducible-builds/diffoscope/commit/026ff74
 [56] https://salsa.debian.org/reproducible-builds/diffoscope/commit/412fef1
 [57] https://docs.python.org/3/library/time.html
 [58] https://salsa.debian.org/reproducible-builds/diffoscope/commit/786ff48
 [59] https://salsa.debian.org/reproducible-builds/diffoscope/commit/3a5f46d
 [60] https://salsa.debian.org/reproducible-builds/diffoscope/commit/3b94c0c
 [61] https://try.diffoscope.org
 [62] https://pypi.org/
 [63] https://salsa.debian.org/reproducible-builds/trydiffoscope/issues/1
 [64] https://www.coreboot.org/CBFS
 [65] https://salsa.debian.org/reproducible-builds/diffoscope/commit/d59dd2a
 [66] https://salsa.debian.org/reproducible-builds/diffoscope/commit/c150ae8
 [67] https://salsa.debian.org/reproducible-builds/diffoscope/commit/0beddf1
 [68] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=a3bf43481902ff10d02934d252cfb7aaaf3873e6
 [69] https://guix.gnu.org/


reprotest
---------

reprotest is our end-user tool to build same source code twice in
widely differing environments and then checks the binaries produced by
each build for any differences. This month, versions 0.7.11 and
0.7.12 were uploaded to Debian unstable [70] by Holger Levsen. This
month, I?aki Malerba improved the version test to split on the +
character [71] and Ross Vandegrift updated the code to allow the
user to override timeouts from the surrounding environment [72].

Holger Levsen also made the following additionally changes:

* Drop the short timeout and use the install timeout instead.
  (#897442)
* Use "real" reStructuredText [74] comments instead of using the raw
  directive. [75]
* Update the PyPI [76] classifier to express we are using Python 3.7
  now. [77]

 [70] https://tracker.debian.org/pkg/reprotest
 [71] https://salsa.debian.org/reproducible-builds/reprotest/commit/dc67985
 [72] https://salsa.debian.org/reproducible-builds/reprotest/commit/7f645f9
 [74] https://docutils.sourceforge.io/rst.html
 [75] https://salsa.debian.org/reproducible-builds/reprotest/commit/9eb1017
 [76] https://pypi.org/
 [77] https://salsa.debian.org/reproducible-builds/reprotest/commit/19c6d5a


Other tools
-----------

* disorderfs is our FUSE [78]-based filesystem that deliberately
  introduces non-determinism into directory system calls in order to
  flush out reproducibility issues. This month, Chris Lamb fixed an
  issue by ignoring the return values of fsyncdir to ensure (for
  example) dpkg(1) can "flush" /var/lib/dpkg correctly [79] and merged a
  change from Helmut Grohne to use the build architecture's version of
  pkg-config [80] to permit cross- architecture builds [81].

* strip-nondeterminism is our tool to remove specific non-
  deterministic results from a completed build. This month, version
  1.6.3-2 was uploaded to Debian unstable [82] by Holger Levsen to bump
  the Standards-Version.

 [78] https://en.wikipedia.org/wiki/Filesystem_in_Userspace
 [79] https://salsa.debian.org/reproducible-builds/disorderfs/commit/07c6e80
 [80] https://www.freedesktop.org/wiki/Software/pkg-config/
 [81] https://salsa.debian.org/reproducible-builds/disorderfs/commit/520937a
 [82] https://tracker.debian.org/news/1095745/accepted-strip-nondeterminism-163-2-source-into-unstable/


Upstream development
--------------------

The Reproducible Builds project detects, dissects and attempts to fix as
many unreproducible packages as possible. Naturally, we endeavour to
send all of our patches upstream. This month, we wrote another large
number of such patches, including:

* Arnout Engelen (for the NixOS distribution [83]):

    * bash [84] (enable PGRP_PIPE regardless of build-time
      kernel version)
    * jitterentropy [85] (remove timestamps from Gzip[86]-compressed
      manpages, already filed upstream [87])
    * ms-sys [88] (remove timestamps from .gz manpages, already
      upstream [89])

* Bernhard M. Wiedemann (for the openSUSE [90] distribution):

    * ImageMagick [91] (toolchain, .png date)
    * brickv [92] (sort a Python glob/readdir(3))
    * cpython [93] (.pyc reproducibility)
    * doxygen [94] (merged a toolchain patch to prevent
      nondeterminism from ASLR)
    * fastjet-contrib [95] (sort find / readdir)
    * openjfx [96] (Java date)
    * ruby [97] (Reopen unsorted Ruby glob issue)
    * rubygem-sassc [98] (sort a Ruby readdir(3))

* Chris Lamb:

    * #948279 filed against python-gmusicapi.
    * #948582 filed against bochs.
    * #948872 filed against pcbasic.
    * #949379 filed against vmatch.
    * #949580 filed against pkg-js-tools.
    * #949684 filed against mcomix.
    * #949817 filed against shotcut (forwarded upstream [113]).
    * #950138 filed against pikepdf (forwarded upstream [116]).

* Jelle van der Waa (Arch Linux [117]):

    * ardour [118] (hash ordering)
    * drumkv1 [119] (remove timestamp from .gz manpage)
    * frotz [120] (drop date)
    * frotz-dumb [121]
    * gnutls [122] (remove timestamps from .gz manpages)
    * samplv1 [123] (remove timestamp from .gz manpage)
    * sane [124] (date)
    * shards [125] (date)

* Martin Li?ka:

    * gcc [126] (toolchain, fixing randomness in some .o files,
      with Alexander Monakov & Richard Biener)

* Vagrant Cascadian submitted a large number patches via the Debian bug
  tracking system targeting the packages Civil Infrastructure Platform
  [127] as identified by the CIP package set [128] including:

    * #948757 & #948759 filed against apache2.
    * #948771 filed against guile-2.2.
    * #949114 & #949115 filed against alsa-tools.
    * #949270 & #949271 filed against libtool.
    * #949273 & #949275 filed against geoip.
    * #949324 filed against groff.
    * #949338 filed against gettext.
    * #949341 filed against sqlite3.
    * #949342 & #949343 filed against flex.
    * #949346 & #949348 filed against libnet.

 [83] https://nixos.org
 [84] https://github.com/NixOS/nixpkgs/pull/77196
 [85] https://github.com/NixOS/nixpkgs/pull/77202
 [86] https://www.gnu.org/software/gzip/manual/gzip.html
 [87] https://github.com/smuellerDD/jitterentropy-library/commit/0eca18fbd30318f5c2e927be307dc91e43c133b1
 [88] https://github.com/NixOS/nixpkgs/pull/77096
 [89] https://sourceforge.net/p/ms-sys/patches/7/
 [90] https://www.opensuse.org/
 [91] https://github.com/ImageMagick/ImageMagick/pull/1270
 [92] https://github.com/Tinkerforge/brickv/pull/23
 [93] https://bugs.python.org/issue34033
 [94] https://github.com/doxygen/doxygen/issues/7474
 [95] https://github.com/alisw/fastjet/pull/6
 [96] https://github.com/openjdk/jfx/pull/99
 [97] https://bugs.ruby-lang.org/issues/8709
 [98] https://github.com/sass/sassc-ruby/pull/178
 [113] https://github.com/mltframework/shotcut/pull/824
 [116] https://github.com/pikepdf/pikepdf/pull/76
 [117] https://archlinux.org
 [118] https://github.com/ardour/ardour/pull/464/
 [119] https://github.com/rncbc/drumkv1/pull/31
 [120] https://gitlab.com/DavidGriffith/frotz/issues/189
 [121] https://bugs.archlinux.org/task/65149
 [122] https://git.archlinux.org/svntogit/packages.git/commit/trunk?h=packages/gnutls&id=ef86c4da049e4bdbcee9898a9b9702f4bd9618b5
 [123] https://github.com/rncbc/samplv1/pull/30
 [124] https://gitlab.com/sane-project/backends/issues/228
 [125] https://github.com/crystal-lang/shards/pull/314
 [126] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93274
 [127] https://www.cip-project.org/
 [128] https://tests.reproducible-builds.org/debian/bullseye/amd64/pkg_set_CIP.html


Distribution work
=================

openSUSE
--------

In openSUSE [156], Bernhard M. Wiedemann published his monthly
Reproducible Builds status update [157] and submitted the following bugs
and patches:

* doxygen [158] (toolchain, ASLR [159]; already merged upstream)
* frotz [160] (version update & date)
* gcc9 [161] (report unreproducible .o files, forwarded
  upstream [162])
* mingw* [163] (report random filename in .a files)
* perl-TimeDate [164] (fix a "year 2020" bug, forwarded
  upstream [165])
* python-sherpa [166] (CPU-detection via --mtune=native)
* qpress [167] (make PGO reproducible)
* rubygem-sassc [168] (CPU & readdir, partially submitted
  upsteam [169])
* stgit [170] (recreate unreproducible .pyc files with fixed
  filesystem readdir(3) order)
* xmvn [171] (report nondeterminism from filesystem order
  and randomness)

Many Python packages were updated to avoid writing .pyc files with an
embedded random path, including jupyter-jupyter-wysiwyg [172], jupyter-
jupyterlab-latex [173], python-PsyLab [174], python-hupper [175],
python-ipyevents [176] (don't rewrite .zip file), python-ipyleaflet
[177], python-jupyter-require [178], python-jupyter_kernel_test [179],
python-nbdime [180] (do not rewrite .zip, avoid time-based .pyc),
python-nbinteract [181], python-plaster [182], python-pythreejs [183],
python-sidecar [184] & tensorflow [185] (use pip install --no-
compile).

 [156] https://www.opensuse.org/
 [157] https://lists.opensuse.org/opensuse-factory/2020-01/msg00296.html
 [158] https://build.opensuse.org/request/show/766399
 [159] https://en.wikipedia.org/wiki/Address_space_layout_randomization
 [160] https://build.opensuse.org/request/show/765634
 [161] https://bugzilla.opensuse.org/show_bug.cgi?id=1160986
 [162] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93274
 [163] https://bugzilla.opensuse.org/show_bug.cgi?id=1160672
 [164] https://build.opensuse.org/request/show/762957
 [165] https://rt.cpan.org/Public/Bug/Display.html?id=124509
 [166] https://build.opensuse.org/request/show/760838
 [167] https://build.opensuse.org/request/show/767311
 [168] https://build.opensuse.org/request/show/763080
 [169] https://github.com/sass/sassc-ruby/pull/178
 [170] https://build.opensuse.org/request/show/765317
 [171] https://bugzilla.opensuse.org/show_bug.cgi?id=1162112
 [172] https://build.opensuse.org/request/show/763685
 [173] https://build.opensuse.org/request/show/763683
 [174] https://build.opensuse.org/request/show/763260
 [175] https://build.opensuse.org/request/show/763287
 [176] https://build.opensuse.org/request/show/763292
 [177] https://build.opensuse.org/request/show/763285
 [178] https://build.opensuse.org/request/show/763266
 [179] https://build.opensuse.org/request/show/763282
 [180] https://build.opensuse.org/request/show/763281
 [181] https://build.opensuse.org/request/show/763263
 [182] https://build.opensuse.org/request/show/763261
 [183] https://build.opensuse.org/request/show/763259
 [184] https://build.opensuse.org/request/show/763257
 [185] https://build.opensuse.org/request/show/763522


Debian
------

There was yet more progress towards making the Debian Installer
[187] images reproducible. Following-on from last months' efforts,
Chris Lamb requested a status update [188] on the Debian bug in
question.

 [186] https://debian.org/
 [187] https://www.debian.org/devel/debian-installer/
 [188] https://bugs.debian.org/926242#157

Daniel Schepler posted to the debian-devel [190] mailing list to ask
whether "running dpkg-buildpackage manually from the command line"
[191] is supported, particularly with respect to having extra
packages installed during the package was built either resulted in a
failed build or even broken packages (eg. #948522, #887902, etc.). Our
.buildinfo files could be one solution to this as they record the
environment at the time of the package build.

Holger disabled scheduling of packages from the "oldstable" stretch
release on tests.reproducible-builds.org [194]. This is the first time
since stretch's existence that we are no longer testing this release.

 [190] https://lists.debian.org/debian-devel/
 [191] https://lists.debian.org/debian-devel/2020/01/msg00263.html
 [194] https://tests.reproducible-builds.org/

OpenJDK [195], a free and open-source implementation of the Java
Platform was updated in Debian [196] to incorporate a number of
patches from Emmanuel Bourg, including:

* Make the generated character data source files reproducible.
  (#933339)
* Make the generated module-info.java files reproducible.
  (#933342)
* Make the generated copyright headers reproducible. (#933349)
* Make the build user reproducible. (#933373)

 [195] https://jdk.java.net
 [196] https://tracker.debian.org/news/1094089/accepted-openjdk-11-110610-1-source-into-unstable/

83 reviews of Debian packages were added, 32 were updated and 96
were removed this month adding to our knowledge about identified
issues [201]. Many issue types were updated by Chris Lamb,
including:

* timestamp_in_casacore_tables
* random_identifiers_in_epub_files_generated_by_asciidoc
* nondeterministic_ordering_in_casacore_tables
* captures_build_path_in_golang_compiler
* captures_build_path_via_haskell_adddependentfile
* png_generated_by_plantuml_captures_kernel_version_and_builddate

 [201] https://tests.reproducible-builds.org/debian/index_issues.html

Lastly, Mattia Rizzolo altered the permissions and shared the
notes.git repository [202] which underpins the aforementioned
package classifications with the entire "Debian" group on Salsa
[203], therefore giving all DDs write access to it. This is an
attempt to invite more direct contributions instead of merge
requests.

 [202] https://salsa.debian.org/reproducible-builds/reproducible-notes
 [203] https://salsa.debian.org/


Other distributions
-------------------

The FreeBSD Project [204] Tweeted that:

> Reproducible builds are turned on by default for -RELEASE [205]

... which targets the next released version of this distribution [206].
Daniel Ebdrup [207] followed-up to note that this option:

> Used to be turned on in -CURRENT when it was being tested, but it
> has been turned off now that there's another branch where it's used,
> whereas -CURRENT has more need to have the revision printed in uname
> (which is one of the things that make a build unreproducible). [208]

 [204] https://www.freebsd.org/
 [205] https://twitter.com/debdrup/status/1217488583503892480
 [206] https://svnweb.freebsd.org/base?view=revision&revision=338642
 [207] https://nullrouted.org/
 [208] https://twitter.com/debdrup/status/1217515991267184645

For Alpine Linux [209], Holger Levsen disabled the builders run by the
Reproducible Builds project as our patch to the abuild utility (see
December's report [210] doesn't apply anymore and thus all builds have
become unreproducible again. Subsequent to this, a patch was merged
upstream. [211]

 [209] https://alpinelinux.org/
 [210] https://reproducible-buids.org/reports/2019-12/
 [211] https://github.com/alpinelinux/abuild/pull/110#issuecomment-580195097

In GNU Guix [212], on January 14th, Konrad Hinsen posted a blog post
entitled "Reproducible computations with Guix" [213] which, amongst
other things remarks that:

> The [guix time-machine command] machine actually downloads the
> specified version of Guix and passes it the rest of the command line.
> You are running the same code again. Even bugs in Guix will be
> reproduced faithfully!

 [209] https://alpinelinux.org/
 [210] https://reproducible-buids.org/reports/2019-12/
 [211] https://github.com/alpinelinux/abuild/pull/110#issuecomment-580195097
 [212] https://guix.gnu.org/
 [213] http://guix.gnu.org/blog/2020/reproducible-computations-with-guix/

The Yocto Project [214] reported that they have reproducible cross-built
binaries that are independent of both the underlying host distribution
the build is run on and independent of the path used for the build. This
is now being continually tested on the Yocto Project's automated
infrastructure to ensure this state is maintained in the future.

 [214] https://www.yoctoproject.org/


Project website & documentation
-------------------------------

There was more work performed on our website [215] this month,
including:

* Chris Lamb:

    * Python SOURCE_DATE_EPOCH [216] documentation, clarifying that
      the second example generates a Python str-type, not a
      datetime.datetime [217]
    * Correct word omissions in the report template. [218]
    * Link to to our mailing list overview page [219] (and not the
      archives). [220]
    * Apply the Black [221] source code reformatter to the draft
      generation script. [222]
    * Move continuous tests heading level to <h1> (vs. <h2>) to
      match the other pages. [223]
    * Calculate the report authors dynamically. [224]

* Holger Levsen:

    * Add Alpine Linux to our projects [226] and testing [227]
      pages. [228]
    * Add links to our list of projects being tested [229] [230]
      and mark Fedora [231] as being disabled at this time [232].

In addition, Arnout Engelen added a Scala [233] programming language
example for the SOURCE_DATE_EPOCH environment variable [235], David del
Amo updated the link to the Software Freedom Conversancy [236] to remove
some double parentheses [237] and Peter Wu added a Debian example for
the -ffile-prefix-map argument to support Clang [238] version 10 [239].

 [215] https://reproducible-builds.org/
 [216] https://reproducible-buids.org/docs/SOURCE_DATE_EPOCH
 [217] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/8eda319
 [218] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/7b54124
 [219] https://lists.reproducible-builds.org/listinfo/rb-general
 [220] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/6e92676
 [221] https://black.readthedocs.io/en/stable/
 [222] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/9fdd1cb
 [223] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/e1fc0e8
 [224] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/21da60b
 [226] https://reproducible-buids.org/who/
 [227] https://reproducible-buids.org/citests/
 [228] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/458ff5f
 [229] https://reproducible-buids.org/citests/
 [230] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/3fa3de8
 [231] https://getfedora.org/
 [232] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/195b811
 [233] https://www.scala-lang.org/
 [235] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/491fce1
 [236] https://sfconservancy.org/
 [237] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/f407ea2
 [238] https://clang.llvm.org/
 [239] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/a9ce0b0


Testing framework
-----------------

We operate a full-featured and comprehensive Jenkins [240]-based testing
framework that powers tests.reproducible-builds.org [241]. This month,
the following changes were made:

* Adrian Bunk:

    * Use the et_EE locale/language instead of fr_CH. In Estonian,
      the "z" character is sorted between "s" and "t" which is contrary
      to common incorrect assumptions about the sorting order of ASCII
      [242] characters. [243]
    * Add ffile_prefix_map_passed_to_clang to the list of issues
      filtered as these build failures should be ignored. [244]
    * Remove the ftbfs_build_depends_not_available_on_amd64 from the
      list of filtered issues as this specific problem no longer
      exists. [245]

* Holger Levsen:

    * Debian [246]:

        * Always configure apt to ignore expired release files on
          hosts running in the future. [247]
        * Create an "oldsuites" page, showing suites we used to test in
          the past. [248][249][250][251][252]
        * Schedule more old packages from the buster distribution.
          [253]
        * Deal with shell escaping and other options. [254][255][256]
        * Reverse the suite ordering on the packages page. [257][258]
        * Show bullseye statistics on dashboard page, moving away
          from buster [259] and additionally omit stretch
          [260].

    * F-Droid [261]:

        * Document the increased diskspace requirements; we require
          over 700 GiB now. [262]

    * Misc:

        * Gracefully deal with umount problems. [263][264]
        * Run code to show "todo" entries locally. [265]
        * Use mmdebstrap instead of debootstrap. [266][267][268]

* Jelle van der Waa (Arch Linux [269]):

    * Set the PACKAGER variable to a valid string to avoid noise in
      the logging. [270]
    * Add a link to the Arch Linux-specific package page in the
      overview table. [271]

* Mattia Rizzolo:

    * Fix a hard-coded reference to the current year. [272]
    * Ignore "No server certificate defined" warning messages when
      automatically parsing logfiles. [273]

* Vagrant Cascadian special-cased u-boot [274] on the armhf
  architecture: First, do not build the all architecture as the
  dependencies are not available on this architecture [275] and
  also pass the --binary-arch argument to pbuilder too [276].

The usual node maintenance was performed by Mattia Rizzolo
[277][278], Vagrant Cascadian [279][280][281][282] and Holger
Levsen.

 [240] https://jenkins.io/
 [241] https://tests.reproducible-builds.org
 [242] https://en.wikipedia.org/wiki/ASCII
 [243] https://salsa.debian.org/qa/jenkins.debian.net/commit/d1f68a80
 [244] https://salsa.debian.org/qa/jenkins.debian.net/commit/ea55e4bc
 [245] https://salsa.debian.org/qa/jenkins.debian.net/commit/64a062e3
 [246] https://debian.org/
 [247] https://salsa.debian.org/qa/jenkins.debian.net/commit/30a71a97
 [248] https://salsa.debian.org/qa/jenkins.debian.net/commit/ffc13a29
 [249] https://salsa.debian.org/qa/jenkins.debian.net/commit/c1accbfb
 [250] https://salsa.debian.org/qa/jenkins.debian.net/commit/13550757
 [251] https://salsa.debian.org/qa/jenkins.debian.net/commit/2545eba2
 [252] https://salsa.debian.org/qa/jenkins.debian.net/commit/d9b11c34
 [253] https://salsa.debian.org/qa/jenkins.debian.net/commit/e5ebb1fa
 [254] https://salsa.debian.org/qa/jenkins.debian.net/commit/a35cc960
 [255] https://salsa.debian.org/qa/jenkins.debian.net/commit/872453bb
 [256] https://salsa.debian.org/qa/jenkins.debian.net/commit/b5091f70
 [257] https://salsa.debian.org/qa/jenkins.debian.net/commit/d27e8d3f
 [258] https://salsa.debian.org/qa/jenkins.debian.net/commit/d495b88f
 [259] https://salsa.debian.org/qa/jenkins.debian.net/commit/db5cf9c0
 [260] https://salsa.debian.org/qa/jenkins.debian.net/commit/5516f56f
 [261] https://f-droid.org/
 [262] https://salsa.debian.org/qa/jenkins.debian.net/commit/a6a0a691
 [263] https://salsa.debian.org/qa/jenkins.debian.net/commit/a555f19e
 [264] https://salsa.debian.org/qa/jenkins.debian.net/commit/9f58a8df
 [265] https://salsa.debian.org/qa/jenkins.debian.net/commit/cdad9995
 [266] https://salsa.debian.org/qa/jenkins.debian.net/commit/6ce1a757
 [267] https://salsa.debian.org/qa/jenkins.debian.net/commit/cab70212
 [268] https://salsa.debian.org/qa/jenkins.debian.net/commit/464508f1
 [269] https://archlinux.org/
 [270] https://salsa.debian.org/qa/jenkins.debian.net/commit/66c8eee0
 [271] https://salsa.debian.org/qa/jenkins.debian.net/commit/95c9006e
 [272] https://salsa.debian.org/qa/jenkins.debian.net/commit/d61c0338
 [273] https://salsa.debian.org/qa/jenkins.debian.net/commit/1919aa19
 [274] https://www.denx.de/wiki/U-Boot/
 [275] https://salsa.debian.org/qa/jenkins.debian.net/commit/08ef4bae
 [276] https://salsa.debian.org/qa/jenkins.debian.net/commit/0c838739
 [277] https://salsa.debian.org/qa/jenkins.debian.net/commit/0c6b7024
 [278] https://salsa.debian.org/qa/jenkins.debian.net/commit/e60be6d4
 [279] https://salsa.debian.org/qa/jenkins.debian.net/commit/79dbfa03
 [280] https://salsa.debian.org/qa/jenkins.debian.net/commit/d2fcbfab
 [281] https://salsa.debian.org/qa/jenkins.debian.net/commit/d3d94fcc
 [282] https://salsa.debian.org/qa/jenkins.debian.net/commit/19baf9e9


Misc news
---------

On our mailing list [283] this month:

* Chris Lamb responded in-depth to a thread on "Reproducible system
  images" [284] that was started in December [285] by Lars Wirzenius.
  This then led to a sub-thread regarding reproducible Docker images
  [286].

* Holger Levsen posted a brief request for help [287] regarding the bot
  that lives on our #reproducible-builds IRC channel that interfaces
  with our Twitter handle [288].

 [283] https://lists.reproducible-builds.org/listinfo/rb-general/
 [284] https://lists.reproducible-builds.org/pipermail/rb-general/2020-January/001771.html
 [285] https://lists.reproducible-builds.org/pipermail/rb-general/2019-December/001750.html
 [286] https://lists.reproducible-builds.org/pipermail/rb-general/2020-January/001779.html
 [287] https://lists.reproducible-builds.org/pipermail/rb-general/2020-January/001783.html
 [288] https://twitter.com/ReproBuilds

?

If you are interested in contributing to the Reproducible Builds
project, please visit our "Contribute" [289] page on our website.
However, you can also get in touch with us via:

 * IRC: #reproducible-builds on irc.oftc.net.
 * Twitter: @ReproBuilds [290]
 * Reddit: /r/ReproducibleBuilds [291]
 * Mailing list: rb-general at lists.reproducible-builds.org [292]

 [289] https://reproducible-builds.org/contribute/
 [290] https://twitter.com/ReproBuilds
 [291] https://reddit.com/r/reproduciblebuilds
 [292] https://lists.reproducible-builds.org/listinfo/rb-general

?

This month's report was written by Arnout Engelen, Bernhard M.
Wiedemann, Chris Lamb, heinrich5991, Holger Levsen, Jelle van der Waa,
Mattia Rizzolo and Vagrant Cascadian. It was subsequently reviewed by a
bunch of Reproducible Builds folks on IRC and the mailing list.


Best wishes,

-- 
      o
    ?   ?      Chris Lamb
   o     o     reproducible-builds.org
    ?   ?
      o

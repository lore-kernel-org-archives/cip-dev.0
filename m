From: chris@reproducible-builds.org (Chris Lamb)
Date: Fri, 06 Sep 2019 13:15:24 +0100
Subject: [cip-dev] Reproducible Builds in August 2019
Message-ID: <5b563474-b5ff-4de2-b370-6a25752c6c26@www.fastmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

==================================
Reproducible Builds in August 2019
==================================

Welcome to the August 2019 report from the Reproducible
Builds [0] project!

In these monthly reports we outline the most important things that have
happened in the world of Reproducible Builds and we have been up to.
You can find a HTML version of this report at the following URI:

   https://reproducible-builds.org/reports/2019-08/

As a quick recap of our project, whilst anyone can inspect the source
code of free software for malicious flaws, most software is distributed
to end users or systems as precompiled binaries. The motivation behind
the reproducible builds effort is to ensure zero changes have been
introduced during these compilation processes. This is achieved by
promising identical results are always generated from a given source
thus allowing multiple third-parties to come to a consensus on whether a
build was changed or even compromised.

In August's month's report, we cover:

* Media coverage & events ? *Webmin, CCCamp, etc.*
* Distribution work ? *The first fully-reproducible package sets,
  openSUSE update, etc*
* Upstream news ? *libfaketime updates, gzip, ensuring good
  definitions, etc.*
* Software development ? *More work on diffoscope, new variations in
  our testing framework, etc.*
* Misc news ? *From our mailing list, etc.*
* Getting in touch ? *How to contribute, etc.*

If you are interested in contributing to our project, please visit our
*Contribute* [1] page on our website.

 [ 0] https://reproducible-builds.org
 [ 1] https://reproducible-builds.org/contribute/


Media coverage & events
=======================

A backdoor was found in Webmin [2] a popular web-based application used
by sysadmins to remotely manage Unix-based systems. Whilst more details
can be found on upstream's dedicated exploit page [3], it appears that
the build toolchain was compromised. Especially of note is that the
exploit "did not show up in any Git diffs" and thus would not have been
found via an audit of the source code. The backdoor would allow a remote
attacker to execute arbitrary commands with superuser privileges on the
machine running Webmin. Once a machine is compromised, an attacker could
then use it to launch attacks on other systems managed through Webmin or
indeed any other connected system. Techniques such as reproducible
builds can help detect exactly these kinds of attacks that can lay
dormant for years. (LWN comments [4])

In a talk titled *There and Back Again, Reproducibly!* [5] Holger Levsen
and Vagrant Cascadian presented at the 2019 edition of the Linux
Developer Conference [6] in S?o Paulo, Brazil on Reproducible Builds.

LWN [7] posted and hosted an interesting summary and discussion on
*Hardening the "file" utility for Debian* [8]. In July, Chris Lamb had
cross-posted his reply to the "Re: file(1) now with seccomp support
enabled [9]" thread, originally started on the "debian-devel" [10]
mailing list. In this post, Chris refers to our "strip-nondeterminism"
tool not being able to accommodate the additional security hardening in
"file(1)" [11] and the changes made to the tool in order to do fix this
issue which was causing a huge number of regressions in our testing
framework [12].

The Chaos Communication Camp [13] ? an international, five-day open-air
event for hackers that provides a relaxed atmosphere for free exchange
of technical, social, and political ideas ? hosted its 2019 edition [14]
where there were many discussions and meet-ups at least partly related
to Reproducible Builds. This including the titular Reproducible Builds
Meetup [15] session which was attended by around twenty-five people
where half of them were new to the project as well as a session
dedicated to all Arch Linux related issues [16].

 [ 2] http://www.webmin.com/
 [ 3] http://www.webmin.com/exploit.html
 [ 4] https://lwn.net/Articles/796951/
 [ 5] https://cfp.linuxdev-br.net/2019/talk/VH9CCY/
 [ 6] https://linuxdev-br.net/
 [ 7] https://lwn.net
 [ 8] https://lwn.net/Articles/796108
 [ 9] https://lists.reproducible-builds.org/pipermail/rb-general/2019-July/001612.html
 [10] https://lists.debian.org/debian-devel/2019/07/msg00391.html
 [11] http://darwinsys.com/file/
 [12] http://tests.reproducible-builds.org/
 [13] https://en.wikipedia.org/wiki/Chaos_Communication_Camp
 [14] https://events.ccc.de/camp/2019/
 [15] https://events.ccc.de/camp/2019/wiki/Session:Reproducible_Builds_Meetup
 [16] https://events.ccc.de/camp/2019/wiki/Session:Arch_Linux_Meetup


Distribution work
=================

In Debian, the first "package sets" ? ie. defined subsets of the entire
archive ? have become 100% reproducible including as the so-called
"essential" set for the bullseye distribution on the "amd64" [17] and
the "armhf" [18] architectures. This is thanks to work by Chris Lamb on
"bash" [19], "readline" [20] and other low-level libraries and tools.
Perl still has issues on "i386" [21] and "arm64" [22], however.

Dmitry Shachnev filed a bug report [23] against the "debhelper" utility
that speaks to issues around using the date from the "debian/changelog"
file as the source for the "SOURCE_DATE_EPOCH" [24] environment variable
as this can lead to non-intuitive results when package is automatically
rebuilt via so-called binary (NB. not "source" [25]) NMUs. A related
issue was later filed against "qtbase5-dev" [26] by Helmut Grohne as
this exact issue led to an issue with co-installability
across architectures.

Lastly, 115 reviews of Debian packages were added, 45 were updated and
244 were removed this month, appreciably adding to our knowledge about
identified issues [27]. Many issue types were updated by Chris Lamb,
including "embeds_build_data_via_node_preamble" [28],
"embeds_build_data_via_node_rollup" [29],
"captures_build_path_in_beam_cma_cmt_files" [30],
"captures_varying_number_of_build_path_directory_components" [31]
(discussed later), "timezone_specific_files_due_to_haskell_devscripts"
[32], etc.

Bernhard M. Wiedemann posted his monthly Reproducible Builds status
update [33] for the openSUSE [34] distribution. New issues were found
from enabling Link Time Optimization [35] (LTO) in this distribution's
*Tumbleweed* [36] branch. This affected, for example, "nvme-cli" [37] as
well as "perl-XML-Parser" and "pcc" [38] with packaging issues.

 [17] https://tests.reproducible-builds.org/debian/bullseye/amd64/pkg_set_essential.html
 [18] https://tests.reproducible-builds.org/debian/bullseye/armhf/pkg_set_essential.html
 [19] https://bugs.debian.org/935127
 [20] https://bugs.debian.org/935363
 [21] https://tests.reproducible-builds.org/debian/rb-pkg/bullseye/i386/diffoscope-results/perl.html
 [22] https://tests.reproducible-builds.org/debian/rb-pkg/bullseye/arm64/diffoscope-results/perl.html
 [23] https://bugs.debian.org/934405
 [24] https://reproducible-builds.org/docs/source-date-epoch/
 [25] https://wiki.debian.org/NonMaintainerUpload
 [26] https://bugs.debian.org/934511
 [27] https://tests.reproducible-builds.org/debian/index_issues.html
 [28] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/5d91c741
 [29] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/e6b686f3
 [30] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/850df406
 [31] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/c0c72250
 [32] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/a1a65bba
 [33] https://lists.opensuse.org/opensuse-factory/2019-08/msg00186.html
 [34] https://opensuse.org/
 [35] https://gcc.gnu.org/wiki/LinkTimeOptimization
 [36] https://software.opensuse.org/distributions/tumbleweed
 [37] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91307
 [38] https://bugzilla.opensuse.org/show_bug.cgi?id=1146634


Upstream news
=============

* "libfaketime" [39] is a tool to trick programs into believing that
  the current system time is actually one specified by the user. This
  month, Bernhard M. Wiedemann requested the ability to track and
  intercept calls that change file timestamps [40] which can help
  better debug or fix reproducibility issues in software.

* Chris Lamb requested that the "molior" build tool [41] prefers to use
  the term "repeatable build" [42] in order to avoid confusion over the
  term "reproducible."

* The "gzip [43]" program is commonly used to compress artifacts such
  as the the source code archives generated by Sourcehut [44] hosting
  platform, but depending on the specific program used, the output may
  be different. Daniel Edgecumbe has submitted patches [45] to the
  BusyBox [46] suite of tools to ensure the output of its version of
  "gzip" matches the output of GNU gzip [47] when using the same
  options regardless of the configuration of BusyBox. In the process,
  an off-by-one error [48] in the default settings was also fixed.

* There was more progress on ensuring that the "gem" tool in rubygems
  respects [49] the "SOURCE_DATE_EPOCH" [50] environment variable.

* A request to include ".buildinfo" files [51] in the OpenWRT [52]
  operating system that targets embedded devices such as routes, etc.
  was accepted and merged upstream.

 [39] https://github.com/wolfcw/libfaketime
 [40] https://github.com/wolfcw/libfaketime/issues/183
 [41] https://github.com/molior-dbs/molior
 [42] https://github.com/molior-dbs/molior/issues/3
 [43] https://www.gzip.org/
 [44] https://todo.sr.ht/~sircmpwn/git.sr.ht/232
 [45] http://lists.busybox.net/pipermail/busybox/2019-September/087438.html
 [46] https://busybox.net/
 [47] https://www.gnu.org/software/gzip/
 [48] https://en.wikipedia.org/wiki/Off-by-one_error
 [49] https://github.com/rubygems/rubygems/issues/2290#issuecomment-522206365
 [50] https://reproducible-builds.org/docs/source-date-epoch/
 [51] https://github.com/openwrt/openwrt/pull/2121
 [52] https://openwrt.org/


Software development
====================

The Reproducible Builds project detects, dissects and attempts to fix as
many currently-unreproducible packages as possible. We endeavour to send
all of our patches upstream where appropriate. In August we wrote a
large number of such patches, including:

* Bernhard M. Wiedemann:

    * "buildad" [53] (date)
    * "dracut" [54] (CPU influences build result)
    * "fwupd" [55] (unreproducible LTO [56] data)
    * "gnutls" [57] (date / copyright year)
    * "katacontainers-image-initrd/osbuilder" [58] (shell date; new
      variant with nanoseconds)
    * "kernel-obs-build" [59] (date from "/etc/shadow")
    * "kernel-vanilla" [60] (drop number of CPUs)
    * "libfaketime" [61] (toolchain: fix various builds under
      "libfaketime" [62])
    * "nethack" [63] (date and "tar(1)" [64]))
    * "pcc" [65] (unreproducible when building with LTO [66])
    * "python-ipyparallel" [67] (Fails to build with a single CPU
      / "-j1")
    * "python-pytest-httpserver" [68] (renew SSL certs to fix FTBFS
      after September 2019)
    * "python-python3-saml" [69] (Fails to build in 2020)
    * "sblim-cmpi-base" [70] (Disable parallel "make" [71]) due to
      broken build dependencies)

 [53] https://github.com/containers/buildah/pull/1805
 [54] https://github.com/dracutdevs/dracut/issues/617
 [55] https://bugzilla.opensuse.org/show_bug.cgi?id=1143905
 [56] https://gcc.gnu.org/wiki/LinkTimeOptimization
 [57] https://gitlab.com/gnutls/gnutls/merge_requests/1058
 [58] https://github.com/kata-containers/osbuilder/pull/340
 [59] https://lists.opensuse.org/opensuse-kernel/2019-08/msg00001.html
 [60] https://lists.opensuse.org/opensuse-kernel/2019-08/msg00000.html
 [61] https://github.com/wolfcw/libfaketime/issues/183
 [62] https://github.com/wolfcw/libfaketime
 [63] https://build.opensuse.org/request/show/722212
 [64] https://en.wikipedia.org/wiki/Tar_(computing
 [65] https://bugzilla.opensuse.org/show_bug.cgi?id=1146634
 [66] https://gcc.gnu.org/wiki/LinkTimeOptimization
 [67] https://github.com/ipython/ipyparallel/issues/380
 [68] https://github.com/csernazs/pytest-httpserver/pull/22
 [69] https://github.com/onelogin/python3-saml/pull/156
 [70] https://build.opensuse.org/request/show/726294

* Chris Lamb:

    * #872728 [72] filed against "desktop-file-utils" [73] (closed)
    * #933783 [74] filed against "virulencefinder" [75].
    * #933790 [76] filed against "norsnet" [77].
    * #933834 [78] filed against "haskell-devscripts" [79].
    * #933838 [80] filed against "superlu-dist" [81].
    * #934120 [82] filed against "python-bleach" [83].
    * #934697 [84] filed against "re2c" [85] (filed upstream [86]).
    * #934698 [87] filed against "libchamplain" [88] (filed
      upstream [89])
    * #934699 [90] filed against "scons" [91].
    * #934767 [92] filed against "ecbuild" [93].
    * #934918 [94] filed against "python-etcd3gw" [95].
    * #934919 [96] filed against "omnidb" [97].
    * #935127 [98] filed against "bash" [99].
    * #935361 [100] filed against "node-autoprefixer" [101].
    * #935362 [102] filed against "gdbm" [103].
    * #935363 [104] filed against "readline" [105].
    * #935790 [106] filed against "node-package-preamble" [107].
    * #935846 [108] filed against "musescore-snapshot" [109].
    * #936452 [110] filed against "ust-fs-extra" [111].
    * #936453 [112] filed against "litl" [113].

 [71] https://en.wikipedia.org/wiki/Make_(software
 [72] https://bugs.debian.org/872728
 [73] https://tracker.debian.org/pkg/desktop-file-utils
 [74] https://bugs.debian.org/933783
 [75] https://tracker.debian.org/pkg/virulencefinder
 [76] https://bugs.debian.org/933790
 [77] https://tracker.debian.org/pkg/norsnet
 [78] https://bugs.debian.org/933834
 [79] https://tracker.debian.org/pkg/haskell-devscripts
 [80] https://bugs.debian.org/933838
 [81] https://tracker.debian.org/pkg/superlu-dist
 [82] https://bugs.debian.org/934120
 [83] https://tracker.debian.org/pkg/python-bleach
 [84] https://bugs.debian.org/934697
 [85] https://tracker.debian.org/pkg/re2c
 [86] https://github.com/skvadrik/re2c/pull/258
 [87] https://bugs.debian.org/934698
 [88] https://tracker.debian.org/pkg/libchamplain
 [89] https://gitlab.gnome.org/GNOME/libchamplain/merge_requests/9
 [90] https://bugs.debian.org/934699
 [91] https://tracker.debian.org/pkg/scons
 [92] https://bugs.debian.org/934767
 [93] https://tracker.debian.org/pkg/ecbuild
 [94] https://bugs.debian.org/934918
 [95] https://tracker.debian.org/pkg/python-etcd3gw
 [96] https://bugs.debian.org/934919
 [97] https://tracker.debian.org/pkg/omnidb
 [98] https://bugs.debian.org/935127
 [99] https://tracker.debian.org/pkg/bash
 [100] https://bugs.debian.org/935361
 [101] https://tracker.debian.org/pkg/node-autoprefixer
 [102] https://bugs.debian.org/935362
 [103] https://tracker.debian.org/pkg/gdbm
 [104] https://bugs.debian.org/935363
 [105] https://tracker.debian.org/pkg/readline
 [106] https://bugs.debian.org/935790
 [107] https://tracker.debian.org/pkg/node-package-preamble
 [108] https://bugs.debian.org/935846
 [109] https://tracker.debian.org/pkg/musescore-snapshot
 [110] https://bugs.debian.org/936452
 [111] https://tracker.debian.org/pkg/rust-fs-extra
 [112] https://bugs.debian.org/936453
 [113] https://tracker.debian.org/pkg/litl

* Mathieu Parent: "php-pear" [114] ? Fixes over 150 packages with
  date issues.

 [114] https://github.com/pear/pear-core/pull/96


diffoscope
----------

"diffoscope" [115] is our in-depth and content-aware diff utility that
can locate and diagnose reproducibility issues. It is run countless
times a day on our testing infrastructure [116] and is essential for
identifying fixes and causes of non-deterministic behaviour.

This month, Chris Lamb made the following changes:

* Improvements:

    * Don't fallback to an unhelpful raw hexdump when, for example,
      "readelf(1)" reports an minor issue in a section in an ELF
      binary. For example, when the ".frames" section is of the
      "NOBITS" type its contents are apparently "unreliable" and thus
      "readelf(1)" returns 1. (#58 [117], #931962 [118])
    * Include either standard error or standard output (not just the
      latter) when an external command fails. [119]

* Bug fixes:

    * Skip calls to "unsquashfs" when we are neither root nor running
      under "fakeroot". (#63 [120])
    * Ensure that all of our artificially-created
      "subprocess.CalledProcessError" [121] instances have "output"
      instances that are "bytes" objects, not "str". [122]
    * Correct a reference to "parser.diff"; "diff" in this context is a
      Python function in the module. [123]
    * Avoid a possible traceback caused by a "str"/"bytes" type
      confusion when handling the output of failing external
      commands. [124]

* Testsuite improvements:

    * Test for "4.4" in the output of "squashfs -version", even though
      the Debian package version is
      "1:4.3+git190823-1". [125]
    * Apply a patch from L?szl? B?sz?rm?nyi to update the "squashfs"
      test output and additionally bump the required version for the
      test itself. (#62 [126] & #935684 [127])
    * Add the "wabt" Debian package to the test-dependencies so that we
      run the WebAssembly [128] tests on our continuous integration
      platform, etc. [129]

* Improve debugging:

    * Add the containing module name to the (eg.) "Using StaticLibFile
      for ..." debugging messages. [130]
    * Strip off trailing "original size modulo 2^32 671" (etc.) from
      "gzip" compressed data as this is just a symptom of the contents
      itself changing that will be reflected elsewhere. (#61 [131])
    * Avoid a lack of space between "... with return code 1" and
      "Standard output". [132]
    * Improve debugging output when instantantiating our "Comparator"
      object types. [133]
    * Add a literal "eg." to the comment on stripping "original size
      modulo..." text to emphasise that the actual numbers are not
      fixed. [134]

* Internal code improvements:

    * No need to parse the section group from the class name; we can
      pass it via "type" built-in "kwargs" argument. [135]
    * Add support to "Difference.from_command_exc" and friends to
      ignore specific returncodes from the called program and treat
      them as "no" difference. [136]
    * Simplify parsing of optional "command_args" argument to
      "Difference.from_command_exc". [137]
    * Set "long_description_content_type" to "text/x-rst" to appease
      the PyPI.org [138] linter. [139]
    * Reposition a comment regarding an exception within the indented
      block to match Python code convention. [140]

 [115] https://diffoscope.org
 [116] https://tests.reproducible-builds.org/debian/reproducible.html
 [117] https://salsa.debian.org/reproducible-builds/diffoscope/issues/58
 [118] https://bugs.debian.org/931962
 [119] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/4689755
 [120] https://salsa.debian.org/reproducible-builds/diffoscope/issues/63
 [121] https://docs.python.org/3/library/subprocess.html
 [122] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/eb02809
 [123] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/8eb9e39
 [124] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/b803d43
 [125] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/7cecd8a
 [126] https://salsa.debian.org/reproducible-builds/diffoscope/issues/62
 [127] https://bugs.debian.org/935684
 [128] https://webassembly.org/
 [129] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/84ad96d
 [130] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/2f101b8
 [131] https://salsa.debian.org/reproducible-builds/diffoscope/issues/61
 [132] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/ffa22f8
 [133] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/1647da8
 [134] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/18e3526
 [135] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/5261096
 [136] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/d3c7ac8
 [137] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/cc9a730
 [138] https://pypi.org/
 [139] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/7583af2
 [140] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/ec86443

In addition, Mattia Rizzolo made the following changes:

* Now that we install wabt, expect its tools to be available. [141]
* Bump the Debian backport check. [142]

Lastly, Vagrant Cascadian updated diffoscope to versions 120 [143], 121
[144] and 122 [145] in the GNU Guix [146] distribution.

 [141] https://salsa.debian.org/reproducible-builds/diffoscope/commit/f2e72a8
 [142] https://salsa.debian.org/reproducible-builds/diffoscope/commit/9591cfb
 [143] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=c91364d36cf6c8fc4c696d151eb9fca7832cf898
 [144] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=8c1379ba404b4db2f0afcf431a4ff720b72a7a19
 [145] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=b126f41b301a5ac13835bf20026ae6d1d5ae2bee
 [146] https://guix.gnu.org/


strip-nondeterminism
--------------------

strip-nondeterminism [147] is our tool to remove specific non-
deterministic results from a completed build. This month, Chris Lamb
made the following changes.

* Add support for enabling and disabling specific normalizers via the
  command line. (#10 [148])
* Drop accidentally-committed warning emitted on every fixture-based
  test. [149]
* Reintroduce the ".ar" normalizer [150] but disable it by
  default so that it can be enabled with "--normalizers=+ar" or
  similar. (#3 [151])
* In verbose mode, print the normalizers that "strip-nondeterminism"
  will apply. [152]

In addition, there was some movement on an issue in the "Archive::Zip"
Perl module [153] that "strip-nondeterminism" uses regarding the lack of
support for "bzip" compression [154] that was originally filed in 2016
[155] by Andrew Ayer [156].

 [147] https://tracker.debian.org/pkg/strip-nondeterminism
 [148] https://salsa.debian.org/reproducible-builds/strip-nondeterminism/issues/10
 [149] https://salsa.debian.org/reproducible-builds/strip-nondeterminism.git/commit/e1def58
 [150] https://salsa.debian.org/reproducible-builds/strip-nondeterminism.git/commit/bb13f8b
 [151] https://salsa.debian.org/reproducible-builds/strip-nondeterminism#3
 [152] https://salsa.debian.org/reproducible-builds/strip-nondeterminism.git/commit/2637e1c
 [153] https://metacpan.org/pod/Archive::Zip
 [154] https://en.wikipedia.org/wiki/Bzip2
 [155] https://github.com/redhotpenguin/perl-Archive-Zip/issues/26
 [156] https://www.agwa.name/


Test framework
--------------

We operate a comprehensive Jenkins [157] based testing framework that
powers tests.reproducible-builds.org [158].

This month Vagrant Cascadian suggested and subsequently implemented
[159] that we additionally test a varying build directory of different
string lengths (eg. "/path/to/123" vs "/path/to/123456" but we also vary
the number of directory *components* within this, eg. "/path/to/dir" vs.
"/path/to/parent/subdir". Curiously, whilst it was *a priori* believed
that was rather unlikely to yield differences, Chris Lamb has managed to
identify approximately twenty packages [160] that are affected by
this issue.

It was also noticed that our testing of the Coreboot free software
firmware [161] fails to build the toolchain since we switched to
building on the Debian "buster" distribution. The last successful build
was on August 7th [162] but all newer builds have failed.

 [157] https://jenkins.io/
 [158] https://tests.reproducible-builds.org
 [159] https://salsa.debian.org/qa/jenkins.debian.net/commit/94469490
 [160] https://tests.reproducible-builds.org/debian/issues/unstable/captures_varying_number_of_build_path_directory_components_issue.html
 [161] https://tests.reproducible-builds.org/coreboot/coreboot.html
 [162] https://jenkins.debian.net/job/reproducible_coreboot/356 was t

In addition, the following code changes were performed in the
last month:

* Chris Lamb: Ensure that the size the log for the second build in HTML
  pages was also correctly formatted (eg. "12KB" vs
  "12345"). [163]

* Holger Levsen:

    * Many changes related to updating our build nodes to the "buster"
      distribution for Debian. [164][165][...
      [166][167][168][169][170]
    * Attempt to automatically fixup spurious build
      failures. [171]
    * Update the maintainer address for the Debian team tasked with
      maintaining [172] the MATE desktop [173]. [174]
    * Try not to build all the release tags of tools such as diffoscope
      [175], etc.. [176]
    * Use a newer kernel to support building the latest Arch Linux
      [177] packages. [178]
    * Re-add checks for "zombie" and log file size sanity
      checks. [179][180][181][182]
    * Vary the choice of kernel on the "amd64" again by using the
      kernel from Debian "backports" [183]. [184]
    * Drop some ancient Debian "jessie"-related
      configuration. [185][186][187]

* Mathieu Parent: Update the contact details for the Debian PHP Group
  [188]. [189]

* Mattia Rizzolo:
    * Update our Postfix [190] email server configuration. [...
      [191][192][193]
    * Use the "safe_load" function of PyYAML [194] when parsing YAML-
      formatted [195] files. [196]

 [163] https://salsa.debian.org/reproducible-builds/jenkins.debian.net.git/commit/080d7ba3
 [164] https://salsa.debian.org/qa/jenkins.debian.net/commit/a97c97ec
 [165] https://salsa.debian.org/qa/jenkins.debian.net/commit/6fb3ee7b
 [166] https://salsa.debian.org/qa/jenkins.debian.net/commit/1fad75e4
 [167] https://salsa.debian.org/qa/jenkins.debian.net/commit/7fef98af
 [168] https://salsa.debian.org/qa/jenkins.debian.net/commit/da55be7a
 [169] https://salsa.debian.org/qa/jenkins.debian.net/commit/28941bc2
 [170] https://salsa.debian.org/qa/jenkins.debian.net/commit/309a1d66
 [171] https://salsa.debian.org/qa/jenkins.debian.net/commit/82bee189
 [172] https://wiki.debian.org/Teams/pkg-mate
 [173] https://mate-desktop.org/
 [174] https://salsa.debian.org/qa/jenkins.debian.net/commit/e6f7c6d4
 [175] https://diffoscope.org
 [176] https://salsa.debian.org/qa/jenkins.debian.net/commit/974b699e
 [177] https://www.archlinux.org/
 [178] https://salsa.debian.org/qa/jenkins.debian.net/commit/7e575590
 [179] https://salsa.debian.org/qa/jenkins.debian.net/commit/f17552ad
 [180] https://salsa.debian.org/qa/jenkins.debian.net/commit/30049d46
 [181] https://salsa.debian.org/qa/jenkins.debian.net/commit/9fbf8d2c
 [182] https://salsa.debian.org/qa/jenkins.debian.net/commit/42d7c71a
 [183] https://backports.debian.org/
 [184] https://salsa.debian.org/qa/jenkins.debian.net/commit/b2870778
 [185] https://salsa.debian.org/qa/jenkins.debian.net/commit/96cbb81e
 [186] https://salsa.debian.org/qa/jenkins.debian.net/commit/7e37c5a4
 [187] https://salsa.debian.org/qa/jenkins.debian.net/commit/87840dae
 [188] https://wiki.debian.org/Teams/DebianPHPGroup
 [189] https://salsa.debian.org/qa/jenkins.debian.net/commit/03510cdf
 [190] http://www.postfix.org/
 [191] https://salsa.debian.org/qa/jenkins.debian.net/commit/61ceaf5d
 [192] https://salsa.debian.org/qa/jenkins.debian.net/commit/8780a849
 [193] https://salsa.debian.org/qa/jenkins.debian.net/commit/3b964081
 [194] https://pyyaml.org/wiki/PyYAMLDocumentation
 [195] https://en.wikipedia.org/wiki/YAML
 [196] https://salsa.debian.org/qa/jenkins.debian.net/commit/fa720775


The usual node maintenance was performed by Holger Levsen [...
[197][198] and Vagrant Cascadian [199].

 [197] https://salsa.debian.org/qa/jenkins.debian.net/commit/961d70a6
 [198] https://salsa.debian.org/qa/jenkins.debian.net/commit/25f295b7
 [199] https://salsa.debian.org/qa/jenkins.debian.net/commit/30f567ff


Misc news
=========

There was a yet more effort put into our our website [200] this month,
including misc copyediting by Chris Lamb [201], Mathieu
Parent referencing his fix for "php-pear" [202] and Vagrant
Cascadian updating a link to his homepage. [203].

On our mailing list [204] this month Santiago Torres Arias started a
*Setting up a MS-hosted rebuilder with in-toto metadata* [205] thread
regarding Microsoft's interest in setting up a rebuilder for Debian
packages touching on issues of transparency logs and the integration of
in-toto [206] by the Secure Systems Lab [207] at New York University
[208]. In addition, Lars Wirzenius [209] continued conversation
regarding various questions about reproducible builds [210] and their
bearing on building a distributed continuous integration system.

Lastly, in a thread titled *Reproducible Builds technical introduction
tutorial* [211] Jathan asked whether anyone had some "easy" Reproducible
Builds tutorials in slides, video or written document format.

 [200] https://reproducible-builds.org/
 [201] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/a911e9d
 [202] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/e47ade1
 [203] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/7f8bc7e
 [204] https://lists.reproducible-builds.org/pipermail/rb-general/
 [205] https://lists.reproducible-builds.org/pipermail/rb-general/2019-August/001640.html
 [206] https://in-toto.io/
 [207] https://ssl.engineering.nyu.edu/
 [208] https://engineering.nyu.edu/
 [209] https://liw.fi/
 [210] https://lists.reproducible-builds.org/pipermail/rb-general/2019-August/001634.html
 [211] https://lists.reproducible-builds.org/pipermail/rb-general/2019-August/001639.html


Getting in touch
================

If you are interested in contributing the Reproducible Builds project,
please visit our *Contribute* [212] page on our website. However, you
can get in touch with us via:

 * IRC: "#reproducible-builds" on "irc.oftc.net".

 * Twitter: @ReproBuilds [213]

 * Mailing list: "rb-general at lists.reproducible-builds.org" [214]

 [212] https://reproducible-builds.org/contribute/
 [213] https://twitter.com/ReproBuilds
 [214] https://lists.reproducible-builds.org/listinfo/rb-general

This month's report was written by Bernhard M. Wiedemann, Chris Lamb,
Eli Schwartz, Holger Levsen, Jelle van der Waa, Mathieu Parent and
Vagrant Cascadian. Wiedemann, Chris Lamb, Holger Levsen, Mathieu Parent
and Vagrant Cascadian. It was subsequently reviewed by a bunch of
Reproducible Builds folks on IRC and the mailing list.


Best wishes,

-- 
      o
    ?   ?      Chris Lamb
   o     o     reproducible-builds.org
    ?   ?
      o

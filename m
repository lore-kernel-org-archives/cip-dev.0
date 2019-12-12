From: chris@reproducible-builds.org (Chris Lamb)
Date: Thu, 12 Dec 2019 16:59:02 +0000
Subject: [cip-dev] November 2019 in Reproducible Builds
Message-ID: <7852ad50-9609-44cd-8d1e-0d2d20a2beb2@www.fastmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

====================================================================

        o
      ?   ?      November 2019 in Reproducible Builds
     o     o
      ?   ?      https://reproducible-builds.org/reports/2019-11/
        o

====================================================================


Welcome to the November 2019 report from the Reproducible Builds
project.

As a summary of our project, whilst anyone can inspect the source
code of free software for malicious flaws almost all software is
distributed to end users as pre-compiled binaries. The motivation
behind the reproducible builds effort is therefore to ensure no
flaws have been introduced during this compilation process by
promising identical results are always generated from a given
source, thus allowing multiple third-parties to come to a consensus
on whether a build was compromised.

In this month's report, we cover:

* Media coverage and events ? A Reproducibility Challenge, etc.
* Upstream news ? OCaml, Mes, Maven, etc.
* Distribution work ? The latest reports from Arch, Debian and
  openSUSE, and friends
* Software development ? Holiday bonanza of patches, work on
  diffoscope, etc.
* Contributing ? How to get in touch, etfc.

If you are interested in contributing to our project, please visit
the Contribute [1] page on our website.


Media coverage and events
=========================

    We held our fifth annual Reproducible Builds summit [2] between
    the 1st and 8th December in Marrakesh, Morocco. A full, in-depth
    report will be posted next month?

On November 16th, Vagrant Cascadian presented *There and Back Again,
Reproducibly* [3] at the SeaGL [4] in Seattle, Washington.

Chris Lamb was featured on The Manifest [5] package management
podcast in an episode called *Reproducible Builds project and Debian
package management* [6].

ReScience C [7] is an open-access journal that targets computational
research and encourages the explicit replication of already
published research. This month they announced their *Ten Years
Reproducibility Challenge* [8] which promotes the idea that old code
? in this instance, a "scientific article [published] before January
1st 2010" ? should also run on modern hardware and software in order
to check one can obtain the same scientific results in the future.

 [ 1] https://reproducible-builds.org/contribute/
 [ 2] https://reproducible-builds.org/events/Marrakesh2019/
 [ 3] https://osem.seagl.org/conferences/seagl2019/program/proposals/671
 [ 4] https://seagl.org
 [ 5] https://manifest.fm
 [ 6] https://manifest.fm/14
 [ 7] http://rescience.github.io/
 [ 8] https://rescience.github.io/ten-years/


Upstream news
=============

Mike Hommey pushed a change to Mozilla build system [9] to add and
print error messages when differences are found between builds as
requested in bug #1597903 [10].

There was fresh activity on an old pull request for the OCaml [11]
programming language regarding the usage and adoption of the
BUILD_PATH_PREFIX_MAP environment variable [12] that is used to
ensure that software packages do not embed build-time paths into
generated files. On the pull request [13] in question, Gabriel
Scherer [14] was kind enough to provide many helpful examples on how
to use the rewrite rules [15].

Jan Nieuwenhuizen announced the release of GNU Mes 0.21 [16] and
Jeremiah Orians announced [17] the release of mescc-tools-seed [18]
version 1.1:

> Capable of bootstrapping from a simple hex assembler all the way
> to a cross-platform C compiler  Work is still ongoing [to] result
> in a full bootstrap from a 357 byte bootstrap binary all the way
> to GCC.

Herv? Boutemy [19] announced the release of three base Apache Maven
[20] plugins (source, .jar, and assembly) to get reproducible Builds
as a "direct output" from this build system. For more information,
please see the "Configuring for Reproducible Builds" [21] section of
their documentation.

Eli Schwartz reported a bug against the GNU groff [22] typesetting
system for incomplete SOURCE_DATE_EPOCH [23] environment variable
support; the output files appeared to be embedding the build
timezone [24].

 [ 9] https://hg.mozilla.org/integration/autoland/rev/cd6b79c74b23
 [10] https://bugzilla.mozilla.org/show_bug.cgi?id=1597903
 [11] https://ocaml.org/
 [12] https://reproducible-builds.org/specs/build-path-prefix-map/
 [13] https://github.com/ocaml/ocaml/pull/1515
 [14] http://gallium.inria.fr/~scherer/
 [15] https://github.com/ocaml/ocaml/pull/1515#issuecomment-559035723
 [16] https://lists.reproducible-builds.org/pipermail/rb-general/2019-November/001725.html
 [17] https://lists.reproducible-builds.org/pipermail/rb-general/2019-November/001711.html
 [18] https://github.com/oriansj/mescc-tools-seed
 [19] http://people.apache.org/~hboutemy/
 [20] https://maven.apache.org/
 [21] https://maven.apache.org/guides/mini/guide-reproducible-builds.html
 [22] https://www.gnu.org/software/groff/
 [23] https://reproducible-builds.org/specs/source-date-epoch/
 [24] https://savannah.gnu.org/bugs/?57218


Distribution work
=================

Arch Linux
----------

A slight but temporary decline in the Arch Linux reproducibility
status [25] was determined to be due to a bug in the continuous
integration framework where one build was building with --nocheck
whilst the other did not, resulting in the test dependencies being
installed on one build. This led to differences in the BUILDINFO
file which records the build dependencies.

Morten Linderud (*Foxboron*) wrote a blog post [26] on the progress
of reproducible builds for Arch packages, including how to reproduce
packages and a roadmap of future of work.

The standard Arch development tools package (devtools) now contains
a new tool called makerepropkg which can reproduce a package from
the Arch repositories given a seed PKGBUILD file.

A lot of work has been put into getting the "[core]" system more
reproducible; every package has been rebuilt [27] with a new version
of pacman [28] which resolved a previous issue with storing the
package size. Build failures and download issues have also been
resolved which have lead to an increase of reproducible packages in
this distributions continuous integration setup [29].

 [25] https://tests.reproducible-builds.org/archlinux/archlinux.png
 [26] https://linderud.dev/blog/reproducible-arch-linux-packages/
 [27] https://lists.archlinux.org/pipermail/arch-dev-public/2019-November/029721.html
 [28] https://wiki.archlinux.org/index.php/pacman
 [29] https://tests.reproducible-builds.org/archlinux/archlinux.html

openSUSE
--------

Bernhard M. Wiedemann posted a summary of openSUSE updates for 2019
[30] including rpm, a high level openSUSE status [31] and fixing
problems with .pyc files [32] which is also relevant to Arch Linux.
The report also summarises the current reproducibility statu and
bernhard also published his monthly Reproducible Builds status
update too [33].

 [30] https://lists.reproducible-builds.org/pipermail/rb-general/2019-November/001722.html
 [31] https://bugzilla.opensuse.org/show_bug.cgi?id=1133809
 [32] https://bugzilla.opensuse.org/show_bug.cgi?id=1094323
 [33] https://lists.opensuse.org/opensuse-factory/2019-11/msg00370.html


Debian
------

Thorsten Glaser [34] filed a bug against the debhelper packaging
library [35] to request that it sets and exports a umask [36] of
"022" for all operations as a possible "harmonisation potential". A
varying umask can result in unreproducible packages as the file
permissions on the build system can be embedded into archives
generated by the build system.

Chris Lamb categorised a large number of packages and issues in the
Reproducible Builds "notes [37]" repository, including adding a new
ocaml_dune_captures_build_path toolchain issue [38].

Vagrant Cascadian filed a bug against the Lintian [39] Debian static
analyser for Debian packages to request that it checks for missing
and/or unsigned .buildinfo files [40]. He also uploaded the latest
version [41] of GNU Mes [42] to the *unstable* distribution.

 [34] https://www.mirbsd.org/
 [35] https://bugs.debian.org/944691
 [36] https://en.wikipedia.org/wiki/Umask
 [37] https://salsa.debian.org/reproducible-builds/reproducible-notes/activity
 [38] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/c12c8853
 [39] https://lintian.debian.org/
 [40] https://bugs.debian.org/944707
 [41] https://tracker.debian.org/news/1080851/accepted-mes-020-1-source-amd64-into-experimental-experimental/
 [42] https://www.gnu.org/software/mes/

Other
-----

Natanael Copa (@n_copa) posted on Twitter that he was finally able
to make a fully reproducible package [44] for Alpine Linux [45].

The NixOS [46] distribution announced that they plan to run a
Christmas Hackathon [47] hosted by Smarkets [48] in London, England
on 9th December.

 [44] https://twitter.com/n_copa/status/1192447768855482369
 [45] https://alpinelinux.org/
 [46] https://nixos.org/
 [47] https://www.meetup.com/NixOS-London/events/266848767
 [48] https://smarkets.com/


Software development
====================

Upstream patches
----------------

The Reproducible Builds project detects, dissects and attempts to
fix as many currently-unreproducible packages as possible. We
endeavour to send all of our patches upstream where appropriate.
This month, we wrote a large number of such patches, including:

* Arnout Engelen:

    * OpenSC [49] (generate consistent DocBook [50] identifiers)

       [49] https://github.com/OpenSC/OpenSC/pull/1839
       [50] https://docbook.org

* Bernhard M. Wiedemann:

    * abseil-cpp [51] (sort the output of find/readdir(2))
    * afl [52] (date)
    * brp-check-suse [53] (to strip link-time optimisation (LTO) [54]
      data from .o object files)
    * buzztrax [55] (report a parallelism/nondeterminism issue from
      GTK-Doc [56])
    * cardpeek [57] (fix a previous patch)
    * cecilia [58] (strip date and time in a .png image file)
    * lib3270 [59] (merged; date)
    * maven-plugin-bundle [60] (fix a Java date)
    * nulloy [61] (.zip issue, already filed upstream [62])
    * opencensus-cpp [63] (sort the result of find/readdir(2))
    * OpenSC [64] (generate consistent DocBook [65] identifiers)
    * pcc [66] (fix a build failure from LTO [67] in .a
      archive files)
    * perl-HTTP-Cookies [68] (fix a build failure in 2025)
    * pocl [69] (report compile-time CPU detection)
    * python-oslo.reports [70] (drop unnecessary files
      with randomness)
    * sql-parser [71] (sort find/readdir(2))
    * vim [72] (report a build failure when built
      without parallelism)

    * Various updates to the RPM package manager [73]:
        * #931 [74] ? Keep at least one changelog entry to set
          SOURCE_DATE_EPOCH [75].
        * #933 [76] ? Regression fix so we can override the Build
          Date header again.
        * #936 [77] ? Sort to avoid ordering issues from parallel
          header generation.
        * #944 [78] ? Provide a cleaner solution for bug #936 [79]
          listed above.

       [51] https://build.opensuse.org/request/show/750468
       [52] https://github.com/vanhauser-thc/AFLplusplus/pull/122
       [53] https://github.com/openSUSE/brp-check-suse/pull/29
       [54] https://en.wikipedia.org/wiki/Interprocedural_optimization
       [55] https://github.com/Buzztrax/buzztrax/issues/89
       [56] https://www.gtk.org/gtk-doc/
       [57] https://build.opensuse.org/request/show/746648
       [58] https://build.opensuse.org/request/show/750463
       [59] https://github.com/PerryWerneck/lib3270/pull/3
       [60] https://github.com/apache/felix/pull/209
       [61] https://build.opensuse.org/request/show/746033
       [62] https://github.com/nulloy/nulloy/pull/149
       [63] https://build.opensuse.org/request/show/751817
       [64] https://github.com/OpenSC/OpenSC/pull/1839
       [65] https://docbook.org
       [66] https://build.opensuse.org/request/show/745529
       [67] https://en.wikipedia.org/wiki/Interprocedural_optimization
       [68] https://github.com/libwww-perl/HTTP-Cookies/pull/56
       [69] https://github.com/pocl/pocl/issues/793
       [70] https://review.opendev.org/693327
       [71] https://github.com/hyrise/sql-parser/pull/134
       [72] https://bugzilla.opensuse.org/show_bug.cgi?id=1157623
       [73] https://rpm.org/
       [74] https://github.com/rpm-software-management/rpm/pull/931
       [75] https://reproducible-builds.org/specs/source-date-epoch/
       [76] https://github.com/rpm-software-management/rpm/pull/933
       [77] https://github.com/rpm-software-management/rpm/pull/936
       [78] https://github.com/rpm-software-management/rpm/pull/944
       [79] https://github.com/rpm-software-management/rpm/pull/936

* Chris Lamb:

    * #943954 for against tm-align [81].
    * #943956 for snakemake [83] (forwarded upstream [84]).
    * #944131 for splitpatch [86] (forwarded upstream [87]).
    * #944214 filed against libaqbanking [89].
    * #944520 for isbg [91] (forwarded upstream [92]).
    * #944782 for python-sybil [94] (forwarded upstream [95]).
    * #945105 filed against intel-gpu-tools [97].
    * #945576 filed against superlu-dist [99].
    * #945822 filed against liblopsub [101].
    * genpy [102]

       [81] https://tracker.debian.org/pkg/tm-align
       [83] https://tracker.debian.org/pkg/snakemake
       [84] https://github.com/snakemake/snakemake/pull/80
       [86] https://tracker.debian.org/pkg/splitpatch
       [87] https://github.com/jaalto/splitpatch/pull/8
       [89] https://tracker.debian.org/pkg/libaqbanking
       [91] https://tracker.debian.org/pkg/isbg
       [92] https://github.com/isbg/isbg/pull/139
       [94] https://tracker.debian.org/pkg/python-sybil
       [95] https://github.com/cjw296/sybil/pull/18
       [97] https://tracker.debian.org/pkg/intel-gpu-tools
       [99] https://tracker.debian.org/pkg/superlu-dist
       [101] https://tracker.debian.org/pkg/liblopsub
       [102] https://github.com/ros/genpy/pull/110#event-2768597322

* Vagrant Cascadian:

    * #944694 filed against resource-agents [104] (forwarded
      upstream [105]).

       [104] https://tracker.debian.org/pkg/resource-agents
       [105] https://github.com/ClusterLabs/resource-agents/commit/088707c81b7ddfc117490a035f9f2b2803728694


diffoscope
----------

diffoscope [106] is our in-depth and content-aware diff utility that
can locate and diagnose reproducibility issues. It is run countless
times a day on our testing infrastructure and is essential for
identifying fixes and causes of non-deterministic behaviour.

This month versions 131, 132 and 133 was uploaded to Debian unstable
by Chris Lamb. He also made the following changes:

* New features / improvements:
    * Allow all possible .zip file variations to return from external
      tools with non-zero exit codes, not just known types we can
      identify (e.g. Java .jmod and .jar files). (#78 [107])
    * Limit .dsc and .buildinfo file matching to files in ASCII or
      UTF-8 format. (#77 [108])
    * Bump the previous max_page_size limit from 400 kB to 4 MB.
      [109]
    * Clarify in the HTML and text outputs that the limits are per-
      format, not global. (#944882 [110])
    * Don't use line-based buffering when communicating with
      subprocesses in "binary" mode. (#75 [111])

* Regression fixes:
    * Correct the substitution/filtering of paths in ELF output to
      avoid unnecessary differences depending on the path name
      provided and commandline. (#945572 [112])
    * Silence/correct a Python SyntaxWarning [113] message due to
      incorrectly comparing an integer by identity vs. equality.
      (#945531 [114])

* Testsuite improvements:
    * Refresh the OCaml [115] test fixtures to support versions
      greater than 4.08.1. [116]
    * Update an Android manifest [117] test to reflect that parsed
      XML attributes are returned in a new/sorted manner under
      Python 3.8.  [118]
    * Dramatically Truncate the tcpdump [119] expected diff to 8KB
      from ~600KB to reduce the size of the release tarball. [120]
    * Add a self-test to encourage that new test data files are
      generated dynamically or at least no new ones are added
      without an explicit override. [121]
    * Add a comment that the text_ascii1 and text_ascii2 fixture
      files are used in multiple tests so is not trivial to
      remove/replace them. [122]
    * Drop two more test fixture files for the directory tests.
      [123]
    * Don't run our self-test against the output of the Black source
      code reformatter [124] with versions earlier than "ours" as it
      will generate different results. [125]
    * Update an XML test for Python 3.8. [126]
    * Drop unused an unused BASE_DIR global. [127]

* Code improvements:
    * Rework a long string of or statements into a loop with a
      break. [128]
    * Update code to reflect the latest version of the Black [129]
      source code reformatter. [130]
    * Correct a reference to the .rdx extension suffix in a comment.
      [131]

 [106] https://diffoscope.org
 [107] https://salsa.debian.org/reproducible-builds/diffoscope/issues/78
 [108] https://salsa.debian.org/reproducible-builds/diffoscope/issues/77
 [109] https://salsa.debian.org/reproducible-builds/diffoscope/commit/7d6daf7
 [110] https://bugs.debian.org/944882
 [111] https://salsa.debian.org/reproducible-builds/diffoscope/issues/75
 [112] https://bugs.debian.org/945572
 [113] https://docs.python.org/3/library/exceptions.html#SyntaxWarning
 [114] https://salsa.debian.org/reproducible-builds/diffoscope/commit/ecef7e6
 [115] https://ocaml.org/
 [116] https://salsa.debian.org/reproducible-builds/diffoscope/commit/4754277
 [117] https://developer.android.com/guide/topics/manifest/manifest-intro
 [118] https://salsa.debian.org/reproducible-builds/diffoscope/commit/c01dc80
 [119] https://www.tcpdump.org/
 [120] https://salsa.debian.org/reproducible-builds/diffoscope/commit/9c66d5f
 [121] https://salsa.debian.org/reproducible-builds/diffoscope/commit/1c4b127
 [122] https://salsa.debian.org/reproducible-builds/diffoscope/commit/69a8cc7
 [123] https://salsa.debian.org/reproducible-builds/diffoscope/commit/a0f7a11
 [124] https://black.readthedocs.io/en/stable/
 [125] https://salsa.debian.org/reproducible-builds/diffoscope/commit/aefa5a3
 [126] https://salsa.debian.org/reproducible-builds/diffoscope/commit/06d11dd
 [127] https://salsa.debian.org/reproducible-builds/diffoscope/commit/02497c9
 [128] https://salsa.debian.org/reproducible-builds/diffoscope/commit/477584e
 [129] https://black.readthedocs.io/en/stable/
 [130] https://salsa.debian.org/reproducible-builds/diffoscope/commit/75ea5c3
 [131] https://salsa.debian.org/reproducible-builds/diffoscope/commit/4a00369

Other contributions were also made from:

* Jelle van der Waa:
    * Add support for comparing .zst files created by Zstandard [132]
      compression algorithm. (#34) [133]

* Mattia Rizzolo:
    * Install python3-all whilst running the autopkgtests [134]  as
      we want to run the tests against all supported Python versions.
      [135]
    * Use apt-get instead of apt in our Dockerfile. [136]
    * Add zstd to our test dependencies after the resolution of
      issue #34. [138]

 [132] https://github.com/facebook/zstd
 [133] https://salsa.debian.org/reproducible-builds/issues/34
 [134] https://ci.debian.net/
 [135] https://salsa.debian.org/reproducible-builds/diffoscope/commit/cb74600
 [136] https://salsa.debian.org/reproducible-builds/diffoscope/commit/a5c1364
 [137] https://salsa.debian.org/reproducible-builds/issues/34
 [138] https://salsa.debian.org/reproducible-builds/diffoscope/commit/2c87e96


strip-nondeterminism
--------------------

strip-nondeterminism [139] is our tool to remove specific non-
deterministic results from a completed build. This month, Chris Lamb
added file as a dependency for libfile-stripnondeterminism-perl
(#945212 [140]) and moved away from deprecated $ADTTMP variable [...
[141] and made two uploads in total (1.6.2-1 & 1.6.3-1).

 [139] https://tracker.debian.org/pkg/strip-nondeterminism
 [140] https://bugs.debian.org/945212
 [141] https://salsa.debian.org/reproducible-builds/strip-nondeterminism.git/commit/803d5f9

Project website
---------------

There was yet more effort put into our our website [142] this
month, including:

* Chris Lamb dropped a duplicated use the term "community" and other
  words [143][144], correcting the capitalisation of GitHub [145] &
  GitLab [146] [147] and corrected the use of an "an" [148].

* Daniel Edgecumbe added a section on initramfs and .cpio files
  [149] to our Archive Metadata [150] page. [151]

* Herv? Boutemy added a link to Maven Guide to Configuring for
  Reproducible Builds [152] to our JVM page [153]. [154]

* Jelle van der Waa added Arch Linux [155]-specific links for
  diffoscope [156] and friends to our *Tools* [157] page. [158]

 [142] https://reproducible-builds.org/
 [143] https://salsa.debian.org/reproducible-builds/reproducible-website.git/commit/e390fe4
 [144] https://salsa.debian.org/reproducible-builds/reproducible-website.git/commit/7c14c50
 [145] https://github.com/
 [146] https://gitlab.org/
 [147] https://salsa.debian.org/reproducible-builds/reproducible-website.git/commit/ae47fcd
 [148] https://salsa.debian.org/reproducible-builds/reproducible-website.git/commit/93fc479
 [149] https://reproducible-builds.org/docs/archives/#initramfs-images
 [150] https://reproducible-builds.org/docs/archives/
 [151] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/c584cec
 [152] https://maven.apache.org/guides/mini/guide-reproducible-builds.html
 [153] https://reproducible-builds.org/docs/JVM/
 [154] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/93fd259
 [155] https://archlinux.org/
 [156] https://diffoscope.org/
 [157] https://reproducible-builds.org/docs/tools/
 [158] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/0ca7223


Test framework
---------------

We operate a comprehensive Jenkins [159]-based testing framework that
powers tests.reproducible-builds.org [160]. This month, the following
changes were made:

* Alexander Couzens (OpenWrt [161]): Fix a typo in the kirkwood
  architecture. [162]

* Holger Levsen:

    * Debian:
        * Display newer suites first on pages showing the oldest
          build results. [163]
        * Use the fully qualified-domain name (FQDN) when specifying
          hostnames in our list of offline nodes [164]. [165]
        * Reflect that coccia.debian.org has changed IP address.
          [166]
        * Ignore the Maximum transmission Unit (MTU) [167] on eth0
          when checking for host health. [168]
        * Perform the "/usr merge [169]" variation in the
          *unstable*, *experimental* and *bullseye* distributions
          but not on *buster*. [170]

    * FreeBSD [171]: Upgrade the test VM to FreeBSD 12.1. [172]

    * Arch Linux [173]:
        * Don't fail build jobs if the call to diffoscope --version
          fails; be a bit more verbose in the job output instead.
          [174][175]
        * Attempt to be less error prone when ending schroot [176]
          sessions. [177]

    * OpenWrt [178]:
        * Additionally build the brcm47xx, kirkwood, lantiq,
          mediatek, omap, sunxi and tegra targets. [...
          [179][180]
        * Make build job outputs easier to read and thus understand.
          [181]
        * Include the build target and subtarget in summary
          paragraphs at the top of report pages. [182]
        * Add a reminder to fix the job URL later. [183]

    * Misc:
        * Attempt to fix the PureOS [184] package set. [185]
        * Shorten a "HOWTO" header a tiny bit. [186]
        * Drop hack to fix the clock. [187]
        * Improve a script header; patches are even more welcome
          than bugs! [188]
        * Disable the use of the OpenSSH [189] ControlMaster feature
          to prevent Jenkins [190] killing connections. [191]
        * Make a number of improvements to our boilerplate
          texts/scripts. [192][... [193][... [194]

* Jelle van der Waa: Skip running the Arch Linux [195] tests for
  continuous builds and rebuilds. [196][... [197]

* Mattia Rizzolo:
    * Set the maximum size for HTML pages generated by diffoscope
      [198] to 1MB (current default is 400 KB). [199][200]
    * Update and improve the backup routines for the email relay
      system managing reproducible-builds.org. [201][202]

* Vagrant Cascadian:
    * Ensure OpenSSH [203] authorized_keys files are processed in
      the correct directory regardless of where they are run from.
      [204]
    * Reduce the level of parallelism on armhf architectures with a
      lot of cores to reduce swapping on highly parallel builds,
      additionally ensuring level of parallelism are odd and even
      numbers on the first and second builds respectfully. [205]

 [159] https://jenkins.io/
 [160] https://tests.reproducible-builds.org
 [161] https://openwrt.org/
 [162] https://salsa.debian.org/qa/jenkins.debian.net/commit/369038e3
 [163] https://salsa.debian.org/qa/jenkins.debian.net/commit/aa2ace2f
 [164] https://salsa.debian.org/qa/jenkins.debian.net/blob/HEAD/jenkins-home/offline_nodes
 [165] https://salsa.debian.org/qa/jenkins.debian.net/commit/8266e978
 [166] https://salsa.debian.org/qa/jenkins.debian.net/commit/25964ef8
 [167] https://en.wikipedia.org/wiki/Maximum_transmission_unit
 [168] https://salsa.debian.org/qa/jenkins.debian.net/commit/1a549068
 [169] https://wiki.debian.org/UsrMerge
 [170] https://salsa.debian.org/qa/jenkins.debian.net/commit/a9919410
 [171] https://www.freebsd.org/
 [172] https://salsa.debian.org/qa/jenkins.debian.net/commit/75e87e5d
 [173] https://www.archlinux.org/
 [174] https://salsa.debian.org/qa/jenkins.debian.net/commit/de6dce51
 [175] https://salsa.debian.org/qa/jenkins.debian.net/commit/8ca7241c
 [176] https://wiki.debian.org/Schroot
 [177] https://salsa.debian.org/qa/jenkins.debian.net/commit/32b9fe26
 [178] https://openwrt.org/
 [179] https://salsa.debian.org/qa/jenkins.debian.net/commit/c40b5f5b
 [180] https://salsa.debian.org/qa/jenkins.debian.net/commit/c40b5f5b
 [181] https://salsa.debian.org/qa/jenkins.debian.net/commit/6baae828
 [182] https://salsa.debian.org/qa/jenkins.debian.net/commit/3f67936e
 [183] https://salsa.debian.org/qa/jenkins.debian.net/commit/98c3e2c6
 [184] https://pureos.net/
 [185] https://salsa.debian.org/qa/jenkins.debian.net/commit/c9066d49
 [186] https://salsa.debian.org/qa/jenkins.debian.net/commit/e6494947
 [187] https://salsa.debian.org/qa/jenkins.debian.net/commit/3a7ef746
 [188] https://salsa.debian.org/qa/jenkins.debian.net/commit/ebefdd51
 [189] https://openssh.org/
 [190] https://jenkins.io/
 [191] https://salsa.debian.org/qa/jenkins.debian.net/commit/81273bf4
 [192] https://salsa.debian.org/qa/jenkins.debian.net/commit/c3759e97
 [193] https://salsa.debian.org/qa/jenkins.debian.net/commit/35c2b25f
 [194] https://salsa.debian.org/qa/jenkins.debian.net/commit/2326d159
 [195] https://archlinux.org/
 [196] https://salsa.debian.org/qa/jenkins.debian.net/commit/e16b3ee7
 [197] https://salsa.debian.org/qa/jenkins.debian.net/commit/97145223
 [198] https://diffoscope.org
 [199] https://salsa.debian.org/qa/jenkins.debian.net/commit/0a56df32
 [200] https://salsa.debian.org/qa/jenkins.debian.net/commit/e2ce7d08
 [201] https://salsa.debian.org/reproducible-builds/rb-mailx-ansible/commit/9563162
 [202] https://salsa.debian.org/reproducible-builds/rb-mailx-ansible/commit/734de20
 [203] https://openssh.org/
 [204] https://salsa.debian.org/qa/jenkins.debian.net/commit/0316d461
 [205] https://salsa.debian.org/qa/jenkins.debian.net/commit/620fa54d

The usual node maintenance was performed by Holger Levsen.
[206][207][208][209]

 [206] https://salsa.debian.org/qa/jenkins.debian.net/commit/ec74bdf4
 [207] https://salsa.debian.org/qa/jenkins.debian.net/commit/37d071e5
 [208] https://salsa.debian.org/qa/jenkins.debian.net/commit/06c70874
 [209] https://salsa.debian.org/qa/jenkins.debian.net/commit/c3cd0018


Contributing
============

If you are interested in contributing the Reproducible Builds
project, please visit the Contribute [210] page on our website.
However, you can get in touch with us via:

 * IRC: #reproducible-builds on irc.oftc.net.

 * Twitter: https://twitter.com/ReproBuilds

 * Mailing list: rb-general at lists.reproducible-builds.org [211]

 [210] https://reproducible-builds.org/contribute/
 [211] https://lists.reproducible-builds.org/listinfo/rb-general

This month's report was written by Arnout Engelen, Chris Lamb,
Holger Levsen, Jelle van der Waa, Bernhard M. Wiedemann and Vagrant
Cascadian.  It was subsequently reviewed by a bunch of Reproducible
Builds folks on IRC and the mailing list.


-- 
      o
    ?   ?      Chris Lamb
   o     o     reproducible-builds.org
    ?   ?
      o

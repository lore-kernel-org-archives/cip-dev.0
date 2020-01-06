From: chris@reproducible-builds.org (Chris Lamb)
Date: Mon, 06 Jan 2020 13:39:05 +0000
Subject: [cip-dev] December 2019 in Reproducible Builds
Message-ID: <fc0eb1af-612d-4d3f-b2e9-71d28bba5926@www.fastmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

====================================================================

        o
      ?   ?      December 2019 in Reproducible Builds
     o     o
      ?   ?      https://reproducible-builds.org/reports/2019-12/
        o

====================================================================

  Welcome to the December 2019 report from the Reproducible
  Builds project.

In these reports we outline the most important things that we have
been up to over the past month. As a quick recap, whilst anyone can
inspect the source code of free software for malicious flaws, almost
all software is distributed to end users as pre-compiled binaries.

The motivation behind the reproducible builds effort is to ensure no
flaws have been introduced during this compilation process by
promising identical results are always generated from a given
source, thus allowing multiple third-parties to come to a consensus
on whether a build was compromised.

In this report for December, we cover:

  * Media coverage ? A Google whitepaper, The Update Framework
    graduates within the Cloud Native Computing Foundation, etc.
  * Reproducible Builds Summit 2019 ? What happened at our
    recent meetup?
  * Distribution work ? The latest reports from Arch, Debian and
    openSUSE, etc.
  * Software development ? Patches, patches, patches...
  * Mailing list summary
  * Contact ? How to contribute.

If you are interested in contributing to our project, please visit
the Contribute [1] page on our website.

 [1] https://reproducible-builds.org/contribute/


Media coverage
==============

Google published Binary Authorization for Borg [2], a whitepaper on
how they reduce exposure of user data to unauthorised code as well
as methods for verifying code provenance using their Borg [3])
cluster manager. In particular, the paper notes how they attempt to
limit their "insider risk", ie. the potential for internal personnel
to use organisational credentials or knowledge to perform malicious
activities.

The Linux Foundation [4] announced that The Update Framework [5]
(TUF) has graduated within [6] the Cloud Native Computing Foundation
(CNCF) and thus becomes the first specification and first security-
focused project to reach the highest maturity level in that group.
TUF is a technology that secures software update systems initially
developed by Justin Cappos [8] at the NYU Tandon School of
Engineering [9].

Andrew "bunnie" Huang published a blog post asking "Can We Build
Trustable Hardware?" [11]. Whilst it concludes pessimistically that
"open hardware is precisely as trustworthy as closed hardware" it
does mention that reproducible builds can:

> Enable any third-party auditor to download, build, and confirm
> that the program a user is downloading matches the intent of the
> developers.

At the 36th Chaos Communication Congress [12] (36C3) in Leipzig,
Hannes Mehnert from the MirageOS [13] project gave a presentation
called *Leaving legacy behind* [14] which talks generally about
*Mirage* system offering a potential alternative and minimalist
approach to security but has a section on reproducible builds (at
38m41s.

 [ 2] https://cloud.google.com/security/binary-authorization-for-borg/
 [ 3] https://en.wikipedia.org/wiki/Borg_(cluster_manager
 [ 4] https://www.linuxfoundation.org/
 [ 5] https://theupdateframework.io/
 [ 6] https://www.cncf.io/announcement/2019/12/18/cloud-native-computing-foundation-announces-tuf-graduation/
 [ 8] https://engineering.nyu.edu/faculty/justin-cappos
 [ 9] https://engineering.nyu.edu/
 [11] https://www.bunniestudios.com/blog/?p=5706
 [12] https://events.ccc.de/congress/2019/wiki/index.php/Main_Page
 [13] https://mirage.io/
 [14] https://media.ccc.de/v/36c3-11172-leaving_legacy_behind


Reproducible Builds Summit 2019
===============================

We held our fifth annual Reproducible Builds summit [16] between the
1st and 8th December at Priscilla, Queen of the Medina [17] in
Marrakesh, Morocco.

The aim of the meeting was to spend time dicussing and working on
Reproducible Builds with a widely diverse agenda and the event was a
huge success.

During our time together, we updated and exchanged the status of
reproducible builds in our respective projects, improved
collaboration between and within these efforts, expanded the scope
and reach of reproducible builds to yet more interested parties,
established and continued strategic long-term thinking in a way not
typically possible via remote channels, and brainstormed designs for
tools to enable end- users to get the most benefit from reproducible
builds.

Outside of these achievements in the hacking sessions kpcyrd made
a breakthrough in Alpine Linux [18] by producing the first
reproducible package ? specifically, py3-uritemplate [19] ? in this
operating system. After this, progress was accelerated and by the
denouement of our meeting the reproducibility status in Alpine
reached 94%. In addition, Jelle van der Waa, Mattia Rizzolo and Paul
Spooren discussed and implemented substantial changes to the
database that underpins the testing framework that powers
tests.reproducible-builds.org in order to abstract the schema in a
distribution agnostic way, for example to allow submitting the
results of attempts to verify officially distributed Arch Linux
packages.

Lastly, Jan Nieuwenhuizen, David Terry and Vagrant Cascadian used
three entirely-separate distributions (GNU Guix, NixOS and Debian)
to produce a bit-for-bit identical GNU Mes [26] binary despite using
three different major versions of GCC and other toolchain components
to build an initial binary, which was then used to build a final,
bit-for-bit identical, binary of Mes.

The event was held at Priscilla, Queen of the Medina [27] in
Marrakesh, a location ?sui generis? that stands for gender equality,
female empowerment and the engagement of vulnerable communities
locally through cultural activism. The event was open to anybody
interested in working on Reproducible Builds issues, with or without
prior experience.

A number of reports and blog posts have already been written,
including for:

  * openSUSE [28]
  * OCaml, "opam" and MirageOS [29]
  * GNU Guix [30]

 [16] https://reproducible-builds.org/events/Marrakesh2019/
 [17] https://www.queenscollective.org/artistryasactivism
 [18] https://alpinelinux.org/
 [19] https://tests.reproducible-builds.org/alpine/main/py3-uritemplate/py3-uritemplate-3.0.0-r4.apk.html
 [26] https://www.gnu.org/software/mes/
 [27] https://www.queenscollective.org/artistryasactivism
 [28] https://lizards.opensuse.org/2019/12/13/opensuse-on-reproducible-builds-summit/
 [29] https://hannes.nqsb.io/Posts/ReproducibleOPAM
 [30] https://guix.gnu.org/blog/2019/reproducible-builds-summit-5th-edition/


Distribution work
=================

Within Debian, Chris Lamb categorised a large number of packages and
issues in the Reproducible Builds notes.git [34] repository, including
identifying and creating markdown_random_email_address_html_entities
and nondeterministic_devhelp_documentation_generated_by_gtk_doc.

 [34] https://salsa.debian.org/reproducible-builds/reproducible-notes/activity

In openSUSE, Bernhard published his monthly Reproducible Builds
status update [38] and filed the following patches:

  * hidviz [39] (use convert -strip)
  * python-ipydatawidgets [40] (make pip install reproducible,
    avoid trouble with Zip order & mtime [41])
  * python-jupyterlab-templates [42] (make pip install
    reproducible)
  * python-jupyterlab [43] (make pip install reproducible)
  * python-mox3 [44] (drop Sphinx [45] environment.pickle file)
  * rpmlint-mini [46] (sort Python compile file list)
  * rubygem-ronn [47] ( Ruby date,  submitted upstream [48] with
    updated patch)
  * syslinux6 [49] (sort find / readdir; already upstream)

Bernhard also filed bugs against:

  * libhugetlbfs [50] (unreproducible .ldscript file)
  * libmicro [51] (Link-Time Optimisation [52] causing
    unreproducible object files; fix by Martin Pluskal [53])
  * python-swifter [54] (report failure to build on single-core CUPs)
  * tesseract-ocr [55] (report variations via their build
    machine's CPU)

 [38] https://lists.opensuse.org/opensuse-factory/2019-12/msg00174.html
 [39] https://build.opensuse.org/request/show/754485
 [40] https://build.opensuse.org/request/show/760182
 [41] https://en.wikipedia.org/wiki/Mtime
 [42] https://build.opensuse.org/request/show/757375
 [43] https://build.opensuse.org/request/show/755664
 [44] https://build.opensuse.org/request/show/760190
 [45] http://www.sphinx-doc.org/
 [46] https://build.opensuse.org/request/show/754705
 [47] https://build.opensuse.org/request/show/757287
 [48] https://github.com/kamontat/ronn/pull/3
 [49] https://build.opensuse.org/request/show/759820
 [50] https://bugzilla.opensuse.org/show_bug.cgi?id=1159558
 [51] https://bugzilla.opensuse.org/show_bug.cgi?id=1159556
 [52] https://en.wikipedia.org/wiki/Interprocedural_optimization
 [53] https://build.opensuse.org/request/show/758238
 [54] https://bugzilla.opensuse.org/show_bug.cgi?id=1158578
 [55] https://bugzilla.opensuse.org/show_bug.cgi?id=1159231


The Yocto Project announced that it is running continuous tests on
the reproducibility of its output [57] which can observed through
the oe-selftest runs on their build server [58]. This was previously
limited to just the mini images but this has now been extended to
the larger graphical images. The test framework is available for end
users to use against their own builds.

Of particular interest is the production of binary identical results
despite arbitrary build paths to allow more efficient builds
through reuse of previously built objects, a topic covered in
more-depth in a recent LWN article [59].

 [56] https://www.yoctoproject.org/
 [57] http://git.yoctoproject.org/cgit.cgi/poky/tree/meta/lib/oeqa/selftest/cases/reproducible.py
 [58] https://autobuilder.yoctoproject.org/typhoon/#/console
 [59] https://lwn.net/Articles/804640/

In Arch Linux, the database structure on tests.reproducible-
builds.org  was changed and the testing jobs updated to match and
work has been started on a verification test job which rebuilds the
officially released packages and verifies if they are reproducible
or not. In the "hacking" time after our recent summit, several key
packages were made reproducible, raising the amount of reproducible
packages by approximately 1.5%. For example libxslt [62] was patched
with the patch originating from Debian and openSUSE.

 [62] https://www.archlinux.org/packages/extra/x86_64/libxslt/


Software development
====================

diffoscope
----------

diffoscope [64] is our in-depth and content-aware diff-like utility
that can locate and diagnose reproducibility issues. It is run
countless times a day on our testing infrastructure [65] and is
essential for identifying fixes and causes of non-deterministic
behaviour.

This month, diffoscope version 134 was uploaded to Debian unstable
by Chris Lamb. He also made the following changes to diffoscope
itself, including:

  * Always pass a filename with a .zip extension to zipnote
    otherwise it will return with an UNIX exit code [66] of 9 and we
    fallback to displaying a binary difference for the entire file.
    [67]
  * Include the libarchive [68] file listing for ISO images to
    ensure that timestamps ? and not just dates ? are visible in
    any difference. [69]
  * Ensure that our autopkgtests [70] are run with our
    pyproject.toml [71] present for the correct black source code
    formatter settings. [72]
  * Rename the text_option_with_stdiout test to
    text_option_with_stdout [73] and tidy some unnecessary boolean
    logic in the ISO9660 tests [75].

 [64] https://diffoscope.org
 [65] https://tests.reproducible-builds.org/debian/reproducible.html
 [66] https://en.wikipedia.org/wiki/Exit_status
 [67] https://salsa.debian.org/reproducible-builds/diffoscope/commit/a93aa33
 [68] https://www.libarchive.org/
 [69] https://salsa.debian.org/reproducible-builds/diffoscope/issues/81
 [70] https://ci.debian.net/
 [71] https://snarky.ca/clarifying-pep-518/
 [72] https://bugs.debian.org/945993
 [73] https://salsa.debian.org/reproducible-builds/diffoscope/commit/cb1c732

In addition, Eli Schwartz fixed an error in the handling of the
progress bar [76] and Vagrant Cascadian added external tool
reference for the zstd [77] compression format for GNU Guix [79] as
well as updated the version to 133 in that distribution [80][81].

 [75] https://salsa.debian.org/reproducible-builds/diffoscope/commit/341b98a
 [76] https://salsa.debian.org/reproducible-builds/diffoscope/commit/8706b87
 [77] https://github.com/facebook/zstd
 [79] https://salsa.debian.org/reproducible-builds/diffoscope/commit/8c1b357
 [80] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=6a65185ee46babca0630db1d64eaa8c1447d1cd6
 [81] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=5de06b9dfb7e8fa5e32187d6a118cfeb04eff0a3


Project website & documentation
-------------------------------

There was more work performed on our website this month,
including:

* Bernhard M. Wiedemann:

    * Add an OCaml example to our SOURCE_DATE_EPOCH
      documentation [84] and simplify the POSIX shell and date
      format usage [85][86]
    * Add a few "logo only" variations of our logo. [87]

* Chris Lamb:

    * Add a link to the Tails [88] privacy-related operating
      system's instructions on how to verify a downloaded
      image. [90]

    * Add a link to the Reproducible Builds subreddit [91] to the
      page footer. [92]

    * Correct a "name" typo [93], add a missing "to" [94]
      and correct capitalisations of "OCaml" throughout the
      site [95].

* Jelle van der Waa:

    * Update the GNU Guix logo to the new design. [97]
    * Fix "signed tarballs are available" link on our Tools [98]
      page. [99]

* Mattia Rizzolo:

    * Add an explicit robots.txt [100] file. [101]

    * Add a Google "site verification" [102] token. (Also added to
      the diffoscope website). [104][105]

 [88] https://tails.boum.org/
 [90] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/fed9dea
 [91] https://www.reddit.com/r/reproduciblebuilds/
 [92] https://salsa.debian.org/reproducible-builds/reproducible-website/issues/20
 [93] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/f0840a1
 [94] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/024b8cd
 [95] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/3b9b869
 [97] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/87bb32e
 [98] https://reproducible-builds.org/docs/jvm/
 [99] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/870fbbe
 [100] https://www.robotstxt.org/
 [101] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/63253b6
 [102] https://support.google.com/webmasters/answer/9008080?hl=en
 [104] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/1b9ad40
 [105] https://salsa.debian.org/reproducible-builds/diffoscope-website/commit/875ea3d

In addition, Paul Spooren added a new page overviewing our
Continuous Tests [106] overview [107], Herv? Boutemy made a number
of improvements to our Java and JVM documentation [108] expanding
and clarifying various definitions as well as adding external links
[109][110][111][112] and Mariana Moreira added a .jekyll-cache entry
to the .gitignore file [114].

 [106] https://reproducible-builds.org/citests/
 [107] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/1c19f5c
 [108] https://reproducible-builds.org/docs/jvm/
 [109] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/79a6937
 [110] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/938e970
 [111] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/f396daa
 [112] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/fde8e54
 [114] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/eb51a49


Upstream patches
----------------

The Reproducible Builds project detects, dissects and attempts to
fix as many currently-unreproducible packages as possible. We
endeavour to send all of our patches upstream where appropriate.
This month, we wrote a large number of such patches, including:

* Arnout Engelen:

    * sbt [115] (timestamps and file order in generated archives)
    * NixOS [116] installer/iso-image [117] (timestamps in ISO
      installer image)
    * Generated an updated NixOS reproducibility report [118] for
      nixos-unstable's iso_minimal installer image.

* Bernhard M. Wiedemann:

    * bowtie [119] (date)
    * charybdis [120] (shell date & time)
    * coq [121] (report that .vo files vary from build order)
    * coq [122] (OCaml date)
    * kismet [123] (date)
    * libcec [124] (CMake: use TIMESTAMP variable instead of
      build date)
    * lifelines [125] (date)
    * OpenStack Python packages [126] (don't package a .pickle file)
    * orthanc [127] (sort Python readdir)
    * perl [128] (fix documentation-related build failure in 2020)
    * php7-pear [129] (sort a PHP-based readdir)
    * pmix [130] (date, time, host & user)
    * pw3270 [131] (make date & convert -strip)
    * python-autobahn [132] (report stuck tests on single
      CPU machine)
    * python-psychtoolbox [133] (sort Python readdir)
    * python-python-crfsuite [134] (sort Python glob [135]
      / readdir)
    * ripgrep [136] (report variations from CPU)
    * rubygem-ronn [137] (updated date patch)
    * vpp [138] (shell date, regression fix)
    * Multiple patches to the grass  Geographic
      Information System. [140][141][142]

* Jelle van der Waa:

    * tbb [143] (hostname, date & time)
    * pcp [144] (date & time)
    * libcec [145] (date & time)
    * cgdb [146] (date & time)
    * cloc [147] (date & time)
    * dlang [148] (please add support SOURCE_DATE_EPOCH in the D
      programming language [149] compiler, dlang)
    * dlang [150] (date & time in the D dtools library)

* Chris Lamb:

    * #857454 re-opened against qtltools
    * #946315 filed against infernal (forwarded
      upstream [155]).
    * #946330 filed against usb-modeswitch-data
      (applied upstream).
    * #946331 filed against gtk-doc (forwarded
      upstream [160]).
    * #946332 filed against nftables.
    * #946333 filed against node-chart.js (forwarded
      upstream [165]).
    * #946335 filed against parsinsert.
    * #947608 filed against markdown.
    * #947708 filed against libtext-markdown-perl.


 [115] https://github.com/sbt/sbt/pull/5344
 [116] https://github.com/NixOS/nixpkgs/pulls?q=is%3Apr+label%3A%226.topic%3A+reproducible+builds%22+is%3Aclosed
 [117] https://github.com/NixOS/nixpkgs/pull/75484
 [118] https://arnout.engelen.eu/nixos-r13y/report/
 [119] https://github.com/BenLangmead/bowtie/pull/99
 [120] https://github.com/charybdis-ircd/charybdis/pull/297
 [121] https://github.com/coq/coq/issues/11229
 [122] https://github.com/coq/coq/pull/11227
 [123]  https://github.com/kismetwireless/kismet/pull/195
 [124] https://github.com/Pulse-Eight/libcec/pull/487
 [125] https://github.com/lifelines/lifelines/pull/389
 [126] https://review.opendev.org/700810
 [127] https://bitbucket.org/sjodogne/orthanc/pull-requests/12/sort-file-lists/diff
 [128] https://github.com/Perl/perl5/pull/17390
 [129] https://github.com/pear/pear-core/pull/105
 [130] https://github.com/openpmix/openpmix/pull/1560
 [131] https://github.com/PerryWerneck/pw3270/pull/2
 [132] https://github.com/crossbario/autobahn-python/issues/1275
 [133] https://github.com/Psychtoolbox-3/Psychtoolbox-3/pull/614
 [134] https://github.com/scrapinghub/python-crfsuite/pull/115
 [135] https://docs.python.org/3/library/glob.html
 [136] https://github.com/BurntSushi/ripgrep/issues/1441
 [137] https://github.com/kamontat/ronn/pull/3
 [138] https://gerrit.fd.io/r/c/vpp/+/23819
 [140] https://github.com/OSGeo/grass/pull/247
 [141] https://github.com/OSGeo/grass/pull/251
 [142] https://github.com/OSGeo/grass/pull/263
 [143] https://github.com/intel/tbb/issues/202
 [144] https://github.com/performancecopilot/pcp/pull/805
 [145] https://github.com/Pulse-Eight/libcec/issues/485
 [146] https://github.com/cgdb/cgdb/pull/215
 [147] https://github.com/AlDanial/cloc/pull/438
 [148] https://issues.dlang.org/show_bug.cgi?id=20444
 [149] https://dlang.org/
 [150] https://issues.dlang.org/show_bug.cgi?id=20445
 [155] https://github.com/EddyRivasLab/infernal/pull/19
 [160] https://gitlab.gnome.org/GNOME/gtk-doc/merge_requests/37
 [165] https://github.com/chartjs/Chart.js/pull/6817


Test framework
--------------

We operate a comprehensive Jenkins-based testing framework that
powers tests.reproducible-builds.org. This month, the following
changes were made:

* Holger Levsen:

    * Alpine:

        * Indicate where Alpine is being built on the node overview
          page. [175]
        * Turn off debugging output. [176]
        * Sleep longer if no packages are to be built. [177]

    * Misc:

        * Add some help text to our script to powercycle IONOS [178]
          (*ne?* Profitbricks) nodes. [179]
        * Install mosh [180] everywhere. [181]
        * Only install ripgrep [182] on Debian nodes. [183]

* Mattia Rizzolo:

    * Arch Linux:

        * Normalise the suite names in the database.
          [185][186][187][188][189]
        * Drop an unneeded line in the scheduler. [190]

    * Debian:

        * Fix a number of SQL errors. [192][193][...
          [194][195]
        * Use the debian.debian_support Python library over apt_pkg
          to perform version comparisons. [196]

    * Misc:

        * Permit other distributions to use our web-based package
          scheduling script. [197
        * Reformat our power-cycling script using Black [198] and
          use the Python logging [199] module. [200]
        * Introduce a dsources database view to simplify some
          queries [201] and add a build_type field to support both
          "doublerebuilds" and verification rebuilds [202].
        * Move (almost) all the timestamps in the database schema
          from raw strings to "real" timestamp data types. [203]
        * Only block bots on jenkins.debian.net [204] and
          tests.reproducible-builds.org [205], not any other sites.
          [206]

* kpcyrd (for Alpine Linux):

    * Patch/install the abuild utility to one that is reproducible.
      [208][209][210][211]
    * Bump the number of build workers and collect garbage more
      frequently. [212][213][214][215]
    * Classify and display build results consistently.
      [216][217][218]
    * Ensure that tmux [219] and ripgrep [220] is installed.
      [221][222]
    * Support building packages in the future. [223][224][225]

 [175] https://salsa.debian.org/qa/jenkins.debian.net/commit/4af96f16
 [176] https://salsa.debian.org/qa/jenkins.debian.net/commit/6a461023
 [177] https://salsa.debian.org/qa/jenkins.debian.net/commit/f1d3c700
 [178] https://www.ionos.com/
 [179] https://salsa.debian.org/qa/jenkins.debian.net/commit/23442fc2
 [180] https://mosh.org/
 [181] https://salsa.debian.org/qa/jenkins.debian.net/commit/25e3d43b
 [182] https://github.com/BurntSushi/ripgrep
 [183] https://salsa.debian.org/qa/jenkins.debian.net/commit/f3a3ce6b
 [185] https://salsa.debian.org/qa/jenkins.debian.net/commit/7a0295e8
 [186] https://salsa.debian.org/qa/jenkins.debian.net/commit/231884e8
 [187] https://salsa.debian.org/qa/jenkins.debian.net/commit/62750403
 [188] https://salsa.debian.org/qa/jenkins.debian.net/commit/d8473a13
 [189] https://salsa.debian.org/qa/jenkins.debian.net/commit/77d3b173
 [190] https://salsa.debian.org/qa/jenkins.debian.net/commit/035f6170
 [192] https://salsa.debian.org/qa/jenkins.debian.net/commit/cd4ee15d
 [193] https://salsa.debian.org/qa/jenkins.debian.net/commit/e380dad1
 [194] https://salsa.debian.org/qa/jenkins.debian.net/commit/8c515b2d
 [195] https://salsa.debian.org/qa/jenkins.debian.net/commit/528f3bce
 [196] https://salsa.debian.org/qa/jenkins.debian.net/commit/7677b378
 [197] https://salsa.debian.org/qa/jenkins.debian.net/commit/cb775560
 [198] https://black.readthedocs.io/
 [199] https://docs.python.org/3/library/logging.html
 [200] https://salsa.debian.org/qa/jenkins.debian.net/commit/325b9f57
 [201] https://salsa.debian.org/qa/jenkins.debian.net/commit/95eb84e6
 [202] https://salsa.debian.org/qa/jenkins.debian.net/commit/86160814
 [203] https://salsa.debian.org/qa/jenkins.debian.net/commit/6e7a475c
 [204] https://jenkins.debian.net/
 [205] http://tests.reproducible-builds.org/
 [206] https://salsa.debian.org/qa/jenkins.debian.net/commit/e09cda74
 [208] https://salsa.debian.org/qa/jenkins.debian.net/commit/3b55b4d3
 [209] https://salsa.debian.org/qa/jenkins.debian.net/commit/b4cfe3d3
 [210] https://salsa.debian.org/qa/jenkins.debian.net/commit/2d81fa1a
 [211] https://salsa.debian.org/qa/jenkins.debian.net/commit/6c3c15e0
 [212] https://salsa.debian.org/qa/jenkins.debian.net/commit/35a3dd33
 [213] https://salsa.debian.org/qa/jenkins.debian.net/commit/a97cb13c
 [214] https://salsa.debian.org/qa/jenkins.debian.net/commit/83cc9dca
 [215] https://salsa.debian.org/qa/jenkins.debian.net/commit/30138aa1
 [216] https://salsa.debian.org/qa/jenkins.debian.net/commit/21026d76
 [217] https://salsa.debian.org/qa/jenkins.debian.net/commit/70a8fe35
 [218] https://salsa.debian.org/qa/jenkins.debian.net/commit/9eeb3a5a
 [219] https://tmux.github.io/
 [220] https://github.com/BurntSushi/ripgrep
 [221] https://salsa.debian.org/qa/jenkins.debian.net/commit/332f2549
 [222] https://salsa.debian.org/qa/jenkins.debian.net/commit/3b43b4f9
 [223] https://salsa.debian.org/qa/jenkins.debian.net/commit/912f3126
 [224] https://salsa.debian.org/qa/jenkins.debian.net/commit/71380c9a
 [225] https://salsa.debian.org/qa/jenkins.debian.net/commit/5ee25a02

Lastly, Paul Spooren removed the project overview from the
bottom-left of the generated pages [226] and the usual node
maintenance was performed by Holger Levsen [227] and Mattia Rizzolo
[228][229], etc.

 [226] https://salsa.debian.org/qa/jenkins.debian.net/commit/23eb5845
 [227] https://salsa.debian.org/qa/jenkins.debian.net/commit/dea04259
 [228] https://salsa.debian.org/qa/jenkins.debian.net/commit/7587e568
 [229] https://salsa.debian.org/qa/jenkins.debian.net/commit/6d8111ce


Mailing list summary
====================

There was considerable activity on our mailing list [230] this month.

Firstly, Bernhard M. Wiedemann posted a thread asking "What is the
goal of reproducible builds?" [231] in order to encourage
refinements, extra questions and other contributions to what an
end-user experience of reproducible builds should or even could look
like.

Eli Schwartz then resurrected a previous thread titled "Progress in
rpm and openSUSE in 2019" [232] to clarify some points around Arch
Linux and Python package installation. Hans-Christoph Steiner
followed- up to a separate thread [234] originally started by Herv?
Boutemy announcing the status of .buildinfo file support in the Java
ecosystem, and Paul Spooren then informed the list [235] that Google
Summer of Code is now looking for projects for the latest cohort.

Lastly, Lars Wirzenius enquired about the status of Reproducible system
images [237] which resulted in a large number of responses [238].

 [230] https://lists.reproducible-builds.org/listinfo/rb-general/
 [231] https://lists.reproducible-builds.org/pipermail/rb-general/2019-December/001732.html
 [232] https://lists.reproducible-builds.org/pipermail/rb-general/2019-December/001741.html
 [234] https://lists.reproducible-builds.org/pipermail/rb-general/2019-December/001744.html
 [235] https://lists.reproducible-builds.org/pipermail/rb-general/2019-December/001743.html
 [237] https://lists.reproducible-builds.org/pipermail/rb-general/2019-December/001750.html
 [238] https://lists.reproducible-builds.org/pipermail/rb-general/2019-December/thread.html#1750


Contact
=======

If you are interested in contributing to the Reproducible Builds
project, please visit the "Contribute" page on our website:

   https://reproducible-builds.org/contribute/

However, you can get in touch with us via:

 * IRC: #reproducible-builds on irc.oftc.net.
 * Twitter: https://twitter.com/@ReproBuilds
 * Reddit: https://reddit.com/r/reproduciblebuilds
 * Mailing list: https://lists.reproducible-builds.org/listinfo/rb-general

This month's report was written by Arnout Engelen, Bernhard M.
Wiedemann, Chris Lamb, Herv? Boutemy, Holger Levsen, Jelle van der
Waa, Lukas Puehringer and Vagrant Cascadian. It was subsequently
reviewed by a bunch of Reproducible Builds folks on IRC and the
mailing list.


-- 
      o
    ?   ?      Chris Lamb
   o     o     reproducible-builds.org
    ?   ?
      o

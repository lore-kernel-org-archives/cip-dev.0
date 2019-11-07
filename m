From: chris@reproducible-builds.org (Chris Lamb)
Date: Thu, 07 Nov 2019 10:52:24 -0800
Subject: [cip-dev] October 2019 in Reproducible Builds
Message-ID: <1c647bb3-9271-4ae3-b60e-59daa8edcd5e@www.fastmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

====================================================================

        o
      ?   ?      October 2019 in
     o     o     Reproducible Builds
      ?   ?
        o        https://reproducible-builds.org/reports/2019-10/

====================================================================

Welcome to the October 2019 report from the Reproducible Builds
project. :)

In our monthly reports we attempt outline the most important things
that we have been up to recently. As a reminder on what our little
project is all about, whilst anyone can inspect the source code of
free software for malicious changes most software is distributed to
end users or servers as precompiled binaries. Reproducible builds
tries to ensure that no changes have been made during these
compilation processes by promising identical results are always
generated from a given source, allowing multiple third-parties to
come to a consensus on whether a build was compromised.

In this month's report, we will cover:

 * Media coverage & conferences ? Reproducible builds in Belfast
   & science
 * Reproducible Builds Summit 2019 ? Registration & attendees, etc.
 * Distribution work ? The latest work in Debian, OpenWrt, openSUSE,
   and more...
 * Software development ? More diffoscope development, etc.
 * Getting in touch ? How to contribute & get in touch

If you are interested in contributing to our venture, please visit our
*Contribute* page on our website.


Media coverage & conferences
============================

Jonathan McDowell [2] gave an introduction on Reproducible Builds in
Debian [3] at the Belfast Linux User Group.

Whilst not strictly related to reproducible *builds*, Sean Gallagher
from Ars Technica wrote an article entitled *Researchers find bug in
Python script may have affected hundreds of studies* [6]:

> A programming error in a set of Python scripts commonly used for
> computational analysis of chemistry data returned varying results based
> on which operating system they were run on.

 [ 2] https://www.earth.li/~noodles/
 [ 3] https://www.meetup.com/belfast-lug/events/264951460/
 [ 6] https://arstechnica.com/information-technology/2019/10/chemists-discover-cross-platform-python-scripts-not-so-cross-platform/


Reproducible Builds Summit 2019
===============================

Registration for our fifth annual Reproducible Builds summit that
will take place between the 1st and 8th December in Marrakesh,
Morocco has opened and invitations have been sent out.

Similar to previous incarnations of the event, the heart of the
workshop will be three days of moderated sessions with surrounding
"hacking" days and will include a huge diversity of participants
from Arch Linux, coreboot, Debian, F-Droid, GNU Guix, Google,
Huawei, in-toto, MirageOS, NYU, openSUSE, OpenWrt, Tails, Tor
Project and many more. We are still seeking additional sponsorship
for the event. Sponsoring enables us to enable the attendance of
people who would not otherwise be able to attend. If you or your
company would be able to sponsor the event, please contact
<info@reproducible-builds.org>.

If you would like to learn more about the event and how to register,
please visit our dedicated event page:

  https://reproducible-builds.org/events/Marrakesh2019/


Distribution work
=================

GNU Guix [10] announced that they had significantly reduced the size
of their "bootstrap seed" [11] by replacing binutils [12], GCC [13]
and glibc [14] with smaller alternatives resulting in the package
manager "possessing a formal description of how to build all
underlying software" in a reproducible way from a mere 120MB seed.

OpenWrt [15] is a Linux-based operating system targeting wireless
network routers and other embedded devices. This month Paul Spooren
(*aparcar*) posted a patch to their mailing list adding KCFLAGS to
the kernel build flags [16] to make it easier to rebuild the
official binaries.

Bernhard M. Wiedemann posted his monthly Reproducible Builds status
update [17] for the openSUSE [18] distribution which describes how
rpm was updated [19] to run most builds with the -flto=auto
argument, saving mirror disk space/bandwidth. In addition,
maven-javadoc-plugin received a toolchain patch [20] (originating
from Debian [21]) in order to normalise a date.

 [10] http://guix.gnu.org/
 [11] https://guix.gnu.org/blog/2019/guix-reduces-bootstrap-seed-by-50/
 [12] https://en.wikipedia.org/wiki/GNU_Binutils
 [13] https://gcc.gnu.org/
 [14] https://www.gnu.org/software/libc/
 [15] https://openwrt.org/
 [16] https://lists.infradead.org/pipermail/openwrt-devel/2019-October/019248.html
 [17] https://lists.opensuse.org/opensuse-factory/2019-10/msg00367.html
 [18] https://opensuse.org/
 [19] https://build.opensuse.org/request/show/732635
 [20] https://build.opensuse.org/request/show/735873


?

   ,''`.
  : :'  :
  `. `'`
    `-

In Debian this month Didier Raboud (*OdyX*) started a discussion on
the debian-devel [22] mailing list regarding building Debian source
packages in a reproducible manner (thread index at [23]). In
addition, Lukas P?hringer prepared an upload of in-toto [24], a
framework to protect supply chain integrity by the Secure Systems
Lab [25] at New York University [26] which was uploaded by Holger
Levsen.

Holger Levsen started a new section on the Debian wiki [27] to
centralise to document the progress made on various Debian-specific
reproducibility issues [28] and noticed that the "essential" package
set in the *bullseye* distribution [29] became unreproducible again,
likely due to a a bug in Perl [30] itself. Holger also restarted a
discussion [31] on Debian bug #774415 [32] which requests that the
devscripts collection of utilities that "make the life of a Debian
package maintainer easier" adds a script/wrapper to enable easier
end-user testing of whether a package is reproducible.

Johannes Schauer (*josch*) explained that their mmdebstrap [33] tool
can create bit-for-bit identical [34] Debian chroots [35] of the
*unstable* and *buster* distributions for both the essential and
minbase bootstrap "variants" [36], and Bernhard M. Wiedemann
contributed to a discussion [37] regarding adding a "global" build
switch to enable/disable Profile-Guided Optimisation [38] (PGO) and
Link-time optimisation [39] in the dpkg-buildflags tool, nothing
that "overall it is still very hard to get reproducible builds with
PGO enabled."

64 reviews of Debian packages were added, 10 were updated and 35
were removed this month adding to our knowledge about identified
issues[40].  Three new types were added by Chris Lamb (*lamby*):
nondeterministic_output_in_code_generated_by_ros_genpy [41],
nondeterministic_ordering_in_include_graphs_generated_by_doxygen[42]
& nondeterministic_defaults_in_documentation_generated_by_pyth-
on_traitlets [43].

Lastly, there was a far-reaching discussion regarding the
correctness and suitability of setting the TZ environment variable
[44] to UTC when it was noted that the value UTC0 [45] was
"technically" more correct.

 [21] https://salsa.debian.org/java-team/maven-javadoc-plugin/blob/master/debian/patches/reproducible-footer.patch
 [22] https://lists.debian.org/debian-devel/
 [23] https://lists.debian.org/debian-devel/2019/10/threads.html#00301
 [24] https://in-toto.io/
 [25] https://ssl.engineering.nyu.edu/
 [26] https://engineering.nyu.edu/
 [27] https://wiki.debian.org/
 [28] https://wiki.debian.org/ReproducibleBuilds#Solved_issues
 [29] https://tests.reproducible-builds.org/debian/buster/amd64/pkg_set_essential.html
 [30] https://bugs.debian.org/791362
 [31] https://bugs.debian.org/774415#270
 [32] https://bugs.debian.org/774415
 [33] https://tracker.debian.org/mmdebstrap
 [34] https://lists.debian.org/debian-devel/2019/10/msg00101.html
 [35] https://en.wikipedia.org/wiki/Chroot
 [36] https://sources.debian.org/src/debootstrap/1.0.116/debootstrap.8/#L78-L85
 [37] https://bugs.debian.org/940571#26
 [38] https://en.wikipedia.org/wiki/Profile-guided_optimization
 [39] https://en.wikipedia.org/wiki/Interprocedural_optimization
 [40] https://tests.reproducible-builds.org/debian/index_issues.html
 [41] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/d219f18a
 [42] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/25771b7c
 [43] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/3ecdc853
 [44] https://en.wikipedia.org/wiki/Environment_variable#Unix_2
 [45] https://lists.reproducible-builds.org/pipermail/rb-general/2019-October/001697.html


Software development
====================

Upstream patches
----------------

The Reproducible Builds project detects, dissects and attempts to
fix as many currently-unreproducible packages as possible. We
endeavour to send all of our patches upstream where appropriate.
This month, we wrote a large number of such patches, including:

* Bernhard M. Wiedemann:

    * keeperrl [46] (merged, date)
    * sphinx-doc [47] (nondeterminism from parallelism via
      Sphinx [48])
    * vlc [49] (sort tar)
    * A number of expiring SSL testing certificates have been extended
      to 2049 to fix future builds:
        * python-M2Crypto [50]
        * python-aiosmtplib [51]
        * python-distlib [52]
        * python-geventhttpclient [53]
        * python-moto [54] (has a remaining year 2038 bug)
        * python-oslo.service [55]
        * python-thriftpy2 [56]

 [46] https://github.com/miki151/keeperrl/pull/1489
 [47] https://github.com/sphinx-doc/sphinx/issues/6714
 [48] http://www.sphinx-doc.org/en/master/
 [49] https://mailman.videolan.org/pipermail/vlc-devel/2019-October/128188.html
 [50] https://gitlab.com/m2crypto/m2crypto/merge_requests/235
 [51] https://github.com/cole/aiosmtplib/pull/92
 [52] https://bitbucket.org/pypa/distlib/pull-requests/44/extend-test-cert-validity-to-2049/diff
 [53] https://github.com/gwik/geventhttpclient/pull/115
 [54] https://github.com/spulec/moto/pull/2500
 [55] https://review.opendev.org/687822
 [56] https://github.com/Thriftpy/thriftpy2/pull/91


* Chris Lamb (*lamby*):

    * #934698 filed against libchamplain (merged upstream [59]).
    * #941714 filed against bst-external.
    * #941715 filed against checkinstall.
    * #941716 filed against gobject-introspection.
    * #942005 filed against elph.
    * #942006 filed against squeak-plugins-scratch.
    * #942009 filed against stgit. (forwarded upstream [72]).
    * #942342 filed against traitlets (forwarded upstream [75]).
    * #942479 filed against frobby.
    * #942767 filed against python-oslo.reports.
    * #942847 filed against cloudkitty.
    * #942848 filed against designate.
    * #943471 filed against khard (forwarded upstream [90]).
    * #943674 filed against flask (forwarded upstream [93]).
    * #943694 filed against ros-genpy (forwarded upstream [96]).
    * #943829 filed against pmemkv.
    * #943954 filed against tm-align
    * #943956 filed against snakemake (forwarded upstream [103])
    * spirv-tools [104].
    * #942867 & #942870: Filed against r-base (not
      respecting nocheck and nodoc Debian build profiles [87]).

 [59] https://gitlab.gnome.org/GNOME/libchamplain/merge_requests/9
 [72] https://github.com/ctmarinas/stgit/pull/43
 [75] https://github.com/ipython/traitlets/pull/535
 [87] https://wiki.debian.org/BuildProfileSpec
 [90] https://github.com/scheibler/khard/pull/233
 [93] https://github.com/pallets/flask/pull/3408
 [96] https://github.com/ros/genpy/pull/110
 [103] https://github.com/snakemake/snakemake/pull/80
 [104] https://github.com/KhronosGroup/SPIRV-Tools/pull/2982


* Mattias Ellert:
    * #942671 filed against doxygen.


Lastly, a request from Steven Engler [107] to sort fields in the
PKG-INFO files generated by the setuptools [108] Python module
build utilities was resolved [109] by Jason R. Coombs [110] and
Vagrant Cascadian added SOURCE_DATE_EPOCH [111] support to LTSP
[112]'s manual page generation.

 [106] https://tracker.debian.org/pkg/doxygen
 [107] https://github.com/stevenengler
 [108] https://pypi.org/project/setuptools/
 [109] https://github.com/pypa/setuptools/pull/1305#issuecomment-538810632
 [110] https://www.jaraco.com/
 [111] https://reproducible-builds.org/docs/source-date-epoch/
 [112] https://ltsp.github.io/


strip-nondeterminism & reprotest
--------------------------------

strip-nondeterminism [113] is our tool to remove specific non-
deterministic results from successful builds. This month, Chris Lamb
made a number of changes including uploading version 1.6.1-1 was to
Debian unstable [114]. This dropped a bug_803503.zip test fixture as
it is no longer compatible with the latest version of Perl's
Archive::Zip [115] module (#940973) [116].

reprotest is our end-user tool to build same source code twice in
widely differing environments and then checks the binaries produced
by each build for any differences. This month, I?aki Malerba updated
our Salsa CI [117] scripts [118] as well as adding a --control-build
parameter [119]. Holger Levsen uploaded the package as 0.7.10,
bumping the Debian "standards version" [120] to 4.4.1 [121].

 [113] https://tracker.debian.org/pkg/strip-nondeterminism
 [114] https://tracker.debian.org/news/1071922/accepted-strip-nondeterminism-161-1-source-into-unstable/
 [115] https://metacpan.org/pod/Archive::Zip
 [116] https://bugs.debian.org/940973
 [117] https://salsa.debian.org
 [118] https://salsa.debian.org/reproducible-builds/reprotest/commit/a547967
 [119] https://salsa.debian.org/reproducible-builds/reprotest/commit/52f6eeb
 [120] https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-standards-version
 [121] https://salsa.debian.org/reproducible-builds/reprotest/commit/fa0e286


diffoscope
----------

diffoscope [123] is our in-depth and content-aware diff utility that
can locate and diagnose reproducibility issues. It is run countless
times a day on our testing infrastructure [124] and is essential for
identifying fixes and causes of non-deterministic behaviour.

 [123] https://diffoscope.org
 [124] https://tests.reproducible-builds.org/debian/reproducible.html

This month, Chris Lamb (*lamby*) made the following changes,
including uploading versions 126, 127, 128 and 129 to the Debian
*unstable* distribution:

* Disassembling and reporting on files related to the R (programming
  language) [125]):

    * Expose an .rdb file's absolute paths in the semantic/human-
      readable output, not hidden deep in a hexdump. [126]
    * Rework and refactor the handling of .rdb files with respect to
      locating the parallel .rdx prior to inspecting the file to
      ensure that we do not add files to the user's filesystem in the
      case of directly comparing two .rdb files or ? worse ?
      overwriting a file in is place. [127]
    * Query the container for the full path of the parallel .rdx file
      to the .rdb file as well as looking in the same directory. This
      ensures that comparing two Debian packages shows any varying
      path. [128]
    * Correct the matching of .rds files by also detecting newer
      versions of this file format. [129]
    * Don't read the site and user environment when comparing .rdx,
      .rdb or .rds files by using Rscript's --vanilla option.
      [130][131]
    * Ensure all object names are displayed, including ones beginning
      with a fullstop (.) [132] and sort package fields when
      dumping data from .rdb files [133].
    * Mask/hide standard error when processing .rdb files [134]
      and don't include useless/misleading NULL when dumping data
      from them. [135]
    * Format package contents as foo = bar rather than using ugly and
      misleading brackets, etc. [136] and include the object's
      type [137].
    * Don't pass our long script to parse .rdb files via the command
      line; use standard input [138]) instead. [139]
    * Call the deparse function to ensure that we do not error out
      and revert to a binary diff when processing .rdb files with
      internal "vector" types; they do not automatically coerce to
      strings. [140]
    * Other misc/cosmetic changes. [141][142][143]

* Output/logging:
    * When printing an error from a command, format the command for the
      user. [144]
    * Truncate very long command lines when displaying them as an
      external source of data. [145]
    * When formatting command lines ensure newlines and other
      metacharacters appear escaped as \n, etc. 146][147]
    * When displaying the standard error from commands, ensure we use
      the escaped version. [148]
    * Use "exit code" over "return code" terminology when referring to
      UNIX error codes in displayed differences. [149]

* Internal API:
    * Add ability to pass bytestring [150] input to external commands.
      [151]
    * Split out command-line formatting into a separate utility
      function. [152]
    * Add support for easily masking the standard error of commands.
      [153][154]
    * To match the libarchive [155] container, raise a KeyError
      exception if we request an invalid member from a directory.
      [156]
    * Correct string representation output in the traceback when we
      cannot locate a specific item in a container. [157]

* Misc:
    * Move build-dependency on python-argcomplete to its Python 3
      equivalent to facilitate Python 2.x removal. (#942967 [158])
    * Track and report on missing Python modules. (#72 [159])
    * Move from deprecated $ADTTMP to $AUTOPKGTEST_TMP in the
      autopkgtests [160]. [161]
    * Truncate the tcpdump expected diff to 8KB (from ~600KB).
      [162]
    * Try and ensure that new test data files are generated
      dynamically, ie. at least no new ones are added without "good"
      reasons. [163]
    * Drop unused BASE_DIR global in the tests. [164]

 [125] https://en.wikipedia.org/wiki/R_(programming_language
 [126] https://salsa.debian.org/reproducible-builds/diffoscope/commit/f1e80ca
 [127] https://salsa.debian.org/reproducible-builds/diffoscope/commit/ea4c94a
 [128] https://salsa.debian.org/reproducible-builds/diffoscope/commit/322a568
 [129] https://salsa.debian.org/reproducible-builds/diffoscope/commit/2c9fbc1
 [130] https://salsa.debian.org/reproducible-builds/diffoscope/commit/b8236d4
 [131] https://salsa.debian.org/reproducible-builds/diffoscope/commit/f8e436d
 [132] https://salsa.debian.org/reproducible-builds/diffoscope/commit/1f89609
 [133] https://salsa.debian.org/reproducible-builds/diffoscope/commit/9f60724
 [134] https://salsa.debian.org/reproducible-builds/diffoscope/commit/0092be0
 [135] https://salsa.debian.org/reproducible-builds/diffoscope/commit/cb83076
 [136] https://salsa.debian.org/reproducible-builds/diffoscope/commit/343d01d
 [137] https://salsa.debian.org/reproducible-builds/diffoscope/commit/895f398
 [138] https://en.wikipedia.org/wiki/Standard_streams#Standard_input_(stdin
 [139] https://salsa.debian.org/reproducible-builds/diffoscope/commit/07a013f
 [140] https://salsa.debian.org/reproducible-builds/diffoscope/commit/91d7029
 [141] https://salsa.debian.org/reproducible-builds/diffoscope/commit/c23651e
 [142] https://salsa.debian.org/reproducible-builds/diffoscope/commit/face6fb
 [143] https://salsa.debian.org/reproducible-builds/diffoscope/commit/f23f2b4
 [144] https://salsa.debian.org/reproducible-builds/diffoscope/commit/138aac1
 [145] https://salsa.debian.org/reproducible-builds/diffoscope/commit/ecccd71
 [146] https://salsa.debian.org/reproducible-builds/diffoscope/commit/691ce88
 [147] https://salsa.debian.org/reproducible-builds/diffoscope/commit/338dbdf
 [148] https://salsa.debian.org/reproducible-builds/diffoscope/commit/bbfdb57
 [149] https://salsa.debian.org/reproducible-builds/diffoscope/commit/6a8251d
 [150] https://docs.python.org/3/library/stdtypes.html#bytes
 [151] https://salsa.debian.org/reproducible-builds/diffoscope/commit/c525ba9
 [152] https://salsa.debian.org/reproducible-builds/diffoscope/commit/f784d2c
 [153] https://salsa.debian.org/reproducible-builds/diffoscope/commit/9b5c5fd
 [154] https://salsa.debian.org/reproducible-builds/diffoscope/commit/2e33ad6
 [155] https://www.libarchive.org/
 [156] https://salsa.debian.org/reproducible-builds/diffoscope/commit/c98e40f
 [157] https://salsa.debian.org/reproducible-builds/diffoscope/commit/2478e9c
 [158] https://bugs.debian.org/942967
 [159] https://salsa.debian.org/diffoscope/reproducible-builds/diffoscope
 [160] https://ci.debian.net/
 [161] https://salsa.debian.org/reproducible-builds/diffoscope/commit/f06c44f
 [162] https://salsa.debian.org/reproducible-builds/diffoscope/commit/c6517e6
 [163] https://salsa.debian.org/reproducible-builds/diffoscope/commit/e83b360
 [164] https://salsa.debian.org/reproducible-builds/diffoscope/commit/7b44c80

In addition, Mattia Rizzolo updated our tests to run against all
supported Python versions [165] and to exit with a UNIX exit status
[166] of 2 instead of 1 in case of running out of disk space [167].
Lastly Vagrant Cascadian updated diffoscope 126 [168] and 129 [169]
in GNU Guix [170], and updated inputs for additional test suite
coverage [171].

trydiffoscope [172] is the web-based version of diffoscope [173] and
this month Chris Lamb migrated the tool to depend on the
python3-docutils package over python-docutils to allow for Python
2.x removal (#943293 [174]) as well as updating the packaging to the
latest Debian standards and conventions [175][176][177].

 [165] https://salsa.debian.org/reproducible-builds/diffoscope/commit/23c6112
 [166] https://en.wikipedia.org/wiki/Exit_status
 [167] https://salsa.debian.org/reproducible-builds/diffoscope/commit/59267e8
 [168] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=c3704ecaa537f96dfca2f820c3af5357a6208ce6
 [169] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=d332fd860f89ed426a2b05eaa8f7a76ff6aab58f
 [170] https://guix.gnu.org/
 [171] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=36f5f23c1af640782aa47dbfed6352e3d4c957ff
 [172] https://try.diffoscope.org
 [173] https://diffoscope.org
 [174] https://bugs.debian.org/943293
 [175] https://salsa.debian.org/reproducible-builds/trydiffoscope/commit/75e8b14
 [176] https://salsa.debian.org/reproducible-builds/trydiffoscope/commit/95d7faf
 [177] https://salsa.debian.org/reproducible-builds/trydiffoscope/commit/01df0a4


Project website
---------------

 URL: https://reproducible-builds.org/

There was yet more effort put into our our website this month,
including Chris Lamb improving the formatting of reports
[179][180][181][182][183] and tidying the new "Testing framework"
[184] links [185], etc.

In addition, Holger Levsen add the Tor Project's Reproducible Builds
Manager [186] to our "Who is Involved? [187]" page and Mattia Rizzolo
dropped a literal HTML element [188].

 [179] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/db5e808
 [180] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/4594e05
 [181] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/f338c38
 [182] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/46b66fc
 [183] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/ad390e8
 [184] https://tests.reproducible-builds.org/debian/reproducible.html
 [185] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/137e4bd
 [186] https://rbm.torproject.org/
 [187] https://reproducible-builds.org/who/
 [188] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/8b69f7d


Test framework
--------------

We operate a comprehensive Jenkins-based testing framework that
powers tests.reproducible-builds.org. This month, the following
changes were made:

* Holger Levsen:
    * Debian-specific changes:
        * Add a script to ease powercycling x86 and arm64 nodes.
          [192][193]
        * Don't create suite-based directories for
          buildinfos.debian.net [194]. [195]
        * Make all four suites being tested shown in a single row on
          the performance page. [196]

    * OpenWrt changes:
        * Only run jobs every third day. [198]
        * Create jobs to run the reproducible_openwrt_rebuild.py
          script today and in the future. [199]

* Mattia Rizzolo:
    * Add some packages that were lost while updating to *buster*.
      [200]
    * Fix the auto-offline functionality by checking the content of the
      permalinks file instead of following the lastSuccessfulBuild
      that no longer being updated. [201]

* Paul Spooren (OpenWrt [202]):
    * Add a reproducible_common utilities file. [203]
    * Update the openwrt-rebuild script to to use schroot.
      [204]
    * Use unbuffered [205] Python output [206] as well as fixing
      newlines [207][208]

The usual node maintenance was performed by Holger Levsen [209][210],
Mattia Rizzolo [211][212][213] and Vagrant Cascadian [214][215][216].

 [192] https://salsa.debian.org/qa/jenkins.debian.net/commit/8a69efc8
 [193] https://salsa.debian.org/qa/jenkins.debian.net/commit/64d87e9e
 [194] https://buildinfos.debian.net/
 [195] https://salsa.debian.org/qa/jenkins.debian.net/commit/e4a15fc4
 [196] https://salsa.debian.org/qa/jenkins.debian.net/commit/cd8f363f
 [198] https://salsa.debian.org/qa/jenkins.debian.net/commit/d75af2d4
 [199] https://salsa.debian.org/qa/jenkins.debian.net/commit/fa9febb0
 [200] https://salsa.debian.org/qa/jenkins.debian.net/commit/69c765d7
 [201] https://salsa.debian.org/qa/jenkins.debian.net/commit/a395b84f
 [202] https://openwrt.org
 [203] https://salsa.debian.org/qa/jenkins.debian.net/commit/94dcfb4c
 [204] https://salsa.debian.org/qa/jenkins.debian.net/commit/f73cf72f
 [205] https://eklitzke.org/stdout-buffering
 [206] https://salsa.debian.org/qa/jenkins.debian.net/commit/e2630fb7
 [207] https://salsa.debian.org/qa/jenkins.debian.net/commit/dcbacce5
 [208] https://salsa.debian.org/qa/jenkins.debian.net/commit/0443a133
 [209] https://salsa.debian.org/qa/jenkins.debian.net/commit/cfbc58fb
 [210] https://salsa.debian.org/qa/jenkins.debian.net/commit/5f9424da
 [211] https://salsa.debian.org/qa/jenkins.debian.net/commit/9d3df188
 [212] https://salsa.debian.org/qa/jenkins.debian.net/commit/88db9f0a
 [213] https://salsa.debian.org/qa/jenkins.debian.net/commit/5cdad8fd
 [214] https://salsa.debian.org/qa/jenkins.debian.net/commit/974bca24
 [215] https://salsa.debian.org/qa/jenkins.debian.net/commit/8d4b533c
 [216] https://salsa.debian.org/qa/jenkins.debian.net/commit/3da81a76


Getting in touch
================

If you are interested in contributing the Reproducible Builds project,
please visit our *Contribute* [217] page on our website. However, you
can get in touch with us via:

 * Mailing list: rb-general at lists.reproducible-builds.org [218]

 * IRC: #reproducible-builds on irc.oftc.net.

 * Twitter: @ReproBuilds / https://twitter.com/ReproBuilds

 [217] https://reproducible-builds.org/contribute/
 [218] https://lists.reproducible-builds.org/listinfo/rb-general


This month's report was written by Bernhard M. Wiedemann, Chris Lamb,
Holger Levesen and Vagrant Cascadian. It was subsequently reviewed by a
bunch of Reproducible Builds folks on IRC and the mailing list.


Best wishes,

-- 
      o
    ?   ?      Chris Lamb
   o     o     reproducible-builds.org
    ?   ?
      o

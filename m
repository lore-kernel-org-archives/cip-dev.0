From: chris@reproducible-builds.org (Chris Lamb)
Date: Sat, 05 Oct 2019 14:16:52 -0700
Subject: [cip-dev] Reproducible Builds in September 2019
Message-ID: <01f6e185-c506-4fa1-b1c9-9e237574fb1a@www.fastmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

=====================================
Reproducible Builds in September 2019
=====================================

Welcome to the September 2019 report from the Reproducible Builds
project! [0]

In these reports we outline the most important things that we have been
up over the past month. As a quick refresher of what our project is
about, whilst anyone can inspect the source code of free software for
malicious changes most software is distributed to end users or servers
as precompiled binaries. The motivation behind the reproducible builds
effort is to ensure zero changes have been introduced during these
compilation processes. This is achieved by promising identical results
are always generated from a given source, thus allowing multiple third-
parties to come to a consensus on whether a build was compromised.

In this months report, we will cover:

* Media coverage & events ? *more presentations, preventing
  Stuxnet, etc.*
* Upstream news ? *kernel reproducibility, grafana, systemd, etc.*
* Distribution work ? *reproducible images in Arch Linux, policy
  changes in Debian, etc.*
* Software development ? *yet more work on diffoscope, upstream
  patches, etc.*
* Misc news & getting in touch ? *from our mailing list how to
  contribute, etc*

If you are interested in contributing to our project, please visit our
*Contribute* [1] page on our website.

 [0] https://reproducible-builds.org/
 [1] https://reproducible-builds.org/contribute/

?

## Media coverage & events

This month Vagrant Cascadian attended the 2019 GNU Tools Cauldron [2] in
Montr?al, Canada and gave a presentation entitled *Reproducible
Toolchains for the Win* [3] (video [4]).

In addition, our project was highlighted as part of a presentation [5]
by Andrew Martin [6] at the All Systems Go [7] conference in Berlin
titled *Rootless, Reproducible & Hermetic: Secure Container Build
Showdown* [8], and Bj?rn Michaelsen [9] from the Document Foundation
[10] presented at the 2019 LibreOffice Conference [11] in Almer?a in
Spain on the status of reproducible builds in the LibreOffice office
suite [12].

In academia, Anastasis Keliris and Michail Maniatakos from the New York
University Tandon School of Engineering [13] published a paper titled
*ICSREF: A Framework for Automated Reverse Engineering of Industrial
Control Systems Binaries* (PDF [14]) that speaks to concerns regarding
the security of Industrial Control Systems (ICS) such as those attacked
via Stuxnet [15]. The paper outlines their ICSREF [16] tool for reverse-
engineering binaries from such systems and furthermore demonstrates a
scenario whereby a commercial smartphone equipped with ICSREF could be
easily used to compromise such infrastructure.

Lastly, It was announced that Vagrant Cascadian will present a talk at
SeaGL [17] in Seattle, Washington during November titled *There and Back
Again, Reproducibly* [18].

 [ 2] https://gcc.gnu.org/wiki/cauldron2019
 [ 3] https://gcc.gnu.org/wiki/cauldron2019#cauldron2019talks.Reproducible_Toolchains_For_The_Win
 [ 4] https://www.youtube.com/watch?v=56nRFxA7lPY
 [ 5] https://media.ccc.de/v/ASG2019-146-rootless-reproducible-hermetic-secure-container-build-showdown#t=407
 [ 6] https://twitter.com/sublimino
 [ 7] https://all-systems-go.io/
 [ 8] https://cfp.all-systems-go.io/ASG2019/talk/PVYETJ/
 [ 9] https://en.wikipedia.org/wiki/Bj%C3%B6rn_Michaelsen
 [10] https://www.documentfoundation.org/
 [11] https://libocon.org/
 [12] https://www.libreoffice.org/
 [13] https://engineering.nyu.edu/
 [14] https://arxiv.org/pdf/1812.03478.pdf
 [15] https://en.wikipedia.org/wiki/Stuxnet
 [16] https://github.com/momalab/ICSREF
 [17] https://seagl.org
 [18] https://osem.seagl.org/conferences/seagl2019/program/proposals/671

?

## 2019 Summit <https://reproducible-builds.org/events/Marrakesh2019/>

Registration for our fifth annual Reproducible Builds summit [19] that
will take place between 1st ? 8th December in Marrakesh, Morocco has
opened and personal invitations [20] have been sent out.

Similar to previous incarnations of the event, the heart of the workshop
will be three days of moderated sessions with surrounding "hacking" days
and will include a huge diversity of participants from Arch Linux,
coreboot, Debian, F-Droid, GNU Guix, Google, Huawei, in-toto, MirageOS,
NYU, openSUSE, OpenWrt, Tails, Tor Project and many more. If you would
like to learn more about the event and how to register, please visit our
our dedicated event page [21].

 [19] https://reproducible-builds.org/events/Marrakesh2019/
 [20] https://lists.reproducible-builds.org/pipermail/rb-general/2019-September/001651.html
 [21] https://reproducible-builds.org/events/Marrakesh2019/

?

## Upstream news

Ben Hutchings added documentation to the Linux kernel [22] regarding how
to make the build reproducible. As he mentioned in the commit message,
the kernel is "actually" reproducible but the end-to-end process was not
previously documented in one place and thus Ben describes the workflow
and environment needed to ensure a reproducible build.

Daniel Edgecumbe [23] submitted a pull request [24] which was
subsequently merged to the logging/journaling component of systemd [25]
in order that the output of e.g. `journalctl --update-catalog` does not
differ between subsequent runs despite there being no changes in the
input files.

Jelle van der Waa noticed that if the grafana [26] monitoring tool was
built within a source tree devoid of Git [27] metadata then the current
timestamp was used instead, leading to an unreproducible build. To avoid
this, Jelle submitted a pull request [28] in order that it use
SOURCE_DATE_EPOCH [29] if available.

Mes [30] (a Scheme-based compiler for our "sister" bootstrappable builds
[31] effort) announced their 0.20 release [32].

 [22] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fe013f8bc160d79c6e33bb66d9bb0cd24949274c
 [23] https://esotericnonsense.com
 [24] https://github.com/systemd/systemd/pull/13482
 [25] https://www.freedesktop.org/wiki/Software/systemd/
 [26] https://grafana.com/
 [27] https://git-scm.com/
 [28] https://github.com/grafana/grafana/pull/18953
 [29] https://reproducible-builds.org/docs/source-date-epoch
 [30] https://gitlab.com/janneke/mes
 [31] http://bootstrappable.org
 [32] https://lists.reproducible-builds.org/pipermail/rb-general/2019-September/001649.html


### Distribution work

Bernhard M. Wiedemann posted his monthly Reproducible Builds status
update [33] for the openSUSE [34] distribution. Thunderbird [35] and
kernel-vanilla packages will be among the larger ones to become
reproducible soon and there were additional Python patches to help
reproducibility issues of modules written in this language that have
C bindings.

OpenWrt [36] is a Linux-based operating system targeting embedded
devices such as wireless network routers. This month, Paul Spooren
(*aparcar*) switched the toolchain the use the GCC [37] version 8 by
default in order to support the `-ffile-prefix-map=` which permits a
varying build path without affecting the binary result of the build
[38]. In addition, Paul updated the `kernel-defaults` package [39] to
ensure that the SOURCE_DATE_EPOCH environment variable [40] is
considered when creating the the /init directory.

Alexander "*lynxis*" Couzens began work on working on a set of build
scripts [41] for creating firmware and operating system artifacts in the
*coreboot* [42] distribution.

Lukas P?hringer prepared an upload which was sponsored by Holger Levsen
of python-securesystemslib version 0.11.3-1 [43] to Debian unstable.
python-securesystemslib is a dependency of in-toto [44], a framework to
protect the integrity of software supply chains.

 [33] https://lists.opensuse.org/opensuse-factory/2019-09/msg00244.html
 [34] https://opensuse.org/
 [35] https://www.thunderbird.net/
 [36] https://openwrt.org/
 [37] https://gcc.gnu.org/
 [38] https://lists.infradead.org/pipermail/openwrt-devel/2019-September/019156.html
 [39] https://lists.infradead.org/pipermail/openwrt-devel/2019-September/019166.html
 [40] https://reproducible-builds.org/docs/source-date-epoch/
 [41] https://github.com/system-transparency/build.git
 [42] https://www.coreboot.org/
 [43] https://tracker.debian.org/news/1061049/accepted-python-securesystemslib-0113-1-source-all-into-unstable-unstable/
 [44] https://github.com/in-toto/in-toto


#### Arch Linux <https://www.archlinux.org/>

The mkinitcpio component of Arch Linux [45] was updated by Daniel
Edgecumbe [46] in order that it generates reproducible initramfs images
[47] by default, meaning that two subsequent runs of mkinitcpio
produces two files that are identical at the binary level. The commit
message [48] elaborates on its methodology:

> Timestamps within the initramfs are set to the Unix epoch of
1970-01-01. Note that in order for the build to be fully reproducible,
the compressor specified (e.g. gzip, xz) must also produce reproducible
archives. At the time of writing, as an inexhaustive example, the lzop
compressor is incapable of producing reproducible archives due to the
insertion of a runtime timestamp.

In addition, a bug was created to track progress on making the Arch
Linux ISO images reproducible [49].

 [45] https://www.archlinux.org/
 [46] https://esotericnonsense.com
 [47] https://en.wikipedia.org/wiki/Initial_ramdisk
 [48] https://github.com/archlinux/mkinitcpio/pull/1/files
 [49] https://bugs.archlinux.org/task/63683?project=6


#### Debian <https://debian.org/>

In July, Holger Levsen filed a bug against the underlying tool [50] that
maintains the Debian archive ("dak [51]") after he noticed that
`.buildinfo` metadata files were not being automatically propagated in
the case that packages had to be manually approved in "NEW queue
[52]". After it was pointed out that the files were being retained in a
separate location, Benjamin Hof proposed a patch [53] for the issue that
was merged and deployed this month [54].

Aur?lien Jarno [55] filed a bug against the Debian Policy [56] (#940234
[57]) to request a section be added regarding the reproducibility of
source packages. Whilst there is already a section about reproducibility
in the Policy, it only mentions binary packages. Aur?lien suggest
that it:

> ... might be a good idea to add a new requirement that repeatedly
building the source package in the same environment produces identical
.dsc files.

In addition, 51 reviews of Debian packages were added, 22 were updated
and 47 were removed this month adding to our knowledge about identified
issues [58]. Many issue types were added by Chris Lamb including
buildpath_in_code_generated_by_bison [59], buildpath_in_postgres_opcodes
[60] and ghc_captures_build_path_via_tempdir [61].

 [50] https://bugs.debian.org/932849
 [51] https://wiki.debian.org/DebianDak
 [52] https://ftp-master.debian.org/new.html
 [53] https://bugs.debian.org/932849#22
 [54] https://salsa.debian.org/ftp-team/dak/commit/e29d4c4dca77aea5555aac7a5ea7f665efec688f
 [55] https://www.aurel32.net/
 [56] https://www.debian.org/doc/debian-policy/
 [57] https://bugs.debian.org/940234
 [58] https://tests.reproducible-builds.org/debian/index_issues.html
 [59] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/c0d9481b
 [60] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/6aacfd67
 [61] https://salsa.debian.org/reproducible-builds/reproducible-notes/commit/5677943d

?

## Software development

#### Upstream patches

The Reproducible Builds project detects, dissects and attempts to fix as
many currently-unreproducible packages as possible. We endeavour to send
all of our patches upstream where appropriate. This month, we wrote a
large number of such patches, including:

* Bernhard M. Wiedemann:

    * `blender` [62] (Python date)
    * `buzztrax` [63] (shell date)
    * `colobot-data` [64] (sort a Python `readdir`, forwarded
      upstream [65])
    * `enblend-enfuse` [66] (date/host/user)
    * `gmsh` [67] (hostname/username)
    * `griefly` [68] (sort a Python `readdir`, forwarded upstream [69])
    * `guile` [70] (disable parallelism)
    * `latex2html` [71] (drop LaTeX log file with date)
    * `MozillaFirefox` [72] (make Profile-Guided Optimisation
      [73] optional)
    * `MozillaThunderbird` [74] (Python date)
    * `ninja` [75] (build failure when build without parallelism)
    * `python-futures` [76] (fix build failure)
    * `python-holidays` [77] (fix build failure in 2020)
    * `python-iminuit` [78] (sort a Python glob [79])
    * `python-ioflo` [80] (fix build failure via security
      certificate renewal)
    * `python-keystoneauth1` [81] (fix build failure in 2020)
    * `python-openstackdocstheme` [82] (date issue)
    * `python3` [83]/`python` [84] (toolchain, sort `readdir`)
    * `volk` [85] (report compile-time CPU-detection)
    * `wget2` [86] (drop a build date)

 [62] https://developer.blender.org/D5756
 [63] https://github.com/Buzztrax/buzztrax/pull/88
 [64] https://build.opensuse.org/request/show/733640
 [65] https://github.com/colobot/colobot-data/pull/41
 [66] https://build.opensuse.org/request/show/731759
 [67] https://build.opensuse.org/request/show/731075
 [68] https://build.opensuse.org/request/show/733637
 [69] https://github.com/griefly/griefly/pull/508
 [70] https://build.opensuse.org/request/show/732638
 [71] https://build.opensuse.org/request/show/733232
 [72] https://build.opensuse.org/request/show/733089
 [73] https://en.wikipedia.org/wiki/Profile-guided_optimization
 [74] https://build.opensuse.org/request/show/732106
 [75] https://github.com/ninja-build/ninja/pull/1651
 [76] https://github.com/agronholm/pythonfutures/pull/92
 [77] https://github.com/dr-prodigy/python-holidays/pull/235
 [78] https://github.com/scikit-hep/iminuit/pull/355
 [79] https://docs.python.org/3/library/glob.html
 [80] https://github.com/ioflo/ioflo/pull/41
 [81] https://review.opendev.org/681103
 [82] https://build.opensuse.org/request/show/732328
 [83] https://build.opensuse.org/request/show/733152
 [84] https://build.opensuse.org/request/show/733188
 [85] https://bugzilla.opensuse.org/show_bug.cgi?id=1152001
 [86] https://gitlab.com/gnuwget/wget2/merge_requests/450

* Chris Lamb ("*lamby*"):
    * #939546 [87] filed against `libnbd` [88] (forwarded
      upstream [89])
    * #939547 [90] filed against `libubootenv` [91] (forwarded
      upstream [92])
    * #939548 [93] filed against `dsdp` [94].
    * #939549 [95] filed against `sdaps` [96] (forwarded upstream [97])
    * #939650 [98] filed against `libvdpau` [99].
    * #940013 [100] filed against `apophenia` [101].
    * #940156 [102] filed against `pydantic` [103] (forwarded
      upstream [104])
    * #940639 [105] filed against `vala-panel` [106].
    * #941072 [107] filed against `kivy` [108].
    * #941116 [109] filed against `fathom` [110].
    * Several `libguestfs` [111] components have received a patch [112]
      to support `SOURCE_DATE_EPOCH` [113].

 [87] https://bugs.debian.org/939546
 [88] https://tracker.debian.org/pkg/libnbd
 [89] https://github.com/libguestfs/libnbd/pull/2
 [90] https://bugs.debian.org/939547
 [91] https://tracker.debian.org/pkg/libubootenv
 [92] https://github.com/sbabic/libubootenv/pull/3
 [93] https://bugs.debian.org/939548
 [94] https://tracker.debian.org/pkg/dsdp
 [95] https://bugs.debian.org/939549
 [96] https://tracker.debian.org/pkg/sdaps
 [97] https://github.com/sdaps/sdaps/pull/182
 [98] https://bugs.debian.org/939650
 [99] https://tracker.debian.org/pkg/libvdpau
 [100] https://bugs.debian.org/940013
 [101] https://tracker.debian.org/pkg/apophenia
 [102] https://bugs.debian.org/940156
 [103] https://tracker.debian.org/pkg/pydantic
 [104] https://github.com/samuelcolvin/pydantic/pull/805
 [105] https://bugs.debian.org/940639
 [106] https://tracker.debian.org/pkg/vala-panel
 [107] https://bugs.debian.org/941072
 [108] https://tracker.debian.org/pkg/kivy
 [109] https://bugs.debian.org/941116
 [110] https://tracker.debian.org/pkg/fathom
 [111] http://libguestfs.org/
 [112] https://www.redhat.com/archives/libguestfs/2019-September/msg00037.html
 [113] http://reproducible-builds.org/docs/source-date-epoch/

* Rebecca N. Palmer:
    * #941309 [114] filed against node-browserify-lite [115].

 [114] https://bugs.debian.org/941309
 [115] https://tracker.debian.org/pkg/node-browserify-lite


#### Diffoscope <https://diffoscope.org>

diffoscope [117] is our in-depth and content-aware diff utility that
can locate and diagnose reproducibility issues. It is run countless
times a day on our testing infrastructure [118] and is essential for
identifying fixes and causes of non-deterministic behaviour.

This month, Chris Lamb uploaded versions 123, 124 and 125 and made the
following changes:

* New features:

    * Add `/srv/diffoscope/bin` to the Docker image path. (#70 [119])
    * When skipping tests due to the lack of installed tool, print the
      package that might provide it. [120]
    * Update the "no progressbar" logging message to match the parallel
      `missing tlsh module` warnings. [121]
    * Update "requires foo" messages to clarify that they are referring
      to Python modules. [122]

* Testsuite updates:

    * The `test_libmix_differences` ELF binary test requires the `xxd`
      tool. (#940645 [123])
    * Build the OCaml test input files on-demand rather than shipping
      them with the package in order to prevent test failures with
      OCaml 4.08. (#67 [124])
    * Also conditionally skip the identification and "no differences"
      tests as we require the Ocaml [125] compiler to be present when
      building the test files themselves. (#940471 [126])
    * Rebuild our test squashfs images [127] to exclude the character
      device as they requires root or fakeroot [128] to extract.
      (#65 [129])

* Many code cleanups, including dropping some unnecessary control flow
  [130], dropping unnecessary `pass` statements [131] and
  dropping explicitly inheriting from `object` class as it unnecessary
  in Python 3 [132].

In addition, Marc Herbert completely overhauled the handling of ELF
binaries particularly around many assumptions that were previously being
made via file extensions, etc. [133][134][135] and
updated the testsuite to support a never version of the *coreboot* [136]
utilities. [137]. Mattia Rizzolo then ensured that *diffoscope*
does not crash when the progress bar module is missing but the
functionality was requested [138] and made our version checking
code more lenient [139]. Lastly, Vagrant Cascadian not only
updated *diffoscope* to versions 123 [140] and 125 [141], he enabled a
more complete test suite in the GNU Guix [142] distribution.
[143][144][145][146][147][148]

 [117] https://diffoscope.org
 [118] https://tests.reproducible-builds.org/debian/reproducible.html
 [119] https://salsa.debian.org/reproducible-builds/diffoscope/issues/70
 [120] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/e5b8268
 [121] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/c381c4a
 [122] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/73ffcdc
 [123] https://bugs.debian.org/940645
 [124] https://salsa.debian.org/reproducible-builds/diffoscope/issues/67
 [125] https://ocaml.org/
 [126] https://bugs.debian.org/940471
 [127] https://en.wikipedia.org/wiki/SquashFS
 [128] https://wiki.debian.org/FakeRoot
 [129] https://salsa.debian.org/reproducible-builds/diffoscope/issues/65
 [130] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/ff57b86
 [131] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/e066e77
 [132] https://salsa.debian.org/reproducible-builds/diffoscope.git/commit/7c21ed3
 [133] https://salsa.debian.org/reproducible-builds/diffoscope/commit/ce6c03f
 [134] https://salsa.debian.org/reproducible-builds/diffoscope/commit/ec7b3ae
 [135] https://salsa.debian.org/reproducible-builds/diffoscope/commit/bee2a11
 [136] https://www.coreboot.org/
 [137] https://salsa.debian.org/reproducible-builds/diffoscope/commit/29da4e4
 [138] https://salsa.debian.org/reproducible-builds/diffoscope/commit/7294ff9
 [139] https://salsa.debian.org/reproducible-builds/diffoscope/commit/e07dfbe
 [140] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=3ec8c0ca942409da6ce06c38f6d8b6ccfc2a943a
 [141] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=3fb581ca9f18fe61e070195f4f8d1a670931b722
 [142] https://guix.gnu.org/
 [143] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=3eb4adc2c41896c202f3d9131c36160c0a1311e6
 [144] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=68620d62f5cd49d6455c351f3a68e3c41dc6ce22
 [145] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=6ec872231fdf746bd6e11b97f8a6b3a23498806c
 [146] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=af760990e9651be865ccd20b935863d85f605f2e
 [147] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=4d83157cd806aeb864664ebb380c19f6be04648c
 [148] https://git.savannah.gnu.org/cgit/guix.git/commit/?id=f315673d9e56f4f2398098590ebdc080b63ce8b1


#### Project website <https://reproducible-builds.org/>

There was yet more effort put into our our website [149] this
month, including:

* Chris Lamb:
    * Add missing image for in-toto [150] on the "Who is Involved?
      [151]" page. [152]
    * Don't align images when on "extra small" (i.e. mobile) devices as
      they make the text wrapping look suboptimal. [153]
    * Use `{% raw %}{% raw %}{% endraw %}` to escape Markdown in
      templated Jinja [154] code. [155]

* Holger Levsen:
    * Add a link to our style guide [156] on our "tools [157]" page.
      [158]
    * Rework the handling of news/events, including adding a news
      archive page [159] [160] and differentiating between news
      and reports on the homepage [161].
    * Large number of changes to the "Who is Involved? [162]" page,
      including adding a link to F-Droid [163]'s verification server
      [164] [165] and their verification tool for end-users [...
      [166] as well as adding the Civil Infrastructure Project [167]
      (CIP) as a sponsor [168]
    * Include a link to our testing framework [169] in all navigation
      elements. [170]
    * Add/improve a number of presentation entries on our *Talks &
      Resources* [171] page. [172][173][174][175][176]

In addition, Cindy Kim added in-toto [177] to our "Who is Involved?
[178]" page, James Fenn updated our homepage [179] to fix a number of
spelling and grammar issues [180] and Peter Conrad added BitShares
[181] to our list of projects interested in Reproducible Builds [182]
[183].

 [149] https://reproducible-builds.org/
 [150] https://in-toto.io/
 [151] https://reproducible-builds.org/who/
 [152] https://salsa.debian.org/reproducible-builds/reproducible-website.git/commit/70696b6
 [153] https://salsa.debian.org/reproducible-builds/reproducible-website.git/commit/cdc12ae
 [154] https://palletsprojects.com/p/jinja/
 [155] https://salsa.debian.org/reproducible-builds/reproducible-website.git/commit/ec7c692
 [156] https://reproducible-builds.org/style/
 [157] https://reproducible-builds.org/tools/
 [158] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/9a6975f
 [159] https://reproducible-builds.org/news-archive/
 [160] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/f64c772
 [161] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/40a6371
 [162] https://reproducible-builds.org/who/
 [163] https://f-droid.org/
 [164] https://verification.f-droid.org/
 [165] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/50d4240
 [166] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/84d17e4
 [167] https://www.cip-project.org/
 [168] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/a431302
 [169] https://tests.reproducible-builds.org/
 [170] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/692cd67
 [171] https://reproducible-builds.org//resources/
 [172] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/32c861f
 [173] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/f9b4d8a
 [174] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/dbd7c7d
 [175] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/872cb04
 [176] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/37fd2c6
 [177] https://in-toto.io/
 [178] https://reproducible-builds.org/who/
 [179] https://reproducible-builds.org/
 [180] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/f7e9228
 [181] https://bitshares.org/
 [182] https://reproducible-builds.org/who/
 [183] https://salsa.debian.org/reproducible-builds/reproducible-website/commit/d16af27


#### strip-nondeterminism

strip-nondeterminism [184] is our tool to remove specific non-
deterministic results from successful builds. This month, Marc Herbert
made a huge number of changes including:

* GNU ar [185]) handler:
    * Don't corrupt the pseudo file mode of the symbols table.
    * Add test files for "symtab" (/) and long names (//).
    * Don't corrupt the SystemV/GNU table of long filenames.

* Add a new $File::StripNondeterminism::verbose global and, if
  enabled, tell the user that `ar(1)` could not set the symbol table's
  mtime [186].

In addition, Chris Lamb performed some issue investigation with the
Debian Perl Team [187] regarding issues in the `Archive::Zip` [188]
module including a problem with corruption of members that use `bzip`
compression [189] as well as a regression  whereby various metadata
fields were not being updated [190] that was reported in/around Debian
bug #940973 [191].

 [184] https://tracker.debian.org/pkg/strip-nondeterminism
 [185] https://en.wikipedia.org/wiki/Ar_(Unix
 [186] https://en.wikipedia.org/wiki/Mtime
 [187] https://wiki.debian.org/Teams/DebianPerlGroup
 [188] https://metacpan.org/pod/Archive::Zip
 [189] https://github.com/redhotpenguin/perl-Archive-Zip/issues/26
 [190] https://github.com/redhotpenguin/perl-Archive-Zip/issues/51
 [191] https://bugs.debian.org/940973


#### Test framework

We operate a comprehensive Jenkins [192]-based testing framework that
powers tests.reproducible-builds.org [193].

* Alexander "*lynxis*" Couzens:
    * Fix missing `.xcompile` in the build system. [194]
    * Install the GNAT [195] Ada compiler on all builders. [196]
    * Don't install the *iasl* ACPI [197] power management
      compiler/decompiler. [198]

* Holger Levsen:
    * Correctly handle the $DEBUG variable in OpenWrt [199] builds.
      [200]
    * Fefactor and notify the `#archlinux-reproducible` IRC channel for
      problems in this distribution. [201]
    * Ensure that only one mail is sent when rebooting nodes.
      [202]
    * Unclutter the output of a Debian maintenance job. [203]
    * Drop a "todo" entry as we vary on a merged `/usr` [204] for some
      time now. [205]

In addition, Paul Spooren added an OpenWrt [206] snapshot build script
which downloads `.buildinfo` and related checksums from the relevant
download server and attempts to rebuild and then validate them for
reproducibility. [207]

The usual node maintenance was performed by Holger Levsen [...
[208][209][210], Mattia Rizzolo [211] and Vagrant
Cascadian [212][213].

 [192] https://jenkins.io/
 [193] https://tests.reproducible-builds.org
 [194] https://salsa.debian.org/qa/jenkins.debian.net/commit/8b9bc6ba
 [195] https://www.gnu.org/software/gnat/
 [196] https://salsa.debian.org/qa/jenkins.debian.net/commit/dd31f47c
 [197] https://en.wikipedia.org/wiki/Advanced_Configuration_and_Power_Interface
 [198] https://salsa.debian.org/qa/jenkins.debian.net/commit/54aa6650
 [199] https://openwrt.org
 [200] https://salsa.debian.org/qa/jenkins.debian.net/commit/e8342fda
 [201] https://salsa.debian.org/qa/jenkins.debian.net/commit/7d94cf15
 [202] https://salsa.debian.org/qa/jenkins.debian.net/commit/2d836061
 [203] https://salsa.debian.org/qa/jenkins.debian.net/commit/afc2e2fe
 [204] https://wiki.debian.org/UsrMerge
 [205] https://salsa.debian.org/qa/jenkins.debian.net/commit/a489b705
 [206] https://openwrt.org
 [207] https://salsa.debian.org/qa/jenkins.debian.net/commit/034491ea
 [208] https://salsa.debian.org/qa/jenkins.debian.net/commit/e7eb5714
 [209] https://salsa.debian.org/qa/jenkins.debian.net/commit/764d6ce9
 [210] https://salsa.debian.org/qa/jenkins.debian.net/commit/1625e63b
 [211] https://salsa.debian.org/qa/jenkins.debian.net/commit/47c6ee51
 [212] https://salsa.debian.org/qa/jenkins.debian.net/commit/1f1c7218
 [213] https://salsa.debian.org/qa/jenkins.debian.net/commit/1036c5f3


#### reprotest

reprotest is our end-user tool to build same source code twice in
different environments and then check the binaries produced by each
build for differences. This month, a change by Dmitry Shachnev was
merged to not use the faketime wrapper at all when asked to not vary
time [214] and Holger Levsen subsequently released this as version
0.7.9 as dramatically overhauling the packaging [...
[215][216].

 [214] https://salsa.debian.org/reproducible-builds/reprotest/commit/034efd8
 [215] https://salsa.debian.org/reproducible-builds/reprotest/commit/d768b04
 [216] https://salsa.debian.org/reproducible-builds/reprotest/commit/da33646

?

## Misc news & getting in touch

On our mailing list [217] Rebecca N. Palmer started a thread titled
Addresses in IPython output [218] which points out and attempts to find
a solution to a problem with Python packages, whereby objects that don't
have an explicit string representation have a default one that includes
their memory address. This causes problems with reproducible builds
if/when such output appears in generated documentation.

If you are interested in contributing the Reproducible Builds project,
please visit our *Contribute* [219] page on our website. However, you
can get in touch with us via:

 * IRC: #reproducible-builds on irc.oftc.net.

 * Twitter: @ReproBuilds [220]

 * Mailing list: rb-general at lists.reproducible-builds.org [221]

 [217] https://lists.reproducible-builds.org/pipermail/rb-general/
 [218] https://lists.reproducible-builds.org/pipermail/rb-general/2019-September/001657.html
 [219] https://reproducible-builds.org/contribute/
 [220] https://twitter.com/ReproBuilds
 [221] https://lists.reproducible-builds.org/listinfo/rb-general

This month's report was written by Bernhard M. Wiedemann, Chris Lamb,
Holger Levsen, Jelle van der Waa, Mattia Rizzolo and Vagrant Cascadian.
It was subsequently reviewed by a bunch of Reproducible Builds folks on
IRC and the mailing list.

From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Sun, 11 Aug 2019 20:04:54 +0200
Subject: [cip-dev] Yocto repos for NXP referent platform MCIMXABASEV1
 also known as SABRE platform?
In-Reply-To: <CAEss1ELA63B6CEkTh_OObSYpXrv=prAvsLGPh32wNQfRcu2FeQ@mail.gmail.com>
References: <CAEss1ELA63B6CEkTh_OObSYpXrv=prAvsLGPh32wNQfRcu2FeQ@mail.gmail.com>
Message-ID: <CAEss1ELvk_qvgT9oKeMsSYd1P3Ei-35xNpAvm3OXexU_f2tmyg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Found it...

http://variwiki.com/index.php?title=Yocto_Build_Release&release=RELEASE_MORTY_V1

Actually, it is thud, after all. But within few days I'll release
public github repo with complete Sabre Automotive BSP setup.

Parsing recipes: 100%
|###################################################################################################################|
Time: 0:03:18
Parsing of 2571 .bb files complete (0 cached, 2571 parsed). 3567
targets, 464 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "1.40.0"
BUILD_SYS            = "x86_64-linux"
NATIVELSBSTRING      = "fedora-30"
TARGET_SYS           = "arm-fslc-linux-gnueabi"
MACHINE              = "imx6qdlsabreauto"
DISTRO               = "fslc-framebuffer"
DISTRO_VERSION       = "2.6"
TUNE_FEATURES        = "arm armv7a vfp thumb neon callconvention-hard"
TARGET_FPU           = "hard"
meta
meta-poky            = "HEAD:50f33d3bfebcbfb1538d932fb487cfd789872026"
meta-oe
meta-multimedia      = "HEAD:4cd3a39f22a2712bfa8fc657d09fe2c7765a4005"
meta-freescale       = "HEAD:46fcbab00f7e01ded4609c09be89161783426f41"
meta-freescale-3rdparty = "HEAD:c4b5ac6b20e4245ce0630e9197313aaef999a331"
meta-freescale-distro = "HEAD:4a244af3993ae662624c6f615464e6806cc719a2"
meta-browser         = "HEAD:75640e14e325479c076b6272b646be7a239c18aa"
meta-gnome
meta-networking
meta-python          = "HEAD:4cd3a39f22a2712bfa8fc657d09fe2c7765a4005"
meta-qt5             = "HEAD:0630018c0033c91fddda62a49f59a82ba6ec6850"
meta-swupdate        = "HEAD:66af6e7e019b07b48facfd68be3c4ab2094502a4"
meta-variscite-fslc  = "HEAD:ff12ab716e1c3f47e723a377f00aa01fa3e5b955"

Best Regards.
Zoran
_______

On Fri, Aug 9, 2019 at 9:17 AM Zoran S <zoran.stojsavljevic.de@gmail.com> wrote:
>
> Hello to all,
>
> I am trying to find out some recent yocto repo, which contains YOCTO
> reference repo for the following NXP board:
> MCIMXABASEV1 also called SABRE platform.
>
> Here is one repo I found reading this document... But this is too outdated!
>
> http://events17.linuxfoundation.org/sites/events/files/slides/AGLAMM_How%20we%20Run%20AGL%20on%20i.MX%20processors_tkobayashi_25FEB16%20rev.D.pdf
>
> Does anybody have some other repos/suggestions in mind for such a
> board? Please, come forward if yes...
>
> Thank you,
> Zoran
> _______

From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Fri, 15 Feb 2019 02:14:06 +0000
Subject: [cip-dev] CIP / Yocto / RaspberryPI 3
In-Reply-To: <7aec9b27d426db4bafab2ac766845a26@optimcloud.com>
References: <7aec9b27d426db4bafab2ac766845a26@optimcloud.com>
Message-ID: <OSAPR01MB3763DF2A613F037BD48E7B4CD0600@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Scott,

> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On Behalf Of
> scottk at optimcloud.com
> is there a recent CIP layer for Yocto ? We would like to test a build for raspberrypi3

CIP core is focused on making sure that Debian source code packages that are relevant for civil infrastructure systems are maintained for a long time. The tool that you use to build that source code doesn't matter.

Having said that, we do provide a few examples of how to use Debian source code in a yocto/OE-like project. You can find the examples here:
https://gitlab.com/cip-project/cip-core/deby/tree/master/poky

These examples use a meta layer called "meta-debian" that modifies recipes to build Debian-maintained source code instead of Yocto-maintained code. Note that officially, meta-debian itself is not part of the CIP project (although it is led by Toshiba). The examples cover support for CIP reference boards (Renesas RZ/G1M, Beaglebone Black, CycloneV, and QEMU).
Please check this quickstart and the READMEs in the repository
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip-core-quickstart

[Note] If you take a look at meta-debian, you will also see that RaspberryPi version 1 is a supported BSP.
https://github.com/meta-debian/meta-debian/tree/morty/bsp

If you want to test a build for raspberrypi3, I suggest that you clone the cip-core Deby examples (https://gitlab.com/cip-project/cip-core/deby.git) and try the Beaglebone Black first to get an idea of how it works. Then, all you have to do is to copy meta-cip-bbb to a new meta-raspi3 layer and modify a few items such as:
- machine: adjust to raspi3 architecture
- kas yaml file: adjust the kernel/devicetree and u-boot parameters for raspi3

Once you get that working (let me know if you have any problem), you can start adding packages to your rootfs from here:
https://github.com/meta-debian/meta-debian/tree/morty/recipes-debian
[Note] I will be glad to add your layer to the CIP core examples.

An important point that you need to understand is that all this recipes try to follow Debian package policies (with some exceptions to make the rootfs tiny). In other words, they do not follow Yocto/OE policies (they configure/build the code in a different manner). For that reason, if you add any famous meta-foo layer created for Yocto you will most likely find compiling or dependency problems.

Renesas has done some work integrating recipes from meta-debian into their yocto/OE meta layers. You can also look at that for reference:
https://github.com/renesas-rz/meta-renesas/tree/yocto_2.4-rt/meta-rzg1/recipes-cip-core

Here they are using the Debian source code only for binutils, busybox, glibc and openssl. This allows them to have a well maintained core but also benefit from the flexibility to use any yocto layer.

[Note] The new version of meta-debian (Deby v2) will probably take a new approach to increase compatibility with the Yocto/OE ecosystem.

Finally, the other important thing to know is that meta-debian/Deby is used to build what we call the CIP tiny profile. In other words, it is aimed at creating tiny operating system images with support for the typical C/C++ applications that you usually find in an industrial embedded controller.

If you want to create applications with a lot of functionality and dependencies (think python, java, go, node js) then Deby (and Yocto in my personal opinion) is not suited for the job. In that case, you probably want to use a tool such as ISAR (https://gitlab.com/cip-playground/isar-cip-core) or any other Debian image build tool (live-wrapper, debos, etc).

Thanks,
Daniel

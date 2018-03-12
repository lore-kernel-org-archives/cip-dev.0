From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Mon, 12 Mar 2018 13:25:59 +0100
Subject: [cip-dev] [ANNOUNCE] 4.4.120-cip20-rt13
In-Reply-To: <20180309144337.7FEBD500C74@mail.monom.org>
References: <20180309144337.7FEBD500C74@mail.monom.org>
Message-ID: <CAEss1ELR0=AJEacFu0sF-9=wkuqmePSYKrV_KQdochKZVaxpyw@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

I did some tests using what I built here, on BeagleBone Black, namely two
tests, to assure that kernel 4.4.120-cip20-rt13 works correctly.

I did build this kernel using your own repo, adding it to my local Debian
VM with Lava test framework, namely to the:
http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/

../ <http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/>dtbs/
<http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/dtbs/>
                                             12-Mar-2018 10:13
          -System.map
<http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/System.map>
                                        12-Mar-2018 10:13
2370567build.json
<http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/build.json>
                                        12-Mar-2018 10:13
  1121build.log
<http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/build.log>
                                         12-Mar-2018 10:13
    260kernel.config
<http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/kernel.config>
                                     12-Mar-2018 10:13
105622modules.tar.xz
<http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/modules.tar.xz>
                                    12-Mar-2018 10:13
2152876zImage <http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/zImage>
                                            12-Mar-2018 10:13
   3671288


Both tests I have used are attached to this email:
simple_test1.yaml
mytest-bbb.yaml

The ingredients used for the test are:
http://localhost:8010/initramfs/initramfs.cpio.gz
http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/zImage
http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/dtbs/am335x-boneblack.dtb
http://localhost:8010/cip-example/cip_v4.4.120/v4.4.120-cip20-rt13/arm/omap2plus_defconfig/modules.tar.xz
exists

The first test is simplistic one (simple_test1.yaml), just to determine the
few simple shell commands, where I also issued uname -a to be sure that I
am testing the correct RT kernel:
uname -a
Linux 192.168.15.159 4.4.120-cip20-rt13 #1 SMP Mon Mar 12 10:12:17 GMT 2018
armv7l GNU/Linux

Result from this test are here: https://pastebin.com/eEz1NNWM

The second one (mytest-bbb.yaml) is one executing from Linaro site:
https://git.linaro.org/qa/test-definitions.git

Result from this test are here: https://pastebin.com/5u51pnpb

I'll try the same tests on Renesas iW-RainboW-G20D-Qseven module.

Zoran
________

On Fri, Mar 9, 2018 at 3:36 PM, Daniel Wagner <wagi@monom.org> wrote:

> Hello CIP RT Folks!
>
> I'm pleased to announce the 4.4.120-cip20-rt13 stable release.
>
> This release is just an update to the new stable 4.4.120-cip20 version
> and no RT specific changes have been made.
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux-cip-rt.git
>
>   branch: linux-4.4.y-cip-rt
>   Head SHA1: e716c559d17b43bbf1c6b803040597a97d9c3767
>
> Enjoy!
>    Daniel
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180312/bc4179d3/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: simple_test1.yaml
Type: application/x-yaml
Size: 2697 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180312/bc4179d3/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mytest-bbb.yaml
Type: application/x-yaml
Size: 2641 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180312/bc4179d3/attachment-0003.bin>

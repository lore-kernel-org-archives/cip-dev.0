From: pavel@denx.de (Pavel Machek)
Date: Sun, 21 Jul 2019 20:28:27 +0200
Subject: [cip-dev] Request for guidance: removal of old config files
 [was: Kernel configurations for 4.19?]
In-Reply-To: <CAEss1EJ7oLR+hVwtmvB1L5yjyaL5fiW0nuCCbwgANv39u=y1Jg@mail.gmail.com>
References: <1555501985.3557.26.camel@codethink.co.uk>
	<9210b0ba912e7a8c64f6562b43f25e4763ac4379.camel@codethink.co.uk>
	<7c8d175eaa43357d6484c6fee89c4d0f@codethink.co.uk>
	<909b4353-87c9-08e2-46f1-4ef8ce3fb6d2@siemens.com>
	<fae9b423882c15f5e31eaef237086f38055dcfce.camel@codethink.co.uk>
	<20190721162559.GB10770@amd>
	<CAEss1EJ7oLR+hVwtmvB1L5yjyaL5fiW0nuCCbwgANv39u=y1Jg@mail.gmail.com>
Message-ID: <20190721182827.GB20280@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Sun 2019-07-21 19:58:40, Zoran S wrote:
> >> Good point.  I have not yet tried running 4.19 on the BBB, but I can
> >> look at adding one - or perhaps Nobuhiro or Pavel already has a
> >> suitable config?
> 
> Excellent point, which spares me time to begin the new email thread
> about 4.19 BBB rt-config file.
> 
> Actually, I have one 4.19 BBB rt-config file, which at the end of trimming
> goes to cycles (not able to set three parameters).
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> cd linux-cip
> *git checkout -b cip_v4.19.13-cip1-rt1-rebase v4.19.13-cip1-rt1-rebase*
> export TREE_NAME=cip-example
> export ARCH=arm
> export CROSS_COMPILE=arm-linux-gnueabihf-
> make -j4 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
> omap2plus_defconfig
> 
> I did adjust all the RT parameters, and at the end of three cycles of
> compiling, I've got the following CONFIG file (attached to this email).
> 
> My problem is, that I ended with cyclic loop, since every time I start
> compiling with:
> make -j4 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
> 
> I end up with changed .config, with always three parameters changed:

I'm not sure I completely understand your problem. But "/" in
menuconfig is helpful:

> *** 585,591 ****
>   #
>   # CONFIG_SUSPEND is not set
>   # CONFIG_HIBERNATION is not set
> *! CONFIG_PM=y <<== (should be # CONFIG_PM is not set)*
>   CONFIG_PM_DEBUG=y
>   # CONFIG_PM_ADVANCED_DEBUG is not set
>   # CONFIG_APM_EMULATION is not set

  ? Symbol: PM [=y]
    ? Type  : bool
    ? Prompt: Device power management core functionality
    ?   Location:
    ? (1) -> Power management options
    ?   Defined at kernel/power/Kconfig:144
    ?   Selected by [y]:
    ?   - ARCH_OMAP2PLUS_TYPICAL [=y] && (ARCH_MULTI_V6 [=y] ||
  ARCH_MULTI_V7 ?

-> you need to disable OMAP2PLUS_TYPICAL.

> --- 2320,2325 ----
> ***************
> *** 5469,5476 ****
>   CONFIG_DEBUG_SPINLOCK=y
>   CONFIG_DEBUG_MUTEXES=y
>   CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> 
> *! CONFIG_DEBUG_LOCK_ALLOC=y <<== (should be #
> CONFIG_DEBUG_LOCK_ALLOC is

  ? Symbol: DEBUG_LOCK_ALLOC [=y]
    ? Type  : bool
    ? Prompt: Lock debugging: detect incorrect freeing of live locks
    ?   Location:
    ?     -> Kernel hacking
    ? (1)   -> Lock Debugging (spinlocks, mutexes, etc...)
    ?   Defined at lib/Kconfig.debug:1163
    ?   Depends on: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
    ?   Selects: DEBUG_SPINLOCK [=y] && DEBUG_MUTEXES [=y] &&
  DEBUG_RT_MUTEXE ?
    ?   Selected by [y]:
    ?   - DEBUG_WW_MUTEX_SLOWPATH [=y] && DEBUG_KERNEL [=y] &&
  LOCK_DEBUGGING ?

You need to disable DEBUG_WW_MUTEX_SLOWPATH AFAICT.


								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190721/a673a7c7/attachment.sig>

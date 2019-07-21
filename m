From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Sun, 21 Jul 2019 19:58:40 +0200
Subject: [cip-dev] Request for guidance: removal of old config files
 [was: Kernel configurations for 4.19?]
In-Reply-To: <20190721162559.GB10770@amd>
References: <1555501985.3557.26.camel@codethink.co.uk>
	<9210b0ba912e7a8c64f6562b43f25e4763ac4379.camel@codethink.co.uk>
	<7c8d175eaa43357d6484c6fee89c4d0f@codethink.co.uk>
	<909b4353-87c9-08e2-46f1-4ef8ce3fb6d2@siemens.com>
	<fae9b423882c15f5e31eaef237086f38055dcfce.camel@codethink.co.uk>
	<20190721162559.GB10770@amd>
Message-ID: <CAEss1EJ7oLR+hVwtmvB1L5yjyaL5fiW0nuCCbwgANv39u=y1Jg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

>> Good point.  I have not yet tried running 4.19 on the BBB, but I can
>> look at adding one - or perhaps Nobuhiro or Pavel already has a
>> suitable config?

Excellent point, which spares me time to begin the new email thread
about 4.19 BBB rt-config file.

Actually, I have one 4.19 BBB rt-config file, which at the end of trimming
goes to cycles (not able to set three parameters).

git clone git://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
cd linux-cip
*git checkout -b cip_v4.19.13-cip1-rt1-rebase v4.19.13-cip1-rt1-rebase*
export TREE_NAME=cip-example
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
make -j4 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
omap2plus_defconfig

I did adjust all the RT parameters, and at the end of three cycles of
compiling, I've got the following CONFIG file (attached to this email).

My problem is, that I ended with cyclic loop, since every time I start
compiling with:
make -j4 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm

I end up with changed .config, with always three parameters changed:

vagrant at stretch:~/git-repos/linux-cip/build-arm$ diff -c .config CONFIG
*** .config 2019-07-21 17:31:28.524419156 +0000
--- CONFIG 2019-07-20 18:29:58.349570260 +0000
***************
*** 73,78 ****
--- 73,79 ----
  # Timers subsystem
  #
  CONFIG_TICK_ONESHOT=y
+ CONFIG_NO_HZ_COMMON=y
  CONFIG_HZ_PERIODIC=y
  # CONFIG_NO_HZ_IDLE is not set
  # CONFIG_NO_HZ is not set
***************
*** 585,591 ****
  #
  # CONFIG_SUSPEND is not set
  # CONFIG_HIBERNATION is not set
*! CONFIG_PM=y <<== (should be # CONFIG_PM is not set)*
  CONFIG_PM_DEBUG=y
  # CONFIG_PM_ADVANCED_DEBUG is not set
  # CONFIG_APM_EMULATION is not set
--- 586,592 ----
  #
  # CONFIG_SUSPEND is not set
  # CONFIG_HIBERNATION is not set
! # CONFIG_PM is not set
  CONFIG_PM_DEBUG=y
  # CONFIG_PM_ADVANCED_DEBUG is not set
  # CONFIG_APM_EMULATION is not set
***************
*** 2319,2325 ****
  # CONFIG_HSI_CHAR is not set
  CONFIG_PPS=y
  # CONFIG_PPS_DEBUG is not set
- CONFIG_NTP_PPS=y

  #
  # PPS clients support
--- 2320,2325 ----
***************
*** 5469,5476 ****
  CONFIG_DEBUG_SPINLOCK=y
  CONFIG_DEBUG_MUTEXES=y
  CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y

*! CONFIG_DEBUG_LOCK_ALLOC=y <<== (should be # CONFIG_DEBUG_LOCK_ALLOC is
not set)! CONFIG_LOCKDEP=y<<== (should be # CONFIG_LOCKDEP is not set)*
  # CONFIG_DEBUG_LOCKDEP is not set
  CONFIG_DEBUG_ATOMIC_SLEEP=y
  # CONFIG_LOCK_TORTURE_TEST is not set
--- 5469,5476 ----
  CONFIG_DEBUG_SPINLOCK=y
  CONFIG_DEBUG_MUTEXES=y
  CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
! # CONFIG_DEBUG_LOCK_ALLOC is not set
! # CONFIG_LOCKDEP is not set
  # CONFIG_DEBUG_LOCKDEP is not set
  CONFIG_DEBUG_ATOMIC_SLEEP=y
  # CONFIG_LOCK_TORTURE_TEST is not set

What I am doing/setting wrong here???

Thank you,
Zoran
_______

On Sun, Jul 21, 2019 at 6:26 PM Pavel Machek <pavel@denx.de> wrote:

> On Fri 2019-07-12 17:34:47, Ben Hutchings wrote:
> > On Thu, 2019-07-11 at 18:51 +0200, Jan Kiszka wrote:
> > [...]
> > > > 4.19/arm/hitachi_omap_defconfig
> > > > 4.19/arm/moxa_mxc_defconfig
> > > > 4.19/arm/siemens_am335x-axm2_defconfig
> > > > 4.19/arm/siemens_am335x-draco_defconfig
> > > > 4.19/arm/siemens_am335x-dxr2_defconfig
> > > > 4.19/arm/siemens_am335x-etamin_defconfig
> > > > 4.19/arm/siemens_am57xx-pxm3_defconfig
> > >
> > > Those can go, I'm not aware of their usage on 4.19. But do we have one
> for the
> > > am335-x-based BBB, our reference board?
> >
> > Good point.  I have not yet tried running 4.19 on the BBB, but I can
> > look at adding one - or perhaps Nobuhiro or Pavel already has a
> > suitable config?
>
> No easy access to BBB here, sorry.
>
> I have added directory 4.19-rt and added config for socfpga I'd like
> to be used for testing in Lava lab. It is not configuration that needs
> to be officially supported with CIP project.
>
> I hope that is okay.
>
> If someone uses rt on some other hardware, I'd like to know.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190721/44c16205/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: CONFIG
Type: application/octet-stream
Size: 144082 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190721/44c16205/attachment-0001.obj>

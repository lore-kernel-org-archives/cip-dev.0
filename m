From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Wed, 24 Apr 2019 01:23:43 +0000
Subject: [cip-dev] EFIBootGuard for CIP and SecureBoot
In-Reply-To: <20190422175446.GO4664@bill-the-cat>
References: <CAHFG_=Ujd5m3uSq87MuiK-7HWM379GoJjTQ3HMvk_m8V0gzqMg@mail.gmail.com>
	<20190422175446.GO4664@bill-the-cat>
Message-ID: <OSAPR01MB3763A83FABF505EC4E0A5534D03C0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Francois, Jan, Christian, and all

Sorry for the late reply, I was waiting for the administrator of the Boot Architecture mailing list to accept my subscription request, but it seems it will take a bit more time. I will send this reply and hope it will not be blocked. I have also added the u-boot mailing list to Cc, as Tom suggested (although I'm not a member), the CIP mailing list, Jan Kiszka (one of the main developers of Efibootguard) and Christian (an expert in software updates).

Background: during the last Linaro connect in Bangkok I was told that Linaro Edge (LEDGE) were working on a secure software update mechanism based on UEFI capsules that would flash firmware updates from a UEFI application, instead of using a Linux agent such as SWUpdate. Then, I had an online meeting with Francois, director of LEDGE. I explained to Francois that in CIP we are using the Linux agent approach right now, and we are also considering the use of a UEFI application (Efibootguard) to arm a watchdog and deal with the state-machine variables (installed, testing, ok, failed..) needed for A/B software updates. Efibootguard sounds like an excellent place to collaborate with Linaro (particularly on the watchdog drivers front) because it does not strictly depend on where the firmware is flashed (UEFI capsule or Linux agent). 

> On Fri, Apr 19, 2019 at 12:48:51PM +0200, Francois Ozog wrote:
> > Hi Daniel,
> >
> > We will be conducting a UEFI gap analysis to support EFIBootGuard in U-Boot.
> >
> > As we are working on UEFI SecureBoot implementation in U-Boot, how do
> > you expect the boot process to be secured? Would U-Boot UEFI
> > SecureBoot verify EFIBootGuard signature and in turn EFIBootGuard will
> > check either grub or Linux signature?
> >
> > Please elaborate on your vision of a secured boot process.

Efibootguard is composed of two parts.
  - A UEFI application that can arm a watchdog and decide what environment (kernel, boot args, etc.) to use next depending on a set of variables (update status, highest revision, etc.) stored in FAT16 partitions.
  - A Linux application that can read and set those variables from Linux (similar to u-boot's fw_setenv). This functionality is also available in the form of a library.

As far as I know, there is no concept of "Secure Booting" in Efibootguard at the moment. Adding signature checks before booting into the selected kernel would be a possible solution. 

Thanks,
Daniel

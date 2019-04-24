From: Grant.Likely@arm.com (Grant Likely)
Date: Wed, 24 Apr 2019 09:45:22 +0000
Subject: [cip-dev] EFIBootGuard for CIP and SecureBoot
In-Reply-To: <OSAPR01MB3763A83FABF505EC4E0A5534D03C0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
References: <CAHFG_=Ujd5m3uSq87MuiK-7HWM379GoJjTQ3HMvk_m8V0gzqMg@mail.gmail.com>
	<20190422175446.GO4664@bill-the-cat>
	<OSAPR01MB3763A83FABF505EC4E0A5534D03C0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <2b920228-fe1d-5237-d8e3-d22b13223cd0@arm.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 24/04/2019 02:23, daniel.sangorrin at toshiba.co.jp wrote:
> Hello Francois, Jan, Christian, and all
> 
> Sorry for the late reply, I was waiting for the administrator of the Boot Architecture mailing list to accept my subscription request, but it seems it will take a bit more time. I will send this reply and hope it will not be blocked. I have also added the u-boot mailing list to Cc, as Tom suggested (although I'm not a member), the CIP mailing list, Jan Kiszka (one of the main developers of Efibootguard) and Christian (an expert in software updates).

Hmmm, that's weird. The boot-architecture list doesn't require approval 
to subscribe. It just requires confirmation of email address. I think 
there is a problem with lists.linaro.org. I'll send an IT support 
request to Linaro.

Regardless, I've approved this post and added you to the allowed senders 
list. You can post freely. :-)

g.

> Background: during the last Linaro connect in Bangkok I was told that Linaro Edge (LEDGE) were working on a secure software update mechanism based on UEFI capsules that would flash firmware updates from a UEFI application, instead of using a Linux agent such as SWUpdate. Then, I had an online meeting with Francois, director of LEDGE. I explained to Francois that in CIP we are using the Linux agent approach right now, and we are also considering the use of a UEFI application (Efibootguard) to arm a watchdog and deal with the state-machine variables (installed, testing, ok, failed..) needed for A/B software updates. Efibootguard sounds like an excellent place to collaborate with Linaro (particularly on the watchdog drivers front) because it does not strictly depend on where the firmware is flashed (UEFI capsule or Linux agent).
> 
>> On Fri, Apr 19, 2019 at 12:48:51PM +0200, Francois Ozog wrote:
>>> Hi Daniel,
>>>
>>> We will be conducting a UEFI gap analysis to support EFIBootGuard in U-Boot.
>>>
>>> As we are working on UEFI SecureBoot implementation in U-Boot, how do
>>> you expect the boot process to be secured? Would U-Boot UEFI
>>> SecureBoot verify EFIBootGuard signature and in turn EFIBootGuard will
>>> check either grub or Linux signature?
>>>
>>> Please elaborate on your vision of a secured boot process.
> 
> Efibootguard is composed of two parts.
>    - A UEFI application that can arm a watchdog and decide what environment (kernel, boot args, etc.) to use next depending on a set of variables (update status, highest revision, etc.) stored in FAT16 partitions.
>    - A Linux application that can read and set those variables from Linux (similar to u-boot's fw_setenv). This functionality is also available in the form of a library.
> 
> As far as I know, there is no concept of "Secure Booting" in Efibootguard at the moment. Adding signature checks before booting into the selected kernel would be a possible solution.
> 
> Thanks,
> Daniel
> 
> 
> 
> _______________________________________________
> boot-architecture mailing list
> boot-architecture at lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/boot-architecture
> 

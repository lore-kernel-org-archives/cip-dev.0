From: Smita_Gumansingh@mentor.com (Gumansingh, Smita)
Date: Tue, 17 Dec 2019 08:05:02 +0000
Subject: [cip-dev] Adding Siemens boards to CI testing
In-Reply-To: <TYAPR01MB2285C105CCF91DF61645F01AB7510@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB228536EF584C469150BE786FB75F0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <39e8de29aec84a9db8bbe8703e2f823c@svr-ies-mbx-02.mgc.mentorg.com>
 <TYAPR01MB2285278C8C6A479562382389B7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <13225eb301be4894b3fc58684ff13e46@SVR-IES-MBX-03.mgc.mentorg.com>
 <TYAPR01MB2285871C9AB54A47A77C65B4B7550@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <8f42ecc9d77f4534bde446bbcc666f1e@SVR-IES-MBX-03.mgc.mentorg.com>
 <TYAPR01MB2285CE6D21A9211CCB097E5AB7510@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <e8be4bf4713a4365a051749859f91768@SVR-IES-MBX-03.mgc.mentorg.com>
 <TYAPR01MB2285C105CCF91DF61645F01AB7510@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <99bbf83b83c6417aa0ffff24427066b5@svr-ies-mbx-02.mgc.mentorg.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi All,

Our lab (lab-cip-mentor)  is up and running. Health-check jobs on both targets are also completed.

Thanks,
Smita

From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
Sent: 16 December 2019 16:39
To: Bhola, Bikram <Bikram_Bhola@mentor.com>; Gumansingh, Smita <Smita_Gumansingh@mentor.com>; Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan@mentor.com>
Subject: RE: Adding Siemens boards to CI testing

No worries, thank you Bikram.

Please feed free to update cip-dev (see my email on Friday) once it's up and running again.

Kind regards, Chris

From: Bhola, Bikram <Bikram_Bhola at mentor.com<mailto:Bikram_Bhola@mentor.com>>
Sent: 16 December 2019 11:07
To: Chris Paterson <Chris.Paterson2 at renesas.com<mailto:Chris.Paterson2@renesas.com>>; Gumansingh, Smita <Smita_Gumansingh at mentor.com<mailto:Smita_Gumansingh@mentor.com>>; Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan at mentor.com<mailto:Vijaikumar_Kanagarajan@mentor.com>>
Subject: RE: Adding Siemens boards to CI testing

Hi Chris,

We got an issue with one of  the network switch configuration that we are trying to fix. I will keep you posted the progress  by eod.

Regards,
Bikram

From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
Sent: 16 December 2019 15:52
To: Bhola, Bikram <Bikram_Bhola at mentor.com<mailto:Bikram_Bhola@mentor.com>>; Gumansingh, Smita <Smita_Gumansingh at mentor.com<mailto:Smita_Gumansingh@mentor.com>>; Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan at mentor.com<mailto:Vijaikumar_Kanagarajan@mentor.com>>
Subject: RE: Adding Siemens boards to CI testing

Hello Bikram,

Did the maintenance go okay in the end?

I see that your lab is still 'offline'?

Kind regards, Chris

From: Bhola, Bikram <Bikram_Bhola at mentor.com<mailto:Bikram_Bhola@mentor.com>>
Sent: 13 December 2019 08:06
To: Chris Paterson <Chris.Paterson2 at renesas.com<mailto:Chris.Paterson2@renesas.com>>; Gumansingh, Smita <Smita_Gumansingh at mentor.com<mailto:Smita_Gumansingh@mentor.com>>; Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan at mentor.com<mailto:Vijaikumar_Kanagarajan@mentor.com>>
Subject: RE: Adding Siemens boards to CI testing

Hi Chris,

To let you know that, our office here will undergo electrical power maintenance by building management. This will affect the CIP Lava setup during that time. It should come up automatically after the maintenance. Incase not, we will have a look from engineering side on Monday.

WHEN:

Saturday  -14th DEC 6.00 AM  to Saturday -14th Dec 06:00 PM

WHO/WHAT IS AFFECTED:
Network (WAN/LAN/Wi-Fi) connectivity
Phone Services
Servers, Storage and client devices will be powered off
HVAC services
Power services to office


Regards,
Bikram

From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
Sent: 12 December 2019 20:39
To: Bhola, Bikram <Bikram_Bhola at mentor.com<mailto:Bikram_Bhola@mentor.com>>; Gumansingh, Smita <Smita_Gumansingh at mentor.com<mailto:Smita_Gumansingh@mentor.com>>; Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan at mentor.com<mailto:Vijaikumar_Kanagarajan@mentor.com>>
Subject: RE: Adding Siemens boards to CI testing

Hello Bikram,

As it happens, I have managed to get the bzImage booting in the LAVA lab.
The missing ingredient was that the Ethernet driver (CONFIG_IGB) was configured as a module, not built into the Kernel.

You can see a working test run here:
https://lava.ciplatform.org/scheduler/job/8267

I'm just about to submit a pull request to cip-kernel-config to add this config setting.

Please let me know if you have any further feedback.

Kind regards, Chris

From: Bhola, Bikram <Bikram_Bhola at mentor.com<mailto:Bikram_Bhola@mentor.com>>
Sent: 12 December 2019 15:02
To: Chris Paterson <Chris.Paterson2 at renesas.com<mailto:Chris.Paterson2@renesas.com>>; Gumansingh, Smita <Smita_Gumansingh at mentor.com<mailto:Smita_Gumansingh@mentor.com>>; Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan at mentor.com<mailto:Vijaikumar_Kanagarajan@mentor.com>>
Subject: RE: Adding Siemens boards to CI testing

Hi Chris,

Please see my comments inline.

Regards,
Bikram

-----Original Message-----
From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
Sent: 09 December 2019 14:00
To: Gumansingh, Smita <Smita_Gumansingh at mentor.com<mailto:Smita_Gumansingh@mentor.com>>
Cc: Bhola, Bikram <Bikram_Bhola at mentor.com<mailto:Bikram_Bhola@mentor.com>>
Subject: RE: Adding Siemens boards to CI testing

Hello Smita,

Thank you for the feedback.

> From: Gumansingh, Smita <Smita_Gumansingh at mentor.com<mailto:Smita_Gumansingh@mentor.com>>
> Sent: 09 December 2019 08:14
>
> Hi Chris,
> Yes I have seen this issue for x86 board when target boots from NFS
> without initrd due to missing of Ethernet kernel modules and some
> other configs in rootfs .

At the moment I'm using the same RFS are you're using in the healthchecks [2].
How was this RFS generated? Is there support for the Simatic board in CIP Core?
Does CIP Core include the relevant modules/configuration?

[2] https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-lava/rfs/rootfs-simatic-ipc227e.tar.gz

[Bikram] The missing kernel configs are added during a custom QA build and made it available part of the RFS. Also isar-siemens maintains its local copy of kernel configs and yet to sync fully with CIP core. We will double check these needed kernel configs part of cip core and let you know.

> Simatic board works fine when initrd included with vmlinuz .

Ideally I'd like to use bzImage, as this is what the current CI process is producing.

But if we need to use vmlinuz instead then I can find a way.
However I'm new to x86, could you describe how to create this? It doesn't look like there is a vmlinuz target in the Makefiles.
[Bikram] Can you please let us know how you are making the bzImage and corresponding source sample. We may have to do some trials to make the vmlinuz accordingly. Looks like X86 grub doesn't support bzImage.

>
> For functionality testing generally we use initrd, vmlinuz and rootfs
> for Siemens Simatic Ipc227E board boot up in our LAVA server.
>
> To boot board without initrd for health-check jobs I have added these
> extra configs in kernel configuration file

Is there a reason why these aren't included in [3]?

[3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/blob/master/4.19.y-cip/x86/siemens_ipc227e_defconfig
[Bikram] Yes, we are looking to make these configs part of it.
Kind regards, Chris

> ======================
> CONFIG_ELFCORE=y
> CONFIG_IP_ROUTE_CLASSID=y
> CONFIG_PACKET_DIAG=m
> CONFIG_UNIX_DIAG=m
> CONFIG_XFRM_ALGO=y
> CONFIG_XFRM_IPCOMP=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
>
> CONFIG_EXT4_FS=y
> CONFIG_NFS_SWAP=y
> CONFIG_NFS_V4_1=y
> CONFIG_IGB=y
> CONFIG_IXGB=y
> CONFIG_IXGBE=y
> CONFIG_IXGBE_HWMON=y
> CONFIG_IXGBE_DCB=y
> CONFIG_I40E=y
> CONFIG_I40E_DCB=y
> ====================
>
> Regards,
> Smita
>
> -----Original Message-----
> From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
> Sent: 06 December 2019 19:55
> To: Gumansingh, Smita <Smita_Gumansingh at mentor.com<mailto:Smita_Gumansingh@mentor.com>>
> Cc: Bhola, Bikram <Bikram_Bhola at mentor.com<mailto:Bikram_Bhola@mentor.com>>
> Subject: Adding Siemens boards to CI testing
>
> Hello Smita,
>
> This morning I started adding support for the x86 and
> Altera-Terasic-Deo-
> Nano-01 boards to CIP's CI setup.
> The builds are working fine [0], but when I try to boot the x86 board
> in the LAVA lab it has an error where the RFS won't mount [1].
>
> Have you seen this issue before? Any ideas?
> The only difference I can see is that I'm using a bzImage instead of vmlinuz.
>
> [0]
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/10114578
> 8 [1] https://lava.ciplatform.org/scheduler/job/8121
>
> Kind regards, Chris


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191217/ffe010cd/attachment-0001.html>

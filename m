From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Fri, 15 Mar 2019 09:48:56 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <375b3b16-8688-6fb2-4d4b-fc130c501c7e@siemens.com>
References: <HK0PR01MB297958B4B49D80F30DD800D9E24B0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<OSAPR01MB37633BA45B40D16877229C51D04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<375b3b16-8688-6fb2-4d4b-fc130c501c7e@siemens.com>
Message-ID: <TY2PR01MB5146389CBF352FDC6F104262D9440@TY2PR01MB5146.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

> On 14.03.19 08:26, daniel.sangorrin at toshiba.co.jp wrote:
> > - Suzuki-san has found a couple of issues in ISAR CIP Core.
> >    - when building ISAR for the beaglebone black it complains that
> "/debootstrap/debootstrap is not found" (or something like that). He will
> post a new issue on the Gitlab web page with the complete log.
> 
> Has this been resolved locally?
When I tried to build isar-cip-core on another 2 machines, the error didn't occur.
So, my machine which occurred the error may have some problem.
I will check it when I have the time.

Best regards,
Suzuki

---
Akihiro Suzuki
Corporate Software Engineering & Technology Center
Toshiba Corporation
Tel: +81-44-549-2476
E-mail: akihiro27.suzuki at toshiba.co.jp 

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Jan Kiszka
> Sent: Friday, March 15, 2019 6:24 PM
> To: sangorrin daniel(????? ???? ????????)
> <daniel.sangorrin@toshiba.co.jp>; SZ.Lin at moxa.com;
> cip-dev at lists.cip-project.org; Christian Storm
> <christian.storm@siemens.com>
> Subject: Re: [cip-dev] CIP IRC weekly meeting today
> 
> On 14.03.19 08:26, daniel.sangorrin at toshiba.co.jp wrote:
> > - Suzuki-san has found a couple of issues in ISAR CIP Core.
> >    - when building ISAR for the beaglebone black it complains that
> "/debootstrap/debootstrap is not found" (or something like that). He will
> post a new issue on the Gitlab web page with the complete log.
> 
> Has this been resolved locally?
> 
> >    - after building ISAR for qemu succesfully, he tried to run
> start-qemu.sh x86_64 and there was an issue with --nographics that
> required to add ttyS0 (or something like that) to the qemu parameters.
> He will be sending a patch soon.
> 
> Thanks, already commented.
> 
> > [Note] we are planning to develop the SWUpdate demo using ISAR, any
> advice or news about how to build SWUpdate on ISAR with the right U-Boot
> environment?
> >
> > - Regarding SWUpdate we hit an issue that we had not expected before.
> Suzuki-san was trying to update the standard BBB debian image (or a
> yocto-made one), but there were many warnings about orphan nodes etc.
> After some investigation the reason seems to be that the rootfs is modified
> during the first boot (or something like that). This is probably one of
> the biggest problems with updating images instead of files.
> 
> Christian, any remarks?
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

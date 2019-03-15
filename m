From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 15 Mar 2019 10:24:29 +0100
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <OSAPR01MB37633BA45B40D16877229C51D04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
References: <HK0PR01MB297958B4B49D80F30DD800D9E24B0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
	<OSAPR01MB37633BA45B40D16877229C51D04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <375b3b16-8688-6fb2-4d4b-fc130c501c7e@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 14.03.19 08:26, daniel.sangorrin at toshiba.co.jp wrote:
> - Suzuki-san has found a couple of issues in ISAR CIP Core.
>    - when building ISAR for the beaglebone black it complains that "/debootstrap/debootstrap is not found" (or something like that). He will post a new issue on the Gitlab web page with the complete log.

Has this been resolved locally?

>    - after building ISAR for qemu succesfully, he tried to run start-qemu.sh x86_64 and there was an issue with --nographics that required to add ttyS0 (or something like that) to the qemu parameters. He will be sending a patch soon.

Thanks, already commented.

> [Note] we are planning to develop the SWUpdate demo using ISAR, any advice or news about how to build SWUpdate on ISAR with the right U-Boot environment?
> 
> - Regarding SWUpdate we hit an issue that we had not expected before. Suzuki-san was trying to update the standard BBB debian image (or a yocto-made one), but there were many warnings about orphan nodes etc. After some investigation the reason seems to be that the rootfs is modified during the first boot (or something like that). This is probably one of the biggest problems with updating images instead of files.

Christian, any remarks?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

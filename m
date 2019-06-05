From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 5 Jun 2019 07:51:58 +0200
Subject: [cip-dev] porting iwg20m to isar-cip-core
In-Reply-To: <TY2PR01MB3323430BEC5CEDF3D6EA34EDD0160@TY2PR01MB3323.jpnprd01.prod.outlook.com>
References: <20190605021645.4464-1-daniel.sangorrin@toshiba.co.jp>
	<TY2PR01MB3323430BEC5CEDF3D6EA34EDD0160@TY2PR01MB3323.jpnprd01.prod.outlook.com>
Message-ID: <e14436b8-7649-1104-9371-f094b03f09a9@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 05.06.19 07:34, daniel.sangorrin at toshiba.co.jp wrote:
>> I tried to add a recipe for iwg20m's u-boot. That board
>> only supports version 2013.01 and does not support distro boot.
> [snip]
>> As for the kernel image location, since we do not have u-boot
>> distro support I will move it manually from the root partition
>> to the boot partition using a postinstall script inside the
>> customizations recipe. If there is a better option please
>> let me know.
> 
> OK, I figured it out. I just had to define KERNEL_IMAGE="zImage" (so that it gets deployed) and then add that variable to IMAGE_BOOT_FILES.
> 

I would definitely recommend following the pre-existing pattern as they are 
working on a lot of different boards already. Primarily on ARMv8 (where most 
things are much better), but also on quite a few ARMv7 boards. That will avoid 
having to invent too much board-specific things over and over again.

Missing distro boot is a PITA, I know, but the best workaround is specifying 
what missing command the user should inject into the legacy U-Boot so that it 
loads the boot.scr from the rootfs and has the required board-specific env vars 
set. If you can even rebuild the U-Boot, you may also inject those commands into 
the default env, just by enhancing the defconfig.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

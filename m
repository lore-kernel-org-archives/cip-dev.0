From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Wed, 5 Jun 2019 05:34:51 +0000
Subject: [cip-dev] porting iwg20m to isar-cip-core
In-Reply-To: <20190605021645.4464-1-daniel.sangorrin@toshiba.co.jp>
References: <20190605021645.4464-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <TY2PR01MB3323430BEC5CEDF3D6EA34EDD0160@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> I tried to add a recipe for iwg20m's u-boot. That board
> only supports version 2013.01 and does not support distro boot.
[snip]
> As for the kernel image location, since we do not have u-boot
> distro support I will move it manually from the root partition
> to the boot partition using a postinstall script inside the
> customizations recipe. If there is a better option please
> let me know.

OK, I figured it out. I just had to define KERNEL_IMAGE="zImage" (so that it gets deployed) and then add that variable to IMAGE_BOOT_FILES.

Thanks,
Daniel

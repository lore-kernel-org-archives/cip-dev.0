From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 6 Jun 2019 08:17:57 +0000
Subject: [cip-dev] [PATCH] iwg20m: add support for this board
In-Reply-To: <0b70c8f4-9ca2-1ef6-d1a3-826dc71d5a96@siemens.com>
References: <Add support for iwg20m to ISAR CIP Core>
	<20190606020204.25320-1-daniel.sangorrin@toshiba.co.jp>
	<20190606020204.25320-2-daniel.sangorrin@toshiba.co.jp>
	<0b70c8f4-9ca2-1ef6-d1a3-826dc71d5a96@siemens.com>
Message-ID: <TY2PR01MB332378867EA4864E50DF494AD0170@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> Does the pre-installed u-boot support ext4? 

ext4load seems to be available on the u-boot command line.

>If yes, why not using u-boot-script
> and loading /boot/boot.scr instead? 

After loading boot.scr, don't we need the "source" command to work? "source" does not seem to be configured in the pre-installed u-boot.

Also, to create boot.scr we need mkimage. I wonder if modern Debian u-boot-tools' mkimage will create a boot.scr that is compatible with the pre-installed u-boot (remember that I couldn't build the old u-boot with the new compilers).

> That would avoid duplicating information
> like partitioning and kernel parameters here.

I guess, I can just load the image with ext4load instead of fatload. Not sure why the original instructions required two partitions then..

Thanks,
Daniel

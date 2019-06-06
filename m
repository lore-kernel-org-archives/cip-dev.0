From: ch@denx.de (Claudius Heine)
Date: Thu, 6 Jun 2019 10:26:46 +0200
Subject: [cip-dev] [PATCH] iwg20m: add support for this board
In-Reply-To: <TY2PR01MB332378867EA4864E50DF494AD0170@TY2PR01MB3323.jpnprd01.prod.outlook.com>
References: <Add support for iwg20m to ISAR CIP Core>
	<20190606020204.25320-1-daniel.sangorrin@toshiba.co.jp>
	<20190606020204.25320-2-daniel.sangorrin@toshiba.co.jp>
	<0b70c8f4-9ca2-1ef6-d1a3-826dc71d5a96@siemens.com>
	<TY2PR01MB332378867EA4864E50DF494AD0170@TY2PR01MB3323.jpnprd01.prod.outlook.com>
Message-ID: <1319553a-38d0-a4f1-0590-7c6f71d9fbd2@denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 06/06/2019 10.17, daniel.sangorrin at toshiba.co.jp wrote:
>> If yes, why not using u-boot-script
>> and loading /boot/boot.scr instead? 
> 
> After loading boot.scr, don't we need the "source" command to work? "source" does not seem to be configured in the pre-installed u-boot.
> 
> Also, to create boot.scr we need mkimage. I wonder if modern Debian u-boot-tools' mkimage will create a boot.scr that is compatible with the pre-installed u-boot (remember that I couldn't build the old u-boot with the new compilers).

You could just use the mkimage that comes from your u-boot source to be
certain. I do something similar [1] since the upstream debian
u-boot-tools do not support creating signed fit images.

[1] https://github.com/ilbers/isar/blob/master/meta/classes/fit-img.bbclass

regards,
Claudius

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch at denx.de

           PGP key: 6FF2 E59F 00C6 BC28 31D8 64C1 1173 CB19 9808 B153
                             Keyserver: hkp://pool.sks-keyservers.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190606/e6eee702/attachment.sig>

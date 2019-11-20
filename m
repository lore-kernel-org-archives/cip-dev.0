From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 10:50:38 +0000
Subject: [cip-dev]  Renesas changes pending in v4.19.85-rc
Message-ID: <OSBPR01MB2103EB881B676F54F3DB47FBB84F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Pavel,

Thanks for the feedback.



>Hi!



> v4.19.85-rc (available at

>git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git

>)



>contains at least 6 patches that look relevant to Renesas

>boards. They look ok to me, but you know more about Renesas hardware

>than i do, and maybe second set of eyes would be useful. (Also... you

>will not have to backport these :-) )



> | e80fc88a837a 441f61e3aa9e | ARM: dts: rcar: Correct SATA device sizes to 2 MiB

> | fd2d5f44efa2 e3da41a6c28f | arm64: dts: renesas: salvator-common: adv748x: Override secondary addresses

> | 0872c56d9d73 4d76ad7d9de0 | arm64: dts: renesas: r8a77965: Attach the SYS-DMAC to the IPMMU

> | 3d9c5d05904b 99584d93e301 | arm64: dts: renesas: r8a77965: Fix HS-USB compatible

> | 070df3e61d15 7a590fe31748 | arm64: dts: renesas: r8a77965: Fix clock/reset for usb2_phy1

> | f2ecd2865105 09938ea9d136 | phy: renesas: rcar-gen3-usb2: fix vbus_ctrl for role sysfs

The first 5 patches is rcar specific. So it is better to have.

The last patch needed for RZ/G2[MNE] boards.

Regards,
Biju
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191120/c442013f/attachment-0001.html>

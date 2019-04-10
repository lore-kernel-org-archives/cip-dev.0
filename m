From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 10 Apr 2019 06:41:30 +0000
Subject: [cip-dev] [PATCH 4.19.y 6/9] arm64: dts: renesas: r8a774c0: Add
 I2C and IIC-DVFS support
In-Reply-To: <20190409205446.GB3845141@pollux.denx.de>
References: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
	<1553688789-43441-7-git-send-email-biju.das@bp.renesas.com>
	<20190409205446.GB3845141@pollux.denx.de>
Message-ID: <OSBPR01MB2103CD65B57B09337CA1AB62B82E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 4.19.y 6/9] arm64: dts: renesas: r8a774c0: Add
> I2C and IIC-DVFS support
> 
> On Wed 2019-03-27 12:13:06, Biju Das wrote:
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > Add the I2C[0-7] and IIC Bus Interface for DVFS (IIC for DVFS) devices
> > nodes to the r8a774c0 device tree.
> 
> This fails for me, because arch/arm64/boot/dts/renesas/r8a774c0.dtsi does
> not yet exist.

This patch "arm64: dts: renesas: Initial device tree for r8a774c0" have "arch/arm64/boot/dts/renesas/r8a774c0.dtsi"

https://lists.cip-project.org/pipermail/cip-dev/2019-March/001917.html

Do you want me to send it again?

Regards,
Biju

From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 10 Apr 2019 08:09:14 +0000
Subject: [cip-dev] [PATCH 4.19.y 6/9] arm64: dts: renesas: r8a774c0: Add
 I2C and IIC-DVFS support
In-Reply-To: <OSBPR01MB2103CD65B57B09337CA1AB62B82E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
	<1553688789-43441-7-git-send-email-biju.das@bp.renesas.com>
	<20190409205446.GB3845141@pollux.denx.de>
	<OSBPR01MB2103CD65B57B09337CA1AB62B82E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB41897557B0EDE5243B6349B8922E0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Biju.

> This patch "arm64: dts: renesas: Initial device tree for r8a774c0" have
> "arch/arm64/boot/dts/renesas/r8a774c0.dtsi"
>
> https://lists.cip-project.org/pipermail/cip-dev/2019-March/001917.ht
> ml
> 
> Do you want me to send it again?

You do not need to send.
This patch has been reviewed and committed to linux-4.19.y-cip branch by me.

Best regards,
  Nobuhiro



> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> Sent: Wednesday, April 10, 2019 3:42 PM
> To: Pavel Machek <pavel@denx.de>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH 4.19.y 6/9] arm64: dts: renesas: r8a774c0:
> Add I2C and IIC-DVFS support
> 
> Hi Pavel,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [cip-dev] [PATCH 4.19.y 6/9] arm64: dts: renesas:
> > r8a774c0: Add I2C and IIC-DVFS support
> >
> > On Wed 2019-03-27 12:13:06, Biju Das wrote:
> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >
> > > Add the I2C[0-7] and IIC Bus Interface for DVFS (IIC for DVFS)
> > > devices nodes to the r8a774c0 device tree.
> >
> > This fails for me, because arch/arm64/boot/dts/renesas/r8a774c0.dtsi
> > does not yet exist.
> 
> This patch "arm64: dts: renesas: Initial device tree for r8a774c0" have
> "arch/arm64/boot/dts/renesas/r8a774c0.dtsi"
> 
> https://lists.cip-project.org/pipermail/cip-dev/2019-March/001917.ht
> ml
> 
> Do you want me to send it again?
> 
> Regards,
> Biju
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev

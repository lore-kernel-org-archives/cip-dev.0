From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 11 Apr 2019 06:54:51 +0000
Subject: [cip-dev] [PATCH 1/9] arm64: dts: renesas: r8a774c0: Add
 secondary	CA53 CPU core
In-Reply-To: <TYAPR01MB418999A8DD8304553CBF0204922E0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
References: <1553246370-60751-2-git-send-email-biju.das@bp.renesas.com>
	<TYAPR01MB418999A8DD8304553CBF0204922E0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB210351DFE8721A24FA116F50B82F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi Nobuhiro-San,

Thanks for the feedback.

Regards,
Biju

> -----Original Message-----
> From: nobuhiro1.iwamatsu at toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 11 April 2019 00:14
> To: Biju Das <biju.das@bp.renesas.com>; cip-dev at lists.cip-project.org
> Subject: RE: [cip-dev] [PATCH 1/9] arm64: dts: renesas: r8a774c0: Add
> secondary CA53 CPU core
> 
> Hi, Diju.
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org
> > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> > Sent: Friday, March 22, 2019 6:19 PM
> > To: cip-dev at lists.cip-project.org
> > Cc: Biju Das <biju.das@bp.renesas.com>
> > Subject: [cip-dev] [PATCH 1/9] arm64: dts: renesas: r8a774c0: Add
> > secondary CA53 CPU core
> >
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > Add a device node for the second Cortex-A53 CPU core on the Renesas
> > RZ/G2E (a.k.a r8a774c0) SoC, and adjust the interrupt delivery masks
> > for the ARM Generic Interrupt Controller and Architectured Timer.
> 
> I think that 'Architected Timer' is correct, not 'Architectured Timer'.
> If my point is correct, I will fix and apply the commit message.
> 
> Other patches are looks good to me.

I believe it is correct. see the link below.

https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/arch_timer.txt

Already the cherry-picked patch from upstream is reviewed by wider people.
So I believe it is not good to change the commit messages or ordering of patches.

We have upstreamed RZ/G2[ME] patches in specific order. So we expect the same order in cip kernel as well.
Like SoC definitions,SYSC,RST,CLK,Pinctrl , SoC DTSI,Board DTSI and the rest of the drivers.

We may be wrong. So please correct us if we are wrong.

Regards,
Biju

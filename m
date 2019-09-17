From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 13:06:45 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 23/32] arm64: dts: renesas:
 hihope-common: Declare pcie bus clock
In-Reply-To: <OSAPR01MB3234F47C461A87822432797F928F0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1568649046-17420-24-git-send-email-fabrizio.castro@bp.renesas.com>
	<OSAPR01MB3234F47C461A87822432797F928F0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <TY1PR01MB177098EF77342ED8E3A2BC0EC08F0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> From: nobuhiro1.iwamatsu at toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 17 September 2019 13:37
> Subject: RE: [cip-dev][PATCH 4.19.y-cip 23/32] arm64: dts: renesas: hihope-common: Declare pcie bus clock
> 
> Hi,
> 
> I can not merge this patch.
> 
> > -----Original Message-----
> > From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> > Sent: Tuesday, September 17, 2019 12:51 AM
> > To: cip-dev at lists.cip-project.org
> > Cc: iwamatsu nobuhiro(?? ?? ????????)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel at denx.de; Chris Paterson
> > <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>;
> > Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Subject: [cip-dev][PATCH 4.19.y-cip 23/32] arm64: dts: renesas:
> > hihope-common: Declare pcie bus clock
> >
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > commit 61e0505b162a3974663cc6d1dbec30268a7a03ea upstream.
> >
> > Declare pcie bus clock, since it is generated on the HiHope RZ/G2M main
> > board.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > ---
> >  arch/arm64/boot/dts/renesas/hihope-common.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
> > b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
> > index 77d183a..2a49bf1 100644
> > --- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
> > @@ -77,6 +77,10 @@
> >  	clock-frequency = <32768>;
> >  };
> >
> > +&pcie_bus_clk {
> > +	clock-frequency = <100000000>;
> > +};
> > +
> >  &pfc {
> >  	pinctrl-0 = <&scif_clk_pins>;
> >  	pinctrl-names = "default";
> 
> Please see:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/blob/linux-4.19.y-cip/arch/arm64/boot/dts/renesas/hihope-common.dtsi#L95
> 
> Please rebase from linux-4.19.y-cip/HEAD and resend this series.

Will do.

Thanks,
Fab

> 
> Best regards,
>   Nobuhiro

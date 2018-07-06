From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 6 Jul 2018 09:23:55 +0000
Subject: [cip-dev] [PATCH 12/86] ARM: dts: r8a7745: Add clocks
In-Reply-To: <1530823362.21552.1.camel@codethink.co.uk>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1530283167-14050-13-git-send-email-fabrizio.castro@bp.renesas.com>
	<1530823362.21552.1.camel@codethink.co.uk>
Message-ID: <TY1PR01MB17704D6670B07C08A690E410C0470@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

Thank you for your feedback.

> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 05 July 2018 21:43
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [cip-dev][PATCH 12/86] ARM: dts: r8a7745: Add clocks
>
> On Fri, 2018-06-29 at 15:38 +0100, Fabrizio Castro wrote:
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > Declare all core clocks and DIV6 clocks, as well as all MSTP clocks.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a7745.dtsi | 432 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 432 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
> > index 281ab59..5c50fd3 100644
> > --- a/arch/arm/boot/dts/r8a7745.dtsi
> > +++ b/arch/arm/boot/dts/r8a7745.dtsi
> [...]
> > +mstp2_clks: mstp2_clks at e6150138 {
> > +compatible = "renesas,r8a7743-mstp-clocks",
> > +     "renesas,cpg-mstp-clocks";
> > >
> [...]
>
> This and the following 9 device nodes have compatible =
> "renesas,r8a7743-mstp-clocks" which should presumably be
> "renesas,r8a7745-mstp-clocks".

Doh!
Thankfully you spotted this, we will send a v2 to fix this.


Thanks,
Fab

>
> Ben.
>
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

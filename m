From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 6 Jul 2018 10:00:41 +0000
Subject: [cip-dev] [PATCH 62/86] ARM: dts: r8a7745: Add operating-points
 to cpu0
In-Reply-To: <1530827145.21552.2.camel@codethink.co.uk>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1530283167-14050-63-git-send-email-fabrizio.castro@bp.renesas.com>
	<1530827145.21552.2.camel@codethink.co.uk>
Message-ID: <TY1PR01MB177068FF298F3D3A8BF0BE69C0470@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

Thank you for your feedback.

> Subject: Re: [cip-dev][PATCH 62/86] ARM: dts: r8a7745: Add operating-points to cpu0
>
> On Fri, 2018-06-29 at 15:39 +0100, Fabrizio Castro wrote:
> > shmobile_defconfig builds cpu freq into the kernel by default,
> > therefore we get error and warning messages at boot, when
> > hotplugging cpus, and when waking up from suspend to RAM.
> >
> > Although the r8a7745 SoC does not support DVFS, defining one
> > operating point makes cpu freq happy and therefore all of the
> > nasty messages disappear.
>
> Why was this not needed upstream?

Since there is a chance for the OPP to be registered dynamically the upstream kernel won't print error messages (only debug messages), as opposed to the CIP kernel which will print error messages. Have a look at 5b60697cd89cf5a438b2984e11859228e5ec1c6b.

Thanks,
Fab

>
> Ben.
>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a7745.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7745.dtsi
> > b/arch/arm/boot/dts/r8a7745.dtsi
> > index 077a28a..5f1cc84 100644
> > --- a/arch/arm/boot/dts/r8a7745.dtsi
> > +++ b/arch/arm/boot/dts/r8a7745.dtsi
> > @@ -29,6 +29,7 @@
> >  clock-frequency = <1000000000>;
> >  clocks = <&z2_clk>;
> >  next-level-cache = <&L2_CA7>;
> > +operating-points = <1000000 1000000>;
> >  };
> >
> >  cpu1: cpu at 1 {
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

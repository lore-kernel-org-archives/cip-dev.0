From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 14:38:48 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 08/17] ARM: dts: r8a7744: Add SMP
	support
In-Reply-To: <20191120143601.GA4940@duo.ucw.cz>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
 <1574175222-52858-9-git-send-email-biju.das@bp.renesas.com>
 <20191120143601.GA4940@duo.ucw.cz>
Message-ID: <OSBPR01MB21036B733D92772413ABF197B84F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

HI Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.4.y-cip 08/17] ARM: dts: r8a7744: Add SMP support
> 
> Hi!
> 
> > commit f1546da8a5c8862d1e66835affcfaf9a0c123abc upstream.
> >
> > Add DT node for the Advanced Power Management Unit (APMU), add the
> > second CPU core, and use "renesas,apmu" as "enable-method".
> >
> > Also add cpu1 phandle node to the PMU interrupt-affinity property.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > [biju: removed resets property. Updated power-domains and clocks
> > properties]
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a7744.dtsi | 38
> > ++++++++++++++++++++++++++++++++------
> >  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> 
> > +			clocks = <&cpg_clocks R8A7744_CLK_Z>;
> > +			clock-latency = <300000>; /* 300 us */
> > +			power-domains = <&cpg_clocks>;
> > +			next-level-cache = <&L2_CA15>;
> > +
> > +			/* kHz - uV - OPPs unknown yet */
> > +			operating-points = <1500000 1000000>,
> > +					   <1312500 1000000>,
> > +					   <1125000 1000000>,
> > +					   < 937500 1000000>,
> > +					   < 750000 1000000>,
> > +					   < 375000 1000000>;
> > +		};
> 
> Does this mean this is working progress and voltages will be lowered for
> lower frequencies as testing proceeds?

It supports only DFS not DVFS(ie, by controlling CPUFREQ register you can control the CPU frequency.)

Regards,
Biju

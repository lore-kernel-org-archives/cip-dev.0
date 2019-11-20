From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 14:55:19 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 08/17] ARM: dts: r8a7744: Add SMP
	support
In-Reply-To: <20191120144402.GC4940@duo.ucw.cz>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
 <1574175222-52858-9-git-send-email-biju.das@bp.renesas.com>
 <20191120143601.GA4940@duo.ucw.cz>
 <OSBPR01MB21036B733D92772413ABF197B84F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20191120144402.GC4940@duo.ucw.cz>
Message-ID: <OSBPR01MB210372DD404CA76A6B1FFF72B84F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, November 20, 2019 2:44 PM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev at lists.cip-project.org; Nobuhiro
> Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip 08/17] ARM: dts: r8a7744: Add SMP support
> 
> Hi!
> 
> > > > +			clock-latency = <300000>; /* 300 us */
> > > > +			power-domains = <&cpg_clocks>;
> > > > +			next-level-cache = <&L2_CA15>;
> > > > +
> > > > +			/* kHz - uV - OPPs unknown yet */
> > > > +			operating-points = <1500000 1000000>,
> > > > +					   <1312500 1000000>,
> > > > +					   <1125000 1000000>,
> > > > +					   < 937500 1000000>,
> > > > +					   < 750000 1000000>,
> > > > +					   < 375000 1000000>;
> > > > +		};
> > >
> > > Does this mean this is working progress and voltages will be lowered
> > > for lower frequencies as testing proceeds?
> >
> > It supports only DFS not DVFS(ie, by controlling CPUFREQ register you
> > can control the CPU frequency.)
> 
> If it does not support voltage scaling, is the /* kHz - uV - OPPs unknown yet
> */ comment up-to-date? Would something like /* hardware does not
> support voltage scaling */ be more useful?

Yes true. As per the manual,  " Automatic transmission for PMIC control (DVFS) is not available because the RZ/G series products do not
support the DVFS function". 

So we need to fix this upstream first and later backport to cip kernel.

Regards,
Biju

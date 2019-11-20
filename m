From: pavel@denx.de (Pavel Machek)
Date: Wed, 20 Nov 2019 15:44:03 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 08/17] ARM: dts: r8a7744: Add SMP
	support
In-Reply-To: <OSBPR01MB21036B733D92772413ABF197B84F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
 <1574175222-52858-9-git-send-email-biju.das@bp.renesas.com>
 <20191120143601.GA4940@duo.ucw.cz>
 <OSBPR01MB21036B733D92772413ABF197B84F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20191120144402.GC4940@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > +			clock-latency = <300000>; /* 300 us */
> > > +			power-domains = <&cpg_clocks>;
> > > +			next-level-cache = <&L2_CA15>;
> > > +
> > > +			/* kHz - uV - OPPs unknown yet */
> > > +			operating-points = <1500000 1000000>,
> > > +					   <1312500 1000000>,
> > > +					   <1125000 1000000>,
> > > +					   < 937500 1000000>,
> > > +					   < 750000 1000000>,
> > > +					   < 375000 1000000>;
> > > +		};
> > 
> > Does this mean this is working progress and voltages will be lowered for
> > lower frequencies as testing proceeds?
> 
> It supports only DFS not DVFS(ie, by controlling CPUFREQ register you can control the CPU frequency.)

If it does not support voltage scaling, is the /* kHz - uV - OPPs
unknown yet */ comment up-to-date? Would something like /* hardware
does not support voltage scaling */ be more useful?

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191120/4d0c5f95/attachment.sig>

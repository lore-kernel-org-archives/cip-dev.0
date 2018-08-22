From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 22 Aug 2018 16:58:18 +0100
Subject: [cip-dev] [PATCH 14/42] watchdog: renesas-wdt: add driver
In-Reply-To: <TY1PR01MB177018DB7CBB3AE63D1B5AB1C0320@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1532626980-17190-15-git-send-email-fabrizio.castro@bp.renesas.com>
	<1534558800.3135.20.camel@codethink.co.uk>
	<TY1PR01MB177018DB7CBB3AE63D1B5AB1C0320@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <1534953498.2902.5.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2018-08-20 at 10:19 +0000, Fabrizio Castro wrote:
> Hello Ben,
> 
> Thank you for your feedback.
> 
> > -----Original Message-----
> > From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > Sent: 18 August 2018 03:20
> > To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> > Subject: Re: [PATCH 14/42] watchdog: renesas-wdt: add driver
[...]
> > It also blacklisted some early gen2 chips; shouldn't that code be included in this
> > backport?
> 
> There is more work to do to backport that neatly, and also the goal is to support
> r8a774[35] (which is covered by this commit). On top of that, the blacklisted
> chips are not found in real products, only in early prototypes of development
> boards. The plan is to look into this iff interests arises.
[...]

OK, that makes sense.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

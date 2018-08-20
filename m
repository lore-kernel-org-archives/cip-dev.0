From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 20 Aug 2018 10:19:15 +0000
Subject: [cip-dev] [PATCH 14/42] watchdog: renesas-wdt: add driver
In-Reply-To: <1534558800.3135.20.camel@codethink.co.uk>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1532626980-17190-15-git-send-email-fabrizio.castro@bp.renesas.com>
	<1534558800.3135.20.camel@codethink.co.uk>
Message-ID: <TY1PR01MB177018DB7CBB3AE63D1B5AB1C0320@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

Thank you for your feedback.

> -----Original Message-----
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Sent: 18 August 2018 03:20
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [PATCH 14/42] watchdog: renesas-wdt: add driver
>
> On Thu, 2018-07-26 at 18:42 +0100, Fabrizio Castro wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > Add support for watchdogs (RWDT and SWDT) found on RCar Gen3 based SoCs
> > from Renesas.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> > (cherry picked from commit bd99b68ed7f96c9c845aad2a25f84145213058f2)
> > (reworked dt-bindings to refer to R-Car Gen2 and RZ/G1 only.
>
> Well, gen2 support was added upstream by commit
> 3fe95e6c68e6258410e85488af9e1b1ff545b831, so that should be mentioned
> here too.

Will do

> It also blacklisted some early gen2 chips; shouldn't that code be included in this
> backport?

There is more work to do to backport that neatly, and also the goal is to support
r8a774[35] (which is covered by this commit). On top of that, the blacklisted
chips are not found in real products, only in early prototypes of development
boards. The plan is to look into this iff interests arises.

>
> > replaced ARCH_RENESAS with ARCH_SHMOBILE in Kconfig. changes to
> > the driver:
> > * replaced "renesas,rcar-gen3-wdt" with "renesas,rcar-gen2-wdt"
> > * added rwdt_set_timeout
> > * modified rwdt_ping and rwdt_start to leverage rwdt_set_timeout)
> [...]
>
> You explain what you changed, but it's more helpful to explain why.  If
> I'm reading correctly, the set_timeout operation for watchdog drivers
> is now optional, but was required in 4.4.  Could you put that in the
> commit message?

I will put the reason in the commit message of V2.

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

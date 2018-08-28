From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 28 Aug 2018 08:54:16 +0000
Subject: [cip-dev] [PATCH 01/19] ASoC: rsnd: remove platform boot
	support from src.c
In-Reply-To: <1535131724.2902.38.camel@codethink.co.uk>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1533894782-26239-2-git-send-email-fabrizio.castro@bp.renesas.com>
	<1535131724.2902.38.camel@codethink.co.uk>
Message-ID: <TY1PR01MB17702CAFA22A50A8B7AA62FAC00A0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,


Thank you for your feedback.

> -----Original Message-----
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Sent: 24 August 2018 18:29
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [PATCH 01/19] ASoC: rsnd: remove platform boot support from src.c
>
> On Fri, 2018-08-10 at 10:52 +0100, Fabrizio Castro wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > No board is using Renesas sound driver via platform boot now.
> > This means all user is using DT boot. Platform boot support is
> > no longer needed. But, it strongly depends on platform boot style.
> > This patch removes platform boot support from src.c
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > (cherry picked from commit adf6a6815952c6c6092ae15e27c1b782fd96c6a3)
> > (reworked to fit the context)
> [...]
>
> This isn't a sufficient explanation of the backporting change.  The
> upstream version appears to remove all use of struct
> rsnd_src_platform_info from the driver, but this version extends the
> use of that structure.


Will send a v2 to improve the description.

Cheers,
Fab

>
> Ben.
>
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

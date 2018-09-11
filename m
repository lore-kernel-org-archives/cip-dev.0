From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 11 Sep 2018 07:22:28 +0000
Subject: [cip-dev] [PATCH 01/19] ASoC: rsnd: remove platform
 boot	support from src.c
In-Reply-To: <TYXPR01MB1775D760CF6B7FDD86DCBCADC00C0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1533894782-26239-2-git-send-email-fabrizio.castro@bp.renesas.com>
	<1535131724.2902.38.camel@codethink.co.uk>
	<TY1PR01MB17702CAFA22A50A8B7AA62FAC00A0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<TYXPR01MB1775D760CF6B7FDD86DCBCADC00C0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
Message-ID: <TY1PR01MB17709FA5820D96463D54770EC0040@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

Have you given any more thought about this?

Thanks,
Fab

> Subject: RE: [cip-dev] [PATCH 01/19] ASoC: rsnd: remove platform boot support from src.c
>
> Hello Ben,
>
> I am  sorry about the delay of my answer.
>
> > Subject: Re: [cip-dev] [PATCH 01/19] ASoC: rsnd: remove platform boot support from src.c
> >
> > Hello Ben,
> >
> >
> > Thank you for your feedback.
> >
> > > -----Original Message-----
> > > From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > > Sent: 24 August 2018 18:29
> > > To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> > > Subject: Re: [PATCH 01/19] ASoC: rsnd: remove platform boot support from src.c
> > >
> > > On Fri, 2018-08-10 at 10:52 +0100, Fabrizio Castro wrote:
> > > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > >
> > > > No board is using Renesas sound driver via platform boot now.
> > > > This means all user is using DT boot. Platform boot support is
> > > > no longer needed. But, it strongly depends on platform boot style.
> > > > This patch removes platform boot support from src.c
> > > >
> > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > > (cherry picked from commit adf6a6815952c6c6092ae15e27c1b782fd96c6a3)
> > > > (reworked to fit the context)
> > > [...]
> > >
> > > This isn't a sufficient explanation of the backporting change.  The
> > > upstream version appears to remove all use of struct
> > > rsnd_src_platform_info from the driver, but this version extends the
> > > use of that structure.
>
> r8a7745 doesn't have clock "src.0" leaving a gap in the clock names.
> The fix for this was made upstream with commit de1965159a34 ("rcar: src:
> skip disabled-SRC nodes"). This patch prepares the context for the fix,
> however since it is applied to quite a different version of the file
> it has been reworked to support the replacing of for_each_rsnd_src
> with for_each_child_of_node loop.
>
> I could try and backport lots more patches to get a cleaner history, but I fear
> that would actually make the code unstable.
>
> Do you have any recommendation for a better log?
>
> The other thing I could do is try and fix the problem in a different way
> without backporting any patch. What are your thoughts about this?
>
> Thanks,
> Fab
>
> >
> >
> > Will send a v2 to improve the description.
> >
> > Cheers,
> > Fab
> >
> > >
> > > Ben.
> > >
> > > --
> > > Ben Hutchings, Software Developer                         Codethink Ltd
> > > https://www.codethink.co.uk/                 Dale House, 35 Dale Street
> > >                                      Manchester, M1 2HF, United Kingdom
> >
> >
> >
> > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England
> &
> > Wales under Registered No. 04586709.
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

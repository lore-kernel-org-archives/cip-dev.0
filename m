From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 31 May 2018 09:25:43 +0000
Subject: [cip-dev] [PATCH] ARM: dts: r8a7743: Add VSP support
In-Reply-To: <1527701045.2289.22.camel@codethink.co.uk>
References: <1527588486-4923-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1527701045.2289.22.camel@codethink.co.uk>
Message-ID: <TY1PR01MB17704285D4CD6F840E89AABDC0630@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



> -----Original Message-----
> From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> Sent: 30 May 2018 18:24
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>
> Subject: Re: [PATCH] ARM: dts: r8a7743: Add VSP support
>
> On Tue, 2018-05-29 at 11:08 +0100, Fabrizio Castro wrote:
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > Add VSP support to SoC DT.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > (cherry picked from commit ff9b22610e8c08946f9787d9e0d1a87489624417)
>
> This is wrong; the upstream commit is
> 0565605aa9887a3d6423fb08c0cbb0de3a22f838.

Yeah you are right

>
> > (dropped resets property. changed clocks and power-domains properties.
> > added vsp device configuration)
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> > Hello Ben,
> >
> > this patch applies on top of v4.4.130-cip23.
> [...]
>
> I applied this and fixed the upstream commit reference.  Thanks.

Thank you for fixing.

Cheers,
Fab

>
> Ben.
>
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
> We respect your privacy.   See https://www.codethink.co.uk/privacy.html



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

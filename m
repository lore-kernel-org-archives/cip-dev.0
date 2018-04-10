From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 10 Apr 2018 17:49:28 +0000
Subject: [cip-dev] [PATCH 1/4] spi: sh-msiof: Add R-Car Gen 2 and 3
 fallback bindings
In-Reply-To: <1523381620.2654.194.camel@codethink.co.uk>
References: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1520530089-4988-2-git-send-email-fabrizio.castro@bp.renesas.com>
	<1523381620.2654.194.camel@codethink.co.uk>
Message-ID: <TY1PR01MB1770C985364A4FA273F60BA5C0BE0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

> Subject: Re: [cip-dev][PATCH 1/4] spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings
>
> On Thu, 2018-03-08 at 17:28 +0000, Fabrizio Castro wrote:
> > From: Simon Horman <horms+renesas@verge.net.au>
> >
> > In the case of Renesas R-Car hardware we know that there are generations of
> > SoCs, e.g. Gen 2 and Gen 3. But beyond that it's not clear what the
> > relationship between IP blocks might be. For example, I believe that
> > r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
> > descendant of the former or vice versa.
> >
> > We can, however, by examining the documentation and behaviour of the
> > hardware at run-time observe that the current driver implementation appears
> > to be compatible with the IP blocks on SoCs within a given generation.
> >
> > For the above reasons and convenience when enabling new SoCs a
> > per-generation fallback compatibility string scheme is being adopted for
> > drivers for Renesas SoCs.
> >
> > Also:
> > * Deprecate renesas,sh-msiof. It seems poorly named as it is only
> >   compatible with SH-Mobile. It also appears unused in mainline.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > (cherry picked from commit 4286db8456f4fa0c6af2b6b9abc5991a7e7da69c)
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > (cherry picked from commit 77f252646eb0ec1e78847fe5725c98ee9e70b39e)
>
> I deleted this second commit reference, which I assume refers to some
> private branch.

You are right, this must have been from a temporary local branch. Well spotted!

Thanks,
Fab

>
> Ben.
>
> > (removed "renesas,rcar-gen3-msiof")
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> [...]
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 13:46:26 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 30/57] ASoC: rsnd: add SSIU BUSIF
	support
In-Reply-To: <20191020105036.GD18709@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-31-git-send-email-biju.das@bp.renesas.com>
	<20191020105036.GD18709@amd>
Message-ID: <OSBPR01MB21031093A88670D4A49E64DEB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

HI Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 30/57] ASoC: rsnd: add SSIU BUSIF support
> 
> Hi!
> 
> > This patch removes its settings from Document, but driver is still
> > keeping compatibility. Thus, old DT style is still working.
> > But, to avoid confusing, it doesn't indicate old compatibility things
> > on Document. New SoC should have SSIU on DT from this patch.
> 
> I'm not sure which Document this talks about:

I think, it is talking about "Old" means BUS IF handled by SSI driver and "New" means BUSIF handled by SSIU.

If you have new DT style and don't have this driver change, then you will get the below error and the driver fallback to PIO mode.

[ 10.762848] rcar_sound ec500000.sound: ssi[2] : probe error -11
[ 10.768858] rcar_sound ec500000.sound: ssi[2] fallback to PIO mode
[ 10.775177] rcar_sound ec500000.sound: probed

> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  sound/soc/sh/rcar/core.c |   1 +
> >  sound/soc/sh/rcar/dma.c  |  37 ++++++++--
> >  sound/soc/sh/rcar/rsnd.h |   6 +-
> >  sound/soc/sh/rcar/ssi.c  |  22 +++---  sound/soc/sh/rcar/ssiu.c | 178
> > +++++++++++++++++++++++++++++++++++++++++++----
> >  5 files changed, 215 insertions(+), 29 deletions(-)
> 
> Patch does not seem to be changing any documentation.

Cheers,
Biju

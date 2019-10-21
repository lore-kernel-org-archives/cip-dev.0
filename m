From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 12:17:17 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 13/57] ASoC: rsnd: don't use %p for
	dev_dbg()
In-Reply-To: <20191020092733.GC8003@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-14-git-send-email-biju.das@bp.renesas.com>
	<20191020092733.GC8003@amd>
Message-ID: <OSBPR01MB2103985471E330DDE05AA1BCB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pave,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 13/57] ASoC: rsnd: don't use %p for dev_dbg()
> 
> On Thu 2019-10-17 08:04:45, Biju Das wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > commit dabdbe3ae0cb9a67872fa4ac80ffdef61391f645 upstream.
> >
> > rsnd driver sometimes want to know which address is used when
> debugging.
> > But it will indicate "(____ptrval____)" if it used "%p" on dev_dbg().
> > Let's use "%pa" or "%px" for it.
> 
> Well, ____ptrval____ is there to hide address space randomization data
> from the userland. This defeats it... which is probably okay while debugging,
> but not sure if it is good idea for production.
> 
> (It is okay if dev_dbgs are compiled out by default. Is it?)

Yes, for production scenario no one will enable this.

Regards,
Biju

> 
> > @@ -591,7 +591,7 @@ static void rsnd_adg_clk_dbg_info(struct rsnd_priv
> *priv, struct rsnd_adg *adg)
> >  	int i;
> >
> >  	for_each_rsnd_clk(clk, adg, i)
> > -		dev_dbg(dev, "%s    : %p : %ld\n",
> > +		dev_dbg(dev, "%s    : %pa : %ld\n",
> >  			clk_name[i], clk, clk_get_rate(clk));
> >
> >  	dev_dbg(dev, "BRGCKR = 0x%08x, BRRA/BRRB = 0x%x/0x%x\n", @@
> -604,7
> > +604,7 @@ static void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct
> rsnd_adg *adg)
> >  	 * by BRGCKR::BRGCKR_31
> >  	 */
> >  	for_each_rsnd_clkout(clk, adg, i)
> > -		dev_dbg(dev, "clkout %d : %p : %ld\n", i,
> > +		dev_dbg(dev, "clkout %d : %pa : %ld\n", i,
> >  			clk, clk_get_rate(clk));
> >  }
> >  #else
> > diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c index
> > b5f3bf8..0bbc4b0 100644
> > --- a/sound/soc/sh/rcar/dma.c
> > +++ b/sound/soc/sh/rcar/dma.c
> > @@ -397,7 +397,7 @@ static void rsnd_dmapp_write(struct rsnd_dma
> *dma, u32 data, u32 reg)
> >  	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
> >  	struct device *dev = rsnd_priv_to_dev(priv);
> >
> > -	dev_dbg(dev, "w %p : %08x\n", rsnd_dmapp_addr(dmac, dma, reg),
> data);
> > +	dev_dbg(dev, "w 0x%px : %08x\n", rsnd_dmapp_addr(dmac, dma,
> reg),
> > +data);
> >
> >  	iowrite32(data, rsnd_dmapp_addr(dmac, dma, reg));  }
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

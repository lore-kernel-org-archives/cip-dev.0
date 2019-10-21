From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 13:26:17 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 24/57] ASoC: rsnd: rsnd_mod_name()
 handles both name and ID
In-Reply-To: <20191020103448.GA18709@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-25-git-send-email-biju.das@bp.renesas.com>
	<20191020103448.GA18709@amd>
Message-ID: <OSBPR01MB2103049CFB6B4D64994D3CDEB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 24/57] ASoC: rsnd: rsnd_mod_name() handles
> both name and ID
> 
> Hi!
> 
> > In the future, we will support BUSIFn, but it will be more complicated
> > numbering. To avoid future confusable code, this patch modify
> > rsnd_mod_name() to return understandable name.
> >
> > To avoid using pointless memory, it uses static char and snprintf,
> > thus, rsnd_mod_name() user should use it immediately, and shouldn't
> > keep its pointer.
> 
> No, don't do that. That's a dangerous interface.

Can you please elaborate more on the dangerous interface ?

> > +#define MOD_NAME_SIZE 16
> > +char *rsnd_mod_name(struct rsnd_mod *mod) {
> > +	static char name[MOD_NAME_SIZE];
> > +
> > +	/*
> > +	 * Let's use same char to avoid pointlessness memory
> > +	 * Thus, rsnd_mod_name() should be used immediately
> > +	 * Don't keep pointer
> > +	 */
> > +	if ((mod)->ops->id_sub) {
> > +		snprintf(name, MOD_NAME_SIZE, "%s[%d%d]",
> > +			 mod->ops->name,
> > +			 rsnd_mod_id(mod),
> > +			 rsnd_mod_id_sub(mod));
> > +	} else {
> > +		snprintf(name, MOD_NAME_SIZE, "%s[%d]",
> > +			 mod->ops->name,
> > +			 rsnd_mod_id(mod));
> > +	}
> > +
> > +	return name;
> > +}
> 
> This is too hard to use correctly.

Can you please suggest the correct way of doing this?

> > @@ -762,12 +759,10 @@ static int rsnd_dma_alloc(struct rsnd_dai_stream
> *io, struct rsnd_mod *mod,
> >  	if (ret < 0)
> >  		return ret;
> >
> > -	dev_dbg(dev, "%s[%d] %s[%d] -> %s[%d]\n",
> > -		rsnd_mod_name(*dma_mod), rsnd_mod_id(*dma_mod),
> > +	dev_dbg(dev, "%s %s -> %s\n",
> > +		rsnd_mod_name(*dma_mod),
> >  		rsnd_mod_name(mod_from ? mod_from : &mem),
> > -		rsnd_mod_id  (mod_from ? mod_from : &mem),
> > -		rsnd_mod_name(mod_to   ? mod_to   : &mem),
> > -		rsnd_mod_id  (mod_to   ? mod_to   : &mem));
> > +		rsnd_mod_name(mod_to   ? mod_to   : &mem));
> >
> >  	ret = attach(io, dma, mod_from, mod_to);
> >  	if (ret < 0)
> 
> For example this usage is not correct.
> 
> And yes, I took a look at mainline, and no, having 5 static buffers is not really
> an acceptable solution.
> 
Cheers,
Biju

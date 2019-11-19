From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: 19 Nov 2019 10:03:02 +0900
Subject: [cip-dev] [PATCH 4.19.y-cip 24/57] ASoC: rsnd: rsnd_mod_name()
	handles both name and ID
In-Reply-To: <OSBPR01MB2103D3195402546EBB4397C5B84D0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
 <1571295929-47286-25-git-send-email-biju.das@bp.renesas.com>
 <20191020103448.GA18709@amd>
 <OSBPR01MB2103049CFB6B4D64994D3CDEB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20191118153436.GD26236@duo.ucw.cz>
 <OSBPR01MB2103D3195402546EBB4397C5B84D0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <87zhgs65kp.wl-kuninori.morimoto.gx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi Biju

> > > > > In the future, we will support BUSIFn, but it will be more
> > > > > complicated numbering. To avoid future confusable code, this patch
> > > > > modify
> > > > > rsnd_mod_name() to return understandable name.
> > > > >
> > > > > To avoid using pointless memory, it uses static char and snprintf,
> > > > > thus, rsnd_mod_name() user should use it immediately, and
> > > > > shouldn't keep its pointer.
> > > >
> > > > No, don't do that. That's a dangerous interface.
> > >
> > > Can you please elaborate more on the dangerous interface ?
> > >
> > > > > +#define MOD_NAME_SIZE 16
> > > > > +char *rsnd_mod_name(struct rsnd_mod *mod) {
> > > > > +	static char name[MOD_NAME_SIZE];
> > > > > +
> > > > > +	/*
> > > > > +	 * Let's use same char to avoid pointlessness memory
> > > > > +	 * Thus, rsnd_mod_name() should be used immediately
> > > > > +	 * Don't keep pointer
> > > > > +	 */
> > > > > +	if ((mod)->ops->id_sub) {
> > > > > +		snprintf(name, MOD_NAME_SIZE, "%s[%d%d]",
> > > > > +			 mod->ops->name,
> > > > > +			 rsnd_mod_id(mod),
> > > > > +			 rsnd_mod_id_sub(mod));
> > > > > +	} else {
> > > > > +		snprintf(name, MOD_NAME_SIZE, "%s[%d]",
> > > > > +			 mod->ops->name,
> > > > > +			 rsnd_mod_id(mod));
> > > > > +	}
> > > > > +
> > > > > +	return name;
> > > > > +}
> > > >
> > > > This is too hard to use correctly.
> > >
> > > Can you please suggest the correct way of doing this?
> > 
> > void rsnd_mod_name(char *buf, struct rsnd_mod *mod) {} would be usual
> > way of doing it. Semantics would be similar to sprintf().
> 
> Morimoto-San, 
> 	Please share your opinion on this.

rsnd_mod_name() is used for debug or error case,
and not used in Hi frequency.
At least, it doesn't used over 5 (= MOD_NAME_NUM) times in the same time.
So, it is no problem *at this point*.
But, indeed it is including potential issue...

Thank you for your help !!
Best regards
---
Kuninori Morimoto

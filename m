From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: 23 Oct 2019 10:45:18 +0900
Subject: [cip-dev] [PATCH 4.19.y-cip 19/57] ASoC: rsnd: use 32bit TDM
	width as default
In-Reply-To: <OSBPR01MB210382980CFA8AEC3846C199B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-20-git-send-email-biju.das@bp.renesas.com>
	<20191020094924.GG8003@amd>
	<OSBPR01MB210382980CFA8AEC3846C199B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <877e4wz13l.wl-kuninori.morimoto.gx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi

> > > @@ -738,8 +738,8 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
> > >  	case 32:
> > >  		break;
> > >  	default:
> > > -		dev_err(dev, "unsupported slot width value: %d\n", slot_width);
> > > -		return -EINVAL;
> > > +		/* use default */
> > > +		slot_width = 32;
> > >  	}
> > >
> > >  	switch (slots) {
> > 
> > I don't think I like this. People should not be passing strange values to this
> > function. Can the caller be fixed, instead?
> 
> Morimoto San, Do you agree to Pavel's comment?

As git-log said, it is default values, not strange value.
People don't set all settings, especially it was default.

Thank you for your help !!
Best regards
---
Kuninori Morimoto

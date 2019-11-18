From: pavel@denx.de (Pavel Machek)
Date: Mon, 18 Nov 2019 16:32:23 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 19/57] ASoC: rsnd: use 32bit TDM
 width as default
In-Reply-To: <877e4wz13l.wl-kuninori.morimoto.gx@renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
 <1571295929-47286-20-git-send-email-biju.das@bp.renesas.com>
 <20191020094924.GG8003@amd>
 <OSBPR01MB210382980CFA8AEC3846C199B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <877e4wz13l.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <20191118153223.GC26236@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed 2019-10-23 10:45:18, Kuninori Morimoto wrote:
> 
> Hi
> 
> > > > @@ -738,8 +738,8 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
> > > >  	case 32:
> > > >  		break;
> > > >  	default:
> > > > -		dev_err(dev, "unsupported slot width value: %d\n", slot_width);
> > > > -		return -EINVAL;
> > > > +		/* use default */
> > > > +		slot_width = 32;
> > > >  	}
> > > >
> > > >  	switch (slots) {
> > > 
> > > I don't think I like this. People should not be passing strange values to this
> > > function. Can the caller be fixed, instead?
> > 
> > Morimoto San, Do you agree to Pavel's comment?
> 
> As git-log said, it is default values, not strange value.
> People don't set all settings, especially it was default.

I'd understand turning 0 to 32 (that is if someone forgot to set
it?). But turning 19 into 32 seems wrong.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191118/2a79135d/attachment.sig>

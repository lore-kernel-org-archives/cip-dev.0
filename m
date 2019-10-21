From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 13:54:18 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 19/57] ASoC: rsnd: use 32bit TDM
 width as default
In-Reply-To: <20191020094924.GG8003@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-20-git-send-email-biju.das@bp.renesas.com>
	<20191020094924.GG8003@amd>
Message-ID: <OSBPR01MB210382980CFA8AEC3846C199B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

+ Morimoto-San,

Hi Pavel,

Thanks for the feedback. 

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Sunday, October 20, 2019 10:49 AM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 19/57] ASoC: rsnd: use 32bit TDM width as
> default
> 
> On Thu 2019-10-17 08:04:51, Biju Das wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > commit 82ab7e9a4d3fcec27f745be04063e17da1881dda upstream.
> >
> > commit fb2815f44a9e ("ASoC: rsnd: add support for 16/24 bit slot
> > widths") added TDM width check, and return error if it was not 16/24/32
> bit.
> > But it is too strict. This patch uses 32bit same as default.
> 
> > @@ -738,8 +738,8 @@ static int rsnd_soc_set_dai_tdm_slot(struct
> snd_soc_dai *dai,
> >  	case 32:
> >  		break;
> >  	default:
> > -		dev_err(dev, "unsupported slot width value: %d\n",
> slot_width);
> > -		return -EINVAL;
> > +		/* use default */
> > +		slot_width = 32;
> >  	}
> >
> >  	switch (slots) {
> 
> I don't think I like this. People should not be passing strange values to this
> function. Can the caller be fixed, instead?

Morimoto San, Do you agree to Pavel's comment?

Regards,
Biju

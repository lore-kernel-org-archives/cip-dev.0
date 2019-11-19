From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: 19 Nov 2019 10:24:31 +0900
Subject: [cip-dev] [PATCH 4.19.y-cip 16/57] ASoC: add for_each_dpcm_fe()
	macro
In-Reply-To: <20191118153045.GB26236@duo.ucw.cz>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
 <1571295929-47286-17-git-send-email-biju.das@bp.renesas.com>
 <20191020094805.GF8003@amd>
 <OSBPR01MB2103CC08EA8249635E23798EB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <87a79sz1vf.wl-kuninori.morimoto.gx@renesas.com>
 <20191118153045.GB26236@duo.ucw.cz>
Message-ID: <87wobw64kw.wl-kuninori.morimoto.gx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi Pavel

> > +#define for_each_dpcm_fe(be, stream, dpcm) \
> > +	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)
> 
> It should be:
> 
> > +#define for_each_dpcm_fe(be, stream, dpcm, list_de) \
> > +	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)
> 
> [accessing variables not passed as macro arguments is strange/surprising].

Ahh, OK. But, I would say, Yes and No.

Indeed, using not passed parameter in macro is strange.
But, this time, it is used at list_for_each_entry().
Last one is struct location/member, not parameter.

In this case, in order to use properly,
macro name is indicating "for what".

We have xx_fe and xx_be.

#define for_each_dpcm_fe(be, stream, _dpcm)				\
	list_for_each_entry(_dpcm, &(be)->dpcm[stream].fe_clients, list_fe)

#define for_each_dpcm_be(fe, stream, _dpcm)				\
	list_for_each_entry(_dpcm, &(fe)->dpcm[stream].be_clients, list_be)



Thank you for your help !!
Best regards
---
Kuninori Morimoto

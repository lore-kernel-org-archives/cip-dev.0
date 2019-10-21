From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 12:26:28 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 16/57] ASoC: add for_each_dpcm_fe()
	macro
In-Reply-To: <20191020094805.GF8003@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-17-git-send-email-biju.das@bp.renesas.com>
	<20191020094805.GF8003@amd>
Message-ID: <OSBPR01MB2103CC08EA8249635E23798EB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

+ Morimoto-San,

> Subject: Re: [PATCH 4.19.y-cip 16/57] ASoC: add for_each_dpcm_fe() macro
> 
> Hi!
> 
> > --- a/include/sound/soc-dpcm.h
> > +++ b/include/sound/soc-dpcm.h
> > @@ -103,6 +103,9 @@ struct snd_soc_dpcm_runtime {
> >  	int trigger_pending; /* trigger cmd + 1 if pending, 0 if not */  };
> >
> > +#define for_each_dpcm_fe(be, stream, dpcm)
> 	\
> > +	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)
> > +
> 
> This macro is really confusing. dpcm is used as both control variable of the
> loop and name of the field in *be. Plus it relies on list_fe variable to be
> present in the context including it... that's non-standard.
> 
> Oh and "&(be)->" can be written as "(be)." AFAICT.

Morimoto-San,
 Do you have any opinion on Pavel's findings?

Regards,
Biju

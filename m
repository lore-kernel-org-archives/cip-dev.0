From: pavel@denx.de (Pavel Machek)
Date: Mon, 18 Nov 2019 16:30:45 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 16/57] ASoC: add for_each_dpcm_fe()
	macro
In-Reply-To: <87a79sz1vf.wl-kuninori.morimoto.gx@renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
 <1571295929-47286-17-git-send-email-biju.das@bp.renesas.com>
 <20191020094805.GF8003@amd>
 <OSBPR01MB2103CC08EA8249635E23798EB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <87a79sz1vf.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <20191118153045.GB26236@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed 2019-10-23 10:28:36, Kuninori Morimoto wrote:
> 
> Hi
> 
> > > > --- a/include/sound/soc-dpcm.h
> > > > +++ b/include/sound/soc-dpcm.h
> > > > @@ -103,6 +103,9 @@ struct snd_soc_dpcm_runtime {
> > > >  	int trigger_pending; /* trigger cmd + 1 if pending, 0 if not */  };
> > > >
> > > > +#define for_each_dpcm_fe(be, stream, dpcm)
> > > 	\
> > > > +	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)
> > > > +
> > > 
> > > This macro is really confusing. dpcm is used as both control variable of the
> > > loop and name of the field in *be.
> 
> Ohh, yes, indeed.
> Thank you for pointing it. I will post fixup patch

Thanks!

> > Plus it relies on list_fe variable to be
> > > present in the context including it... that's non-standard.
> 
> sorry I couldn't understand about this

Macro is:

> +#define for_each_dpcm_fe(be, stream, dpcm) \
> +	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)

It should be:

> +#define for_each_dpcm_fe(be, stream, dpcm, list_de) \
> +	list_for_each_entry(dpcm, &(be)->dpcm[stream].fe_clients, list_fe)

[accessing variables not passed as macro arguments is strange/surprising].

> > > Oh and "&(be)->" can be written as "(be)." AFAICT.
> 
> This "&" is for fe_clients

Aha, sorry, I misparsed that one.
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191118/13bfaf44/attachment.sig>

From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: 23 Oct 2019 10:20:04 +0900
Subject: [cip-dev] [PATCH 4.19.y-cip 15/57] ASoC: convert
	for_each_rtd_codec_dai() for missing part
In-Reply-To: <OSBPR01MB2103E078B3B9571E3BF50024B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-16-git-send-email-biju.das@bp.renesas.com>
	<20191020094159.GE8003@amd>
	<OSBPR01MB2103E078B3B9571E3BF50024B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <87blu8z29n.wl-kuninori.morimoto.gx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi

> > > @@ -1321,8 +1322,7 @@ static struct snd_soc_pcm_runtime
> > *dpcm_get_be(struct snd_soc_card *card,
> > >  			if (be->cpu_dai->playback_widget == widget)
> > >  				return be;
> > >
> > > -			for (i = 0; i < be->num_codecs; i++) {
> > > -				struct snd_soc_dai *dai = be->codec_dais[i];
> > > +			for_each_rtd_codec_dai(be, i, dai) {
> > >  				if (dai->playback_widget == widget)
> > >  					return be;
> > >  			}
> > 
> > This conversion is not equivalent. Original code always goes through
> > num_codecs, new code stops at first NULL pointer. I assume there are
> > always non-NULL pointers in the list, but perhaps new code should not be
> > ignoring the NULLs silently?
> > 
> 
> Do you have any opinion on Pavel's findings?

Hmm.. strange.
If original code goes through eventhough NULL pointer,
it will be Oops at dai->playback_widget access ?

? Does this comment came from code review,
instead of actual machine operation issue ?

if so, it is always non-NULL pointer list.

Thank you for your help !!
Best regards
---
Kuninori Morimoto

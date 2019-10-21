From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 12:22:39 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 15/57] ASoC: convert
 for_each_rtd_codec_dai() for missing part
In-Reply-To: <20191020094159.GE8003@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-16-git-send-email-biju.das@bp.renesas.com>
	<20191020094159.GE8003@amd>
Message-ID: <OSBPR01MB2103E078B3B9571E3BF50024B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

+ Morimoto-San,

> Subject: Re: [PATCH 4.19.y-cip 15/57] ASoC: convert
> for_each_rtd_codec_dai() for missing part
> 
> Hi!
> 
> > commit 0b7990e38971 ("ASoC: add for_each_rtd_codec_dai() macro")
> added
> > for_each_rtd_codec_dai(), but it didn't convert few loop which is not
> > using "rtd". This patch fixup it.
> 
> 
> > @@ -1321,8 +1322,7 @@ static struct snd_soc_pcm_runtime
> *dpcm_get_be(struct snd_soc_card *card,
> >  			if (be->cpu_dai->playback_widget == widget)
> >  				return be;
> >
> > -			for (i = 0; i < be->num_codecs; i++) {
> > -				struct snd_soc_dai *dai = be->codec_dais[i];
> > +			for_each_rtd_codec_dai(be, i, dai) {
> >  				if (dai->playback_widget == widget)
> >  					return be;
> >  			}
> 
> This conversion is not equivalent. Original code always goes through
> num_codecs, new code stops at first NULL pointer. I assume there are
> always non-NULL pointers in the list, but perhaps new code should not be
> ignoring the NULLs silently?
> 

Do you have any opinion on Pavel's findings?

Regards,
Biju

From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 12:18:33 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 14/57] ASoC: add
	for_each_rtd_codec_dai() macro
In-Reply-To: <20191020093647.GD8003@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-15-git-send-email-biju.das@bp.renesas.com>
	<20191020093647.GD8003@amd>
Message-ID: <OSBPR01MB2103E35FB245F3567AE5CCA1B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

HI Pavel,

Thanks for the feedback

> Subject: Re: [PATCH 4.19.y-cip 14/57] ASoC: add for_each_rtd_codec_dai()
> macro
> 
> Hi!
> 
> > commit 0b7990e38971da403ce223d8bdc758a817eb72f8 upstream.
> >
> > ALSA SoC snd_soc_pcm_runtime has snd_soc_dai array for codec_dai.
> > To be more readable code, this patch adds new for_each_rtd_codec_dai()
> > macro, and replace existing code to it.
> 
> I'm okay with for_each_rtd_codec_dai() macro. But there's _reverse macro,
> and they look very, very similar, except that the _reverse macro does not
> actually initialize i... Yes, code needs it that way, but that's kind of tiny detail
> easy to overlook.
> 
> Mainline at least names the macro _rollback to make it tiny bit clearer. But I'd
> recommend just opencoding the _reverse macro; it does not really help
> readability.

I have backported this patch only because I got compilation error.

Regards,
Biju

> 
> > +++ b/include/sound/soc.h
> > @@ -1152,6 +1152,13 @@ struct snd_soc_pcm_runtime {
> >  	unsigned int dev_registered:1;
> >  	unsigned int pop_wait:1;
> >  };
> > +#define for_each_rtd_codec_dai(rtd, i, dai)\
> > +	for ((i) = 0;						       \
> > +	     ((i) < rtd->num_codecs) && ((dai) = rtd->codec_dais[i]); \
> > +	     (i)++)
> > +#define for_each_rtd_codec_dai_reverse(rtd, i, dai)
> 		\
> > +	for (; ((i--) >= 0) && ((dai) = rtd->codec_dais[i]);)
> > +
> >
> 
> > @@ -620,8 +621,7 @@ static int soc_pcm_open(struct
> snd_pcm_substream *substream)
> >  	i = rtd->num_codecs;
> >
> >  codec_dai_err:
> > -	while (--i >= 0) {
> > -		codec_dai = rtd->codec_dais[i];
> > +	for_each_rtd_codec_dai_reverse(rtd, i, codec_dai) {
> >  		if (codec_dai->driver->ops->shutdown)
> >  			codec_dai->driver->ops->shutdown(substream,
> codec_dai);
> >  	}
> 
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

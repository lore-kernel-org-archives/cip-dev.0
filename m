From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: 28 Oct 2019 09:43:38 +0900
Subject: [cip-dev] [PATCH 4.19.y-cip 50/57] ASoC: rsnd: fixup 6ch
	settings to 8ch
In-Reply-To: <20191027075110.GD28383@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-51-git-send-email-biju.das@bp.renesas.com>
	<20191027075110.GD28383@amd>
Message-ID: <87k18p4s3p.wl-kuninori.morimoto.gx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi Pavel

> > +int rsnd_channel_normalization(int chan)
> > +{
> > +	if ((chan > 8) || (chan < 0))
> > +		return 0;
> > +
> > +	/* TDM Extend Mode needs 8ch */
> > +	if (chan == 6)
> > +		chan = 8;
> > +
> > +	return chan;
> > +}
> > +
> 
> Should the if ((chan > 8) || (chan < 0)) ever be true in practice?
> Sounds like bogus inputs to me. Should we dev_err() and return error
> in those cases? Or at least WARN_ON()?

Hmm... indeed.
Thank you for your report.
I will re-check code, and post patch

Thank you for your help !!
Best regards
---
Kuninori Morimoto

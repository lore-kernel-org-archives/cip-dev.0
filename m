From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 13:40:59 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 25/57] ASoC: rsnd: remove endpoint
 bidirectional check
In-Reply-To: <20191020103823.GB18709@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-26-git-send-email-biju.das@bp.renesas.com>
	<20191020103823.GB18709@amd>
Message-ID: <OSBPR01MB2103A0FDC8713261DAC71A96B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

+ Morimoto San,

Hi Pavel, Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 25/57] ASoC: rsnd: remove endpoint
> bidirectional check
> 
> Hi!
> 
> > DTC commit df536831d02c ("checks: add graph binding checks") is
> > checking endpoint bidirectional, and it is upstreamed to linux by
> > commit 50aafd60898a ("scripts/dtc: Update to upstream version
> > v1.4.6-21-g84e414b0b5bc").
> > Let's remove own bidirectional check
> 
> I don't really understand what bidirectional check? Are you saying that
> of_graph_get_remote_endpoint() never fails in 4.19.X ?
> 
> > +++ b/sound/soc/sh/rcar/ssi.c
> > @@ -1095,11 +1095,7 @@ void rsnd_ssi_parse_hdmi_connection(struct
> rsnd_priv *priv,
> >  				    int dai_i)
> >  {
> >  	struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
> > -	struct device_node *remote_ep;
> > -
> > -	remote_ep = of_graph_get_remote_endpoint(endpoint);
> > -	if (!remote_ep)
> > -		return;
> > +	struct device_node *remote_ep =
> > +of_graph_get_remote_endpoint(endpoint);
> 
> Plus the code seems to be missing of_node_put().

This patch is overridden by " 0028-ASoC-rsnd-move-HDMI-information-from-ssi.c-to-core.c.patch", yes I agree we are still missing of_node_put??

Morimoto-San, any comments??

Regards,
Biju

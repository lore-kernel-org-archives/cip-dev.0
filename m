From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: 23 Oct 2019 10:38:46 +0900
Subject: [cip-dev] [PATCH 4.19.y-cip 25/57] ASoC: rsnd: remove endpoint
	bidirectional check
In-Reply-To: <OSBPR01MB2103A0FDC8713261DAC71A96B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-26-git-send-email-biju.das@bp.renesas.com>
	<20191020103823.GB18709@amd>
	<OSBPR01MB2103A0FDC8713261DAC71A96B8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <878spcz1eh.wl-kuninori.morimoto.gx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi

> > > DTC commit df536831d02c ("checks: add graph binding checks") is
> > > checking endpoint bidirectional, and it is upstreamed to linux by
> > > commit 50aafd60898a ("scripts/dtc: Update to upstream version
> > > v1.4.6-21-g84e414b0b5bc").
> > > Let's remove own bidirectional check
> > 
> > I don't really understand what bidirectional check? Are you saying that
> > of_graph_get_remote_endpoint() never fails in 4.19.X ?

On OF-graph DT, remote-endpoint need to be pair.
ex)
	endpoint1: endpoint {
		remote-endpoint = <&endpoint2>;
	};

	endpoint2: endpoint {
		remote-endpoint = <&endpoint1>;
	};

This "bidirectional check" is for it.
Now, it is checked by DTC.

> > > +++ b/sound/soc/sh/rcar/ssi.c
> > > @@ -1095,11 +1095,7 @@ void rsnd_ssi_parse_hdmi_connection(struct
> > rsnd_priv *priv,
> > >  				    int dai_i)
> > >  {
> > >  	struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
> > > -	struct device_node *remote_ep;
> > > -
> > > -	remote_ep = of_graph_get_remote_endpoint(endpoint);
> > > -	if (!remote_ep)
> > > -		return;
> > > +	struct device_node *remote_ep =
> > > +of_graph_get_remote_endpoint(endpoint);
> > 
> > Plus the code seems to be missing of_node_put().

Thanks. indeed it missing of_node_put().
I will post fixup patch


Thank you for your help !!
Best regards
---
Kuninori Morimoto

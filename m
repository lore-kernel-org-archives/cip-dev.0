From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 13:48:49 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 28/57] ASoC: rsnd: move HDMI
 information from ssi.c to core.c
In-Reply-To: <20191020104009.GC18709@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-29-git-send-email-biju.das@bp.renesas.com>
	<20191020104009.GC18709@amd>
Message-ID: <OSBPR01MB210352CA992B2B242887FDAEB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

+ Morimoto-San

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 28/57] ASoC: rsnd: move HDMI information
> from ssi.c to core.c
> 
> Hi!
> 
> > Current driver is supporting HDMI output, and its information are
> > handled under ssi.c. But, it is stream information.
> > Let's move it from ssi.c to core.c.
> 
> > +++ b/sound/soc/sh/rcar/core.c
> >
> > +static void rsnd_parse_connect_graph(struct rsnd_priv *priv,
> > +				     struct rsnd_dai_stream *io,
> > +				     struct device_node *endpoint) {
> > +	struct device *dev = rsnd_priv_to_dev(priv);
> > +	struct device_node *remote_node =
> > +of_graph_get_remote_port_parent(endpoint);
> > +
> > +	if (!rsnd_io_to_mod_ssi(io))
> > +		return;
> > +
> > +	/* HDMI0 */
> > +	if (strstr(remote_node->full_name, "hdmi at fead0000")) {
> > +		rsnd_flags_set(io, RSND_STREAM_HDMI0);
> > +		dev_dbg(dev, "%s connected to HDMI0\n", io->name);
> > +	}
> > +
> > +	/* HDMI1 */
> > +	if (strstr(remote_node->full_name, "hdmi at feae0000")) {
> > +		rsnd_flags_set(io, RSND_STREAM_HDMI1);
> > +		dev_dbg(dev, "%s connected to HDMI1\n", io->name);
> > +	}
> > +}
> 
> Does it miss of_node_put()?

Ye looks like we are missing of_node_put. Morimoto-San any comments?

Regards,
Biju

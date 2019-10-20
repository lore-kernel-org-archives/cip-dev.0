From: pavel@denx.de (Pavel Machek)
Date: Sun, 20 Oct 2019 12:38:23 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 25/57] ASoC: rsnd: remove endpoint
 bidirectional check
In-Reply-To: <1571295929-47286-26-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-26-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20191020103823.GB18709@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> DTC commit df536831d02c ("checks: add graph binding checks")
> is checking endpoint bidirectional, and it is upstreamed to linux by
> commit 50aafd60898a ("scripts/dtc: Update to upstream version
> v1.4.6-21-g84e414b0b5bc").
> Let's remove own bidirectional check

I don't really understand what bidirectional check? Are you saying
that of_graph_get_remote_endpoint() never fails in 4.19.X ?

> +++ b/sound/soc/sh/rcar/ssi.c
> @@ -1095,11 +1095,7 @@ void rsnd_ssi_parse_hdmi_connection(struct rsnd_priv *priv,
>  				    int dai_i)
>  {
>  	struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
> -	struct device_node *remote_ep;
> -
> -	remote_ep = of_graph_get_remote_endpoint(endpoint);
> -	if (!remote_ep)
> -		return;
> +	struct device_node *remote_ep = of_graph_get_remote_endpoint(endpoint);

Plus the code seems to be missing of_node_put().

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191020/8c98cce4/attachment.sig>

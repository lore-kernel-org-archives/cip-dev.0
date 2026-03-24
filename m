Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B914E9A745
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:16:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15539.1774343791910454085
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NVBRJAqq;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 571F611212F;
	Tue, 24 Mar 2026 10:16:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774343790;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OU5eRtxHwNy4zNApKuEsUIA7lKxNPMGSSzNPcyUFKUY=;
	b=NVBRJAqqC76s6XjjnK+RP9lnn847nq4gtmslMPUe3CQcWjfS8uRGURmLByOSohI+sRILTC
	wm593fEKYd9yUmm+WJ4ETWGaOorIkU3n9oogT4sq1omgjuR/VpMZvgIHI0uCLXH463JO+D
	aqk0yp//8+8rTOZbfApXxlAF8eXSbutJKjpkXjuKBVUGG+1Gc57hln5/o+5/Z+503rXqoS
	EanJ0xHRdTLO6CEyUDleE386QA4LZ7fxwluygfF2vlgmg7oLAaKOsC/sduudxytY8rl05Y
	SGTFNbpx1K8Id8WaXs2GjDb+sO/gDrcON+13qV38kZuNfo7i1k5ppo/AqbSLkw==
Date: Tue, 24 Mar 2026 10:16:26 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 19/35] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/T2H SoC
Message-ID: <acJWamLEv29luwWG@duo.ucw.cz>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfpbxDETOq81kIXs"
Content-Disposition: inline
In-Reply-To: <20260316145915.8580-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:16:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22538


--kfpbxDETOq81kIXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Extend the Renesas GBETH stmmac glue driver to support the RZ/T2H SoC,
> where the GMAC is connected through a MIIC PCS. Introduce a new
> `has_pcs` flag in `struct renesas_gbeth_of_data` to indicate when PCS
> handling is required.
>=20
> When enabled, the driver parses the `pcs-handle` phandle, creates a PCS
> instance with `miic_create()`, and wires it into phylink. Proper cleanup
> is done with `miic_destroy()`. New init/exit/select hooks are added to
> `plat_stmmacenet_data` for PCS integration.
>=20
> Update Kconfig to select `PCS_RZN1_MIIC` when building the Renesas GBETH
> driver so the PCS support is always available.

> index 0156a974db1d..62a33b3fb00d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> +
> +static int renesas_gmac_pcs_init(struct stmmac_priv *priv)
> +{
> +	struct device_node *np =3D priv->device->of_node;
> +	struct device_node *pcs_node;
> +	struct phylink_pcs *pcs;
> +
> +	pcs_node =3D of_parse_phandle(np, "pcs-handle", 0);
> +	if (pcs_node) {
> +		pcs =3D miic_create(priv->device, pcs_node);
> +		of_node_put(pcs_node);
> +		if (IS_ERR(pcs))
> +			return PTR_ERR(pcs);
> +
> +		priv->hw->phylink_pcs =3D pcs;
> +	}
> +
> +	return 0;
> +}

You can simply do "if (!pcs_node) return 0" to reduce ammount of
nesting.

Best regards,
							Pavel

--kfpbxDETOq81kIXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJWagAKCRAw5/Bqldv6
8oQtAKCrMaGCS0t+bY0E6//O8wNfiq8VEgCeNyhwqQKm5njGp7VimwcH7rcNKms=
=WeAP
-----END PGP SIGNATURE-----

--kfpbxDETOq81kIXs--


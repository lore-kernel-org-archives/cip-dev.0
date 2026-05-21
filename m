Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1212CD4F5E
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 10:27:28 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33305.1779359246544443538
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 03:27:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=X2yIY96X;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7542310CFC8;
	Thu, 21 May 2026 12:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779359244;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4LtwpQm+DIUyLus1TrvxEL5nURbx+1HlUmcDswzmdr4=;
	b=X2yIY96XYGve7GMnR/eKW60jVCkQ2rRPf5FdyoN8kdy+Cp1awyUIm7fwqu6PMXr7HF9y3b
	RILYfIFIEqQuyBtqxQKlSkyqeTu4zxUf5baX/PK/W+Yub58+baZkBpyw1Fm160X/LXcvrq
	+rBGZmHCXYsUlj26U+zbfxSoN7BNSqaqPAmXc577gZXIR1fJu1OOVfpNjPG8FIw6y90ZgN
	CUdYjWX8FDbGd3o27laFnR7ntomdW4076CgyTHQLESYfhYTm1QnuqIGIjuQgNMyhjiNiu0
	DghzzN55TECKjZ4LN1ONkvkLw8ExaqrAWZ8PmqSL80hZfSaRD5XgFAez1tOH/g==
Date: Thu, 21 May 2026 12:27:19 +0200
From: Pavel Machek <pavel@nabladev.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, john.madieu@gmail.com
Subject: Re: [PATCH 6.12.y-cip 11/17] PCI: rzg3s-host: Add SoC-specific
 configuration and initialization callbacks
Message-ID: <ag7eB6VvuM53t3ue@duo.ucw.cz>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
 <20260514093935.2212718-12-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zu0tyb7b0wRDLWwo"
Content-Disposition: inline
In-Reply-To: <20260514093935.2212718-12-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 10:27:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22990


--zu0tyb7b0wRDLWwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 5f2c4de717786150f8d6cdbdbffb986cd3c59edb ]
>=20
> Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks
> to handle SoC-specific configuration methods. While RZ/G3S uses the Linux
> reset framework with dedicated reset lines, other SoC variants like RZ/G3E
> control configuration resets through PCIe AXI registers.
>=20
> As Linux reset bulk API gracefully handles optional NULL reset lines
> (num_cfg_resets =3D 0 for RZ/G3E), the driver continues to use the standa=
rd
> reset framework when reset lines are available, while custom callbacks
> are only invoked when provided.
>=20
> This provides a balanced pattern where:
> - RZ/G3S: Uses callbacks that fall back to the reset framework
> - RZ/G3E: Sets num_cfg_resets=3D0, provides
>   cfg_pre_init/cfg_post_init/cfg_deinit

> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -232,6 +232,9 @@ struct rzg3s_pcie_host;
>  /**
>   * struct rzg3s_pcie_soc_data - SoC specific data
>   * @init_phy: PHY initialization function
> + * @config_pre_init: Optional callback for SoC-specific pre-configuration
> + * @config_post_init: Callback for SoC-specific post-configuration
> + * @config_deinit: Callback for SoC-specific de-initialization
>   * @power_resets: array with the resets that need to be de-asserted

I'd preffer all hooks to be optional, or all of them to be mandatory,
this is strange.

But, if changed, should be changed in mainline.

Best regards,
								Pavel

--zu0tyb7b0wRDLWwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCag7eBwAKCRAw5/Bqldv6
8pQuAJwPPiAGYuNrM7iq4apW8qo5vj21yQCdFvMowzj3Xa11sw/eEkMi1uzqt4w=
=SBpe
-----END PGP SIGNATURE-----

--zu0tyb7b0wRDLWwo--


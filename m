Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE13E9A745
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:18:25 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15802.1774343897436175153
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:18:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Y8BrkdbG;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45A04105A03;
	Tue, 24 Mar 2026 10:18:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774343895;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=poqWpH6h+nkw91VrdLNB7QWxC8EkAd3SkNqdhtYEMzg=;
	b=Y8BrkdbGyCUajhqdvL4JQtpKB8464jpygV34oJBDRhwWVHpEY6zn1IaKqOscAHBIdaFu1C
	YCWnNCSF/iCtkD+WKxuFbTYQEiM6tVAgxLp+H1I7m1PClQcjq9P4gsfES/3c3N9vyAJySe
	iyaIYWtOCkWSVXN5rAs2/PhY75BHrbao5C+7UUPNk3sHutIco52mOHxBI1KVv7pUpOUnND
	4EqeCkXdARa+zd6bxzqYtSlBJJ3n5QJitDwrBPYNWC0DRgrpvgb3tJpgVJWxnuQNGT+Guk
	vIRfbel/gpnORewD/l2FZlOIy3P5LGNETqUegISQvHmY1G3fHC1Y7Fdyhfautg==
Date: Tue, 24 Mar 2026 10:18:13 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 19/35] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/T2H SoC
Message-ID: <acJW1TpVAGmB1CC6@duo.ucw.cz>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m+D6GE5w2eaEst/Y"
Content-Disposition: inline
In-Reply-To: <20260316145915.8580-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:18:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22539


--m+D6GE5w2eaEst/Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!


> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> @@ -33,6 +34,7 @@
>   *                handled by the glue driver or core driver.
>   * @set_clk_tx_rate: Flag to indicate if Tx clock is fixed or
>   *                   set_clk_tx_rate is needed.
> + * @has_pcs: Flag to indicate if the MAC has a PCS

"." at the end of sentence would be consistent with the rest (but yes,
that's really nitpicking).

Best regards,
								Pavel

--m+D6GE5w2eaEst/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJW1QAKCRAw5/Bqldv6
8rgJAJsF2FdEpJDyjzlV966MOW4dpSlUtACfSdDE7mep3lhZQHnZ1O06zRv7r4o=
=+zCr
-----END PGP SIGNATURE-----

--m+D6GE5w2eaEst/Y--


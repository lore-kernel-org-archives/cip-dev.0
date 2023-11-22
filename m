Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B58FC27C40
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 21:07:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.40527.1700687261212041825
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 13:07:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 94B4A1C0075; Wed, 22 Nov 2023 22:07:39 +0100 (CET)
Date: Wed, 22 Nov 2023 22:07:39 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 07/11] clk: Add support for versa3 clock driver
Message-ID: <ZV5tmy34x/GeB+Aw@duo.ucw.cz>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
 <20231122142819.203737-8-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80nwd04fLiJWPxn8"
Content-Disposition: inline
In-Reply-To: <20231122142819.203737-8-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 21:07:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13654


--80nwd04fLiJWPxn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add support for Renesas versa3 clock driver(5p35023).
> The clock generator provides 6 output clocks.


> +	if (!ret) {
> +		/*
> +		 * A raw settings array was specified in the DT. Write the
> +		 * settings to the device immediately.
> +		 */
> +		for  (i =3D 0; i < NUM_CONFIG_REGISTERS; i++) {
> +			ret =3D regmap_write(regmap, i, settings[i]);

One space is enough after "for", but I'm not sure that's worth
separate patch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--80nwd04fLiJWPxn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZV5tmwAKCRAw5/Bqldv6
8lnAAJ42iYmRqVseLKCDMa/EjfTvS+b3PgCeKy+xEo7Kd+YHgq4F29P3n3dtQs0=
=HNfL
-----END PGP SIGNATURE-----

--80nwd04fLiJWPxn8--


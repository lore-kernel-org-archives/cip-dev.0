Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C504D0E6D8
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 12:43:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16203.1764074617061435687
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Nov 2025 04:43:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PdQCt7RD;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 803CC1006DA3F;
	Tue, 25 Nov 2025 13:43:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764074615; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bnEUNNaIVa0XeF5cE+xyztYMA6uzXlKO0ON5MMKNkko=;
	b=PdQCt7RDM/LHhRdDoXW3xaVA+6OzP1OiGKHIQIP50rQHvGW8t8FKtBOuU0Nm4UqhNBW4fp
	5IpVTU8YDt1AVpaFImIF620Ovo1YJEnlyjcqJgqoYVAzuvcSw3MyInCZ/ZP/evJAfoCFP7
	0CqrG/PQKiI1gM9+/hhkGD6EYoyJXjXgDygwSbuLE9SJUNMqarbYMSZLxUZ7symXiwervL
	Y3jHULvZdOlE/5n3ueSTmuhZjeFtvtp2vJSLpIqGUhaLpW+XglA1twrxXVI5JMt9R2liRe
	ShQo67P6PL6e6VWXcikW9vQ3egYeFifwKgO9V5zAoOO8yA408yvhT4V6gs8DXA==
Date: Tue, 25 Nov 2025 13:43:29 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>,
	nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/2] ASoC: da7213: Use component
 driver suspend/resume
Message-ID: <aSWkcdhsz1ldyWqw@duo.ucw.cz>
References: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
 <20251122105116.2782841-2-claudiu.beznea.uj@bp.renesas.com>
 <CACe6DC5bsN166QrMFSzVT_JhtLKVHtqXrnP0aBdrk0ua0mEWJw@mail.gmail.com>
 <401dab8e-a50f-4c76-8997-a311e818e81e@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IRDZzy3V/Lt1jJPW"
Content-Disposition: inline
In-Reply-To: <401dab8e-a50f-4c76-8997-a311e818e81e@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 12:43:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20728


--IRDZzy3V/Lt1jJPW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> +static int da7213_runtime_suspend(struct device *dev)
> >> +{
> >> +       struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> >> +
> >> +       regcache_cache_only(da7213->regmap, true);
> >> +       regcache_mark_dirty(da7213->regmap);
> >> +       regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
> >=20
> > There is no error checking.
> > We need to add error checking or return an error code.
>=20
> This is just a move of da7213_runtime_suspend() to be able to use it in
> da7213_suspend() w/o forward declaration.

As this is just code move, I went ahead and applied the series.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IRDZzy3V/Lt1jJPW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSWkcQAKCRAw5/Bqldv6
8hQ+AJwIp/zO56zKeP4vkLXu4gTHjvbMrQCgqPBpydp7EkMwufjoytNIVkAyyt8=
=GNdb
-----END PGP SIGNATURE-----

--IRDZzy3V/Lt1jJPW--


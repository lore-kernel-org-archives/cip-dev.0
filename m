Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863CCFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 10:16:07 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13725.1763979361013010517
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 02:16:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=iPe1t0EY;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 090A01007D76F;
	Mon, 24 Nov 2025 11:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763979357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RuTuGb3Z79ssMdSscMwPD95rM2UESTGXJE1TXiK1AYQ=;
	b=iPe1t0EYYSKKrhhczFVuBHuAsznCs4Ey47B/139NKkCg9PMS1d2qEXbApgIqUqj4kDg1fH
	T1hUCvnDfYNKeTOYQK9CjE1tFpoRzVAZSVgmz5se5jRYV6VscpJbvaxRNjBkf1rmLCP9g0
	D7g7eP4bxOYiEY0A7emPhA+h9EZKArFOX/n1x/uIo0PJn3RVo7ICFYkwnKpCQd3577i0O+
	Uj0HhLPRgm0A/lI6kpL2QagwTkJwz6TMGQaBuxJSt72L6436Y1qU9g4DinX6lv1aj0K1tC
	Z/lNO98n5iMXHS10J7KuPfDKSfSBd/cyxcEAupM92Mb3DAoVYpibSu+lQKcu4g==
Date: Mon, 24 Nov 2025 11:15:46 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>,
	nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/2] ASoC: da7213: Use component
 driver suspend/resume
Message-ID: <aSQwUuxR6mnh+ug/@duo.ucw.cz>
References: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
 <20251122105116.2782841-2-claudiu.beznea.uj@bp.renesas.com>
 <CACe6DC5bsN166QrMFSzVT_JhtLKVHtqXrnP0aBdrk0ua0mEWJw@mail.gmail.com>
 <401dab8e-a50f-4c76-8997-a311e818e81e@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k++epbzG+e4vOxdA"
Content-Disposition: inline
In-Reply-To: <401dab8e-a50f-4c76-8997-a311e818e81e@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 10:16:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20708


--k++epbzG+e4vOxdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> +++ b/sound/soc/codecs/da7213.c
> >> @@ -2106,11 +2106,50 @@ static int da7213_probe(struct snd_soc_compone=
nt *component)
> >>         return 0;
> >>  }
> >>
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
>=20
> Do you want me to adjust it for CIP?

I don't believe this should block merge, but you may want to
investigate error handling here and eventually fix it up in the
mainline. At that point it may be worth backporting to -cip (or not).

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k++epbzG+e4vOxdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSQwUgAKCRAw5/Bqldv6
8lMiAJwPZdTClWl12H6rPjnyzegETYpxRACgjfPOFio4uomCfup8SCad6mskl8c=
=fQgn
-----END PGP SIGNATURE-----

--k++epbzG+e4vOxdA--


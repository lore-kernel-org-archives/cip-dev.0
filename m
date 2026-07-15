Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40B9C44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 10:20:49 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3182.1784110840554626593
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 03:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=f9qiJEdy;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0B89119B9E;
	Wed, 15 Jul 2026 12:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784110838;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ENvUFicvjl8BTigzEdJCDGf1TtHP3EUwcTexP+1HUWI=;
	b=f9qiJEdy7G7Wiorb1n2bBUeNqoNnh3ksQm+jCK7D4CNJ1dBQijYpc5TPYzyr276NnfI6bT
	TlnPsok+M1TJeDQreBCWQFaVNuqqwMrWyS6+ClSlBnUQYxT5CSoUhA1LCJE+MIW7l4Grgq
	Qh1jLc8Et2eH7FAaA6byD+otluLGaFrQUC0KJwaTUTRC7Yrz3y0Jd7xzMIwX1Dt5s1ckrV
	5NFST80c1hw18+niGbaSQ1/ehEmPOFUjQgvmkVuisrfji7cFGtPMC1bFetVq3KfShhx6qW
	vcBM8Lz1iEbFcaLZ4mS0lOgj6NRjyuDw5kfr7NE0mGKL6P+rAfMWGT0kPPeoJQ==
Date: Wed, 15 Jul 2026 12:20:36 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 14/23] mfd: syscon: Allow syscon nodes without
 a "syscon" compatible
Message-ID: <alde9PF2ScrONpQg@duo.ucw.cz>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <20260703105923.251255-15-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4n+e0prY/np1qUVP"
Content-Disposition: inline
In-Reply-To: <20260703105923.251255-15-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 10:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23591


--4n+e0prY/np1qUVP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: "Rob Herring (Arm)" <robh@kernel.org>
>=20
> [ Upstream commit ba5095ebbc7a83965ac049a50fa493d7c751f19b ]
>=20
> of_syscon_register_regmap() was added for nodes which need a custom
> regmap setup. It's not really correct for those nodes to claim they are
> compatible with "syscon" as the default handling likely doesn't work in
> those cases. If device_node_get_regmap() happens to be called first,
> then of_syscon_register() will be called and an incorrect regmap will be
> created (barring some other error). That may lead to unknown results in
> the worst case. In the best case, of_syscon_register_regmap() will fail
> with -EEXIST. This problem remains unless these cases drop "syscon" (an
> ABI issue) or we exclude them using their specific compatible. ATM,
> there is only one user: "google,gs101-pmu"
>=20
> There are also cases of adding "syscon" compatible to existing nodes
> after the fact in order to register the syscon. That presents a
> potential DT ABI problem. Instead, if there's a kernel change needing a
> syscon for a node, then it should be possible to allow the kernel to
> register a syscon without a DT change. That's only possible by using
> of_syscon_register_regmap() currently, but in the future we may want to
> support a match list for cases which don't need a custom regmap.
>=20
> With this change, the lookup functions will succeed for any node
> registered by of_syscon_register_regmap() regardless of whether the node
> compatible contains "syscon".

I note this is change to generic code. I trust it has all dependencies
it needs and will not cause problems somewhere?

Thanks and best regards,
								Pavel

> +++ b/drivers/mfd/syscon.c
> @@ -176,9 +176,12 @@ static struct regmap *device_node_get_regmap(struct =
device_node *np,
>  			break;
>  		}
> =20
> -	if (!syscon)
> -		syscon =3D of_syscon_register(np, check_res);
> -
> +	if (!syscon) {
> +		if (of_device_is_compatible(np, "syscon"))
> +			syscon =3D of_syscon_register(np, check_res);
> +		else
> +			syscon =3D ERR_PTR(-EINVAL);
> +	}
>  	mutex_unlock(&syscon_list_lock);
> =20
>  	if (IS_ERR(syscon))
> @@ -243,9 +246,6 @@ EXPORT_SYMBOL_GPL(device_node_to_regmap);
> =20
>  struct regmap *syscon_node_to_regmap(struct device_node *np)
>  {
> -	if (!of_device_is_compatible(np, "syscon"))
> -		return ERR_PTR(-EINVAL);
> -
>  	return device_node_get_regmap(np, true);
>  }
>  EXPORT_SYMBOL_GPL(syscon_node_to_regmap);

--4n+e0prY/np1qUVP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCalde9AAKCRAw5/Bqldv6
8op3AKCsnEtNnU+0ft7TQztPbfBDfrl31QCfQUUINyt2l5IpRmmlLjP4rZ/T2k0=
=gDeW
-----END PGP SIGNATURE-----

--4n+e0prY/np1qUVP--


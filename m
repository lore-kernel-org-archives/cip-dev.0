Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B78E73164
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 13:17:58 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52272.1770038273331427801
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 05:17:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=MeYyCvzZ;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A82C210F2CB;
	Mon,  2 Feb 2026 14:17:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770038270;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=jlMNtUr5Mk6Aq2AEhqAAZ8j5RFHMvKpnCH7g85HUn7k=;
	b=MeYyCvzZAYGHxht7FGB1gVmgGwVMTUIvYHjp8sRtMkqJaPlmFDM+8/qT0G4mPs0mVuniK1
	3HN0GMgEM9P4rMMH7RwfYlIVglms9FnZaS0Rt1+pmyC/HcHb2TFcI7t/44tGw+BYYgGWSe
	AbUnGUreeTEge4CGOymm0LVCda67ZxxSZXJFJ2XbivWiLhed50ZAR7qNNs1P0guxZBd9Tb
	I9+ctq9dn8NqDMeZnukWiaeGgfwbiyrppdGripEJ4LGdsaAt9IFaVh+HxQjbSoxmU62Y1v
	mBa5ASDyQA26JMP/xrdYvBfCy4lkqd7g0TCbImHCHhYrgOpYityPNszTI4LE+A==
Date: Mon, 2 Feb 2026 14:17:46 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 01/11] soc: renesas: rz-sysc: Add
 syscon/regmap support
Message-ID: <aYCj+rasLB4K5WGt@duo.ucw.cz>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
 <20260128132522.6902-2-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="thM/FnklFNXORH4g"
Content-Disposition: inline
In-Reply-To: <20260128132522.6902-2-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 13:17:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21806


--thM/FnklFNXORH4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 2da2740fb9c8e26b6b5e20d74f2ed1d49824236d upstream.
>=20
> The RZ/G3E system controller has various registers that control or report
> some properties specific to individual IPs. The regmap is registered as a
> syscon device to allow these IP drivers to access the registers through t=
he
> regmap API.
>=20
> As other RZ SoCs might have custom read/write callbacks or max-offsets,
> register a custom regmap configuration.
>=20
> [claudiu.beznea:
>  - do not check the match->data validity in rz_sysc_probe() as it is
>    always valid
>  - dinamically allocate regmap_cfg]

=2E..

> +++ b/drivers/soc/renesas/rz-sysc.c
> @@ -100,14 +104,23 @@ MODULE_DEVICE_TABLE(of, rz_sysc_match);
> =20
>  static int rz_sysc_probe(struct platform_device *pdev)
>  {
> +	const struct rz_sysc_init_data *data;
>  	const struct of_device_id *match;
>  	struct device *dev =3D &pdev->dev;
> +	struct regmap *regmap;
>  	struct rz_sysc *sysc;
> +	int ret;
> +
> +	struct regmap_config *regmap_cfg __free(kfree) =3D kzalloc(sizeof(*regm=
ap_cfg), GFP_KERNEL);
> +	if (!regmap_cfg)
> +		return -ENOMEM;
>

>  	match =3D of_match_node(rz_sysc_match, dev->of_node);
>  	if (!match)
>  		return -ENODEV;
> =20
> +	data =3D match->data;
> +
>  	sysc =3D devm_kzalloc(dev, sizeof(*sysc), GFP_KERNEL);
>  	if (!sysc)


So this function now uses both devm_ mechanism and __free() +
kzalloc. That's quite confusing / strange. I believe this is going to
be in 6.1 only, so probably not worth fixing.

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--thM/FnklFNXORH4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYCj+gAKCRAw5/Bqldv6
8kmZAKCIT079PVNd533aiO0GJER1ZxdGNwCdHMohgIbOAaUTECmeiCglNkvoWiI=
=J2to
-----END PGP SIGNATURE-----

--thM/FnklFNXORH4g--


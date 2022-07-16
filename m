Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F29C433EF
	for <webhook@archiver.kernel.org>; Sat, 16 Jul 2022 11:14:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.4337.1657970051111294489
 for <cip-dev@lists.cip-project.org>;
 Sat, 16 Jul 2022 04:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A5CB51C0001; Sat, 16 Jul 2022 13:14:08 +0200 (CEST)
Date: Sat, 16 Jul 2022 13:13:53 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH RESEND 5.10.y-cip 13/13] watchdog: rzg2l_wdt: Add
 set_timeout callback
Message-ID: <20220716110434.GC18467@duo.ucw.cz>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <20220715073916.2321319-14-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <20220715073916.2321319-14-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 16 Jul 2022 11:14:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8838


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 4055ee81009e606e830af1acd9e2e35a36249713 upstream.
>=20
> This patch adds support for set_timeout callback.
>=20
> Once WDT is started, the WDT cycle setting register(WDTSET) can be updated
> only after issuing a module reset. Otherwise, it will ignore the writes
> and will hold the previous value. This patch updates the WDTSET register
> if it is active.


> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -115,6 +115,25 @@ static int rzg2l_wdt_stop(struct watchdog_device *wd=
ev)
>  	return 0;
>  }
> =20
> +static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned =
int timeout)
> +{
> +	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> +
> +	wdev->timeout =3D timeout;
> +
> +	/*
> +	 * If the watchdog is active, reset the module for updating the WDTSET
> +	 * register so that it is updated with new timeout values.
> +	 */

values->value?

> +	if (watchdog_active(wdev)) {
> +		pm_runtime_put(wdev->parent);
> +		reset_control_reset(priv->rstc);
> +		rzg2l_wdt_start(wdev);
> +	}

This code is quite tricky. AFAICT it is correct, but calling
rzg2l_wdt_stop() instead would make it more readable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtKdcQAKCRAw5/Bqldv6
8h0PAJwO8wetN1+aAM6ZXArIobz42HzIigCgl9lzZl3a74xjgHMFURJjAkavog8=
=Bywp
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--


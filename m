Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4161C43219
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 19:49:23 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.1337.1649185198915647128
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Apr 2022 11:59:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 371DB1C0B66; Tue,  5 Apr 2022 20:59:54 +0200 (CEST)
Date: Tue, 5 Apr 2022 20:59:53 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 11/29] watchdog: Add Watchdog Timer driver for
 RZ/G2L
Message-ID: <20220405185953.GA27445@duo.ucw.cz>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404123553.25851-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20220404123553.25851-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Apr 2022 19:49:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8001


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 2cbc5cd0b55fa2310cc557c77b0665f5e00272de upstream.
>=20
> Add Watchdog Timer driver for RZ/G2L SoC.
>=20
> WDT IP block supports normal watchdog timer function and reset
> request function due to CPU parity error.
>=20
> This driver currently supports normal watchdog timer function
> and later will add support for reset request function due to
> CPU parity error.

> +static int rzg2l_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> +
> +	reset_control_deassert(priv->rstc);
> +	pm_runtime_get_sync(wdev->parent);
> +
> +	/* Initialize time out */
> +	rzg2l_wdt_init_timeout(wdev);
> +
> +	/* Initialize watchdog counter register */
> +	rzg2l_wdt_write(priv, 0, WDTTIM);
> +
> +	/* Enable watchdog timer*/

I'd put space before */.

> +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_resume_and_get failed ret=3D%pe", ERR_PTR(ret=
));
> +		goto out_pm_get;
> +	}
=2E..
> +	watchdog_set_drvdata(&priv->wdev, priv);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_wdt_reset_assert_pm_disable_put,
> +				       &priv->wdev);
> +	if (ret < 0)
> +		return ret;

I believe you need to undo effects of pm_runtime_resume_and_get() here
and jump to out_pm_get.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYkyRqQAKCRAw5/Bqldv6
8mdIAJ48YIo2bHKB0DlrfLHNRqL6JlrulwCfd0Bj9douBrqShBAMaZaDc5BVxns=
=kgOx
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--


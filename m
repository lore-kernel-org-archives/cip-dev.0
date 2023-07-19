Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E53BC001DC
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 12:38:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12605.1689770314188032783
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 05:38:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 005B51C0A97; Wed, 19 Jul 2023 14:38:30 +0200 (CEST)
Date: Wed, 19 Jul 2023 14:38:30 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 08/13] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <ZLfZRrLwZmb7ZIf8@duo.ucw.cz>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
 <20230718140608.119449-9-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7El7jwREiAxhjBhp"
Content-Disposition: inline
In-Reply-To: <20230718140608.119449-9-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 12:38:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12422


--7El7jwREiAxhjBhp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The RZ/G2L Multi-Function Timer Pulse Unit 3 (a.k.a MTU3a) uses
> one counter and two match components to configure duty_cycle
> and period to generate PWM output waveform.
>=20
> Add basic support for RZ/G2L MTU3a PWM driver by creating separate
> PWM channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> [biju: - Replaced return type of rz_mtu3_pwm_get_state() from
>          int->void.
>        - Replaced the macro DEFINE_RUNTIME_DEV_PM_OPS->SET_
>          SYSTEM_SLEEP_PM_OPS and dropped pm_ptr. ]
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -0,0 +1,552 @@

> +static void rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(chip->dev);
> +	if (rc)
> +		return;

Should this at least WARN_ON? Unlike mainline, we can't error here,
but I doubt we should just ignore error silently.

> +static int rz_mtu3_pwm_probe(struct platform_device *pdev)
> +{
=2E..
> +	mutex_init(&rz_mtu3_pwm->lock);
> +	platform_set_drvdata(pdev, rz_mtu3_pwm);
> +	ret =3D clk_prepare_enable(rz_mtu3_pwm->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> +
> +	clk_rate_exclusive_get(rz_mtu3_pwm->clk);
> +
> +	rz_mtu3_pwm->rate =3D clk_get_rate(rz_mtu3_pwm->clk);
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> +	 * period and duty cycle.
> +	 */
> +	if (rz_mtu3_pwm->rate > NSEC_PER_SEC) {
> +		ret =3D -EINVAL;
> +		clk_rate_exclusive_put(rz_mtu3_pwm->clk);
> +		goto disable_clock;
> +	}
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> +	ret =3D devm_add_action_or_reset(&pdev->dev, rz_mtu3_pwm_pm_disable,
> +				       rz_mtu3_pwm);
> +	if (ret < 0)
> +		return ret;

Should this goto disable_clock, too?

> +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_CHANNELS;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");

And here?

> +	pm_runtime_idle(&pdev->dev);
> +
> +	return 0;
> +
> +disable_clock:
> +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> +	return ret;
> +}

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7El7jwREiAxhjBhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLfZRgAKCRAw5/Bqldv6
8m9HAJ90v8q5pqxHnOT3BfYyE1ZelIoIHwCeIT5rkhe20nmXFEKe0lPpy6buwjk=
=FJxI
-----END PGP SIGNATURE-----

--7El7jwREiAxhjBhp--


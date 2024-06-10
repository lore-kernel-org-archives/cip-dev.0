Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73FBC27C55
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 21:19:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.31740.1718054335808135622
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jun 2024 14:18:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3E1721C008E; Mon, 10 Jun 2024 23:18:53 +0200 (CEST)
Date: Mon, 10 Jun 2024 23:18:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 09/17] pinctrl: renesas: rzg2l: Add
 suspend/resume support
Message-ID: <ZmdtvDPD3l+6bhj4@duo.ucw.cz>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
 <20240607140856.2497508-10-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VntdxDEHNYp2g9kW"
Content-Disposition: inline
In-Reply-To: <20240607140856.2497508-10-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jun 2024 21:19:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16183


--VntdxDEHNYp2g9kW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20

> Because interrupt signals are routed to IA55 interrupt controller and
> IA55 interrupt controller resumes before pin controller, patch restores
> also the configured interrupts just after pin settings are restored to
> avoid invalid interrupts while resuming.

> +static int rzg2l_gpio_irq_set_wake(struct irq_data *data, unsigned int o=
n)
> +{
=2E..
> +	if (on)
> +		atomic_inc(&pctrl->wakeup_path);
> +	else
> +		atomic_dec(&pctrl->wakeup_path);
> +

Would it make sense to use refcount_t here for greater robustness?

> @@ -240,6 +267,32 @@ struct rzg2l_pinctrl_pin_settings {
>  	u16 drive_strength_ua;
>  };
> =20
> +/**
> + * struct rzg2l_pinctrl_reg_cache - register cache structure (to be used=
 in suspend/resume)
> + * @p: P registers cache
> + * @pm: PM registers cache
> + * @pmc: PMC registers cache
> + * @pfc: PFC registers cache
> + * @iolh: IOLH registers cache
> + * @ien: IEN registers cache
> + * @sd_ch: SD_CH registers cache
> + * @eth_poc: ET_POC registers cache
> + * @eth_mode: ETH_MODE register cache
> + * @qspi: QSPI registers cache
> + */
> +struct rzg2l_pinctrl_reg_cache {
> +	u8	*p;
> +	u16	*pm;
> +	u8	*pmc;

Ok, so this is ... quite interesting. I guess you can't use generic
reg_cache for this? I also guess nports is usually high enough that
this is not wasting too much space? I'd expect to have struct with
just the values, and then have nports-sized array of those structures.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VntdxDEHNYp2g9kW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmdtvAAKCRAw5/Bqldv6
8jRHAKCAXPliU92KI6wqnlc1FddhhNJJ+ACghGhNPdGng54zMPyG5d7GSIemTMM=
=/f66
-----END PGP SIGNATURE-----

--VntdxDEHNYp2g9kW--


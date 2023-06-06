Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C71C77B73
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:08:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5060.1686046108479744299
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:08:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E5F661C0CAF; Tue,  6 Jun 2023 12:08:26 +0200 (CEST)
Date: Tue, 6 Jun 2023 12:08:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 5/8] counter: Add Renesas RZ/G2L MTU3a counter
 driver
Message-ID: <ZH8Fmom8vZ4DwxqA@duo.ucw.cz>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O2elW/GJfc4dd77E"
Content-Disposition: inline
In-Reply-To: <20230606075235.183132-6-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:08:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11857


--O2elW/GJfc4dd77E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 0be8907359df4c62319f5cb2c6981ff0d9ebf35a upstream.
>=20
> Add RZ/G2L MTU3a counter driver. This IP supports the following
> phase counting modes on MTU1 and MTU2 channels
>=20
> 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
>=20
> This patch adds 3 counter value channels.
> 	count0: 16-bit phase counter value channel on MTU1
> 	count1: 16-bit phase counter value channel on MTU2
> 	count2: 32-bit phase counter value channel by cascading
>                 MTU1 and MTU2 channels.
>=20
> The external input phase clock pin for the counter value channels
> are as follows:
> 	count0: "MTCLKA-MTCLKB"
> 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
>=20
> Use the sysfs variable "external_input_phase_clock_select" to select the
> external input phase clock pin and "cascade_counts_enable" to enable/
> disable cascading of channels.

> +static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, i=
nt id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	unsigned long tmdr;
> +
> +	pm_runtime_get_sync(priv->ch->dev);
> +	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> +	pm_runtime_put(priv->ch->dev);

pm_runtime_get/put is unusually fine-grained here.

Do we need error handling for pm_runtime_get?

> +static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       u64 ceiling)
> +{
=2E..
> +	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
> +	if (ret)
> +		return ret;
> +
> +	switch (count->id) {
> +	case RZ_MTU3_16_BIT_MTU1_CH:
> +	case RZ_MTU3_16_BIT_MTU2_CH:
> +		if (ceiling > U16_MAX)
> +			return -ERANGE;

Missing mutex_unlock here.

> +		priv->mtu_16bit_max[ch_id] =3D ceiling;
> +		break;
> +	case RZ_MTU3_32_BIT_CH:
> +		if (ceiling > U32_MAX)
> +			return -ERANGE;

And here.

> +static int rz_mtu3_count_enable_write(struct counter_device *counter,
> +				      struct counter_count *count, u8 enable)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	int ret =3D 0;
> +
> +	if (enable) {
> +		pm_runtime_get_sync(ch->dev);
> +		mutex_lock(&priv->lock);
> +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> +		if (ret =3D=3D 0)
> +			priv->count_is_enabled[count->id] =3D true;
> +		mutex_unlock(&priv->lock);

Elsewhere you did pm_runtime_get inside the lock. (Which might enable
code cleanups).=20

> +static int rz_mtu3_cnt_probe(struct platform_device *pdev)
> +{
=2E..
> +	mutex_init(&priv->lock);
> +	platform_set_drvdata(pdev, priv->clk);
> +	clk_prepare_enable(priv->clk);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, de=
v);
> +	if (ret < 0)
> +		goto disable_clock;

Should we have dev_err_probe here?

> +disable_clock:
> +	clk_disable_unprepare(priv->clk);
> +
> +	return ret;
> +}

Do we need pm_runtime_disable here?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--O2elW/GJfc4dd77E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH8FmgAKCRAw5/Bqldv6
8p0lAJ46bQI2IN/42vhE5hVahyGRO60UpQCffPRnzH3Kkgf4GQPyfi+qtu1e+6E=
=AwHI
-----END PGP SIGNATURE-----

--O2elW/GJfc4dd77E--


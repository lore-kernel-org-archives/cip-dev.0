Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7313BEB64DA
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 12:32:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12492.1689769963507028806
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 05:32:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DC3811C0A97; Wed, 19 Jul 2023 14:32:40 +0200 (CEST)
Date: Wed, 19 Jul 2023 14:32:40 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 5.10.y-cip 05/13] mfd: Add Renesas RZ/G2L MTU3a core
 driver
Message-ID: <ZLfX6EeK4JPuOsqZ@duo.ucw.cz>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
 <20230718140608.119449-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F0TaHAJKMh8EyoYq"
Content-Disposition: inline
In-Reply-To: <20230718140608.119449-6-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 12:32:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12421


--F0TaHAJKMh8EyoYq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +struct rz_mtu3_channel {
> +	struct device *dev;
> +	unsigned int channel_number;
> +	struct mutex lock;
> +	bool is_busy;
> +};
=2E..
> +#if IS_ENABLED(CONFIG_RZ_MTU3)
> +static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
> +{
> +	mutex_lock(&ch->lock);
> +	if (ch->is_busy) {
> +		mutex_unlock(&ch->lock);
> +		return false;
> +	}
> +
> +	ch->is_busy =3D true;
> +	mutex_unlock(&ch->lock);
> +
> +	return true;
> +}
> +
> +static inline void rz_mtu3_release_channel(struct rz_mtu3_channel *ch)
> +{
> +	mutex_lock(&ch->lock);
> +	ch->is_busy =3D false;
> +	mutex_unlock(&ch->lock);
> +}

mutex is really wrong primitive for this. Use test_and_set_bit() and
clear_bit instead?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--F0TaHAJKMh8EyoYq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLfX6AAKCRAw5/Bqldv6
8pNYAKC8aBsThP1il1Wdq+ToUM7lIw6PpACgviP7EOAkHL6QL3dSwxd7fge58WE=
=oK1g
-----END PGP SIGNATURE-----

--F0TaHAJKMh8EyoYq--


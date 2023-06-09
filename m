Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3508AC7EE29
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 10:36:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.10067.1686306996009574069
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jun 2023 03:36:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0DDD01C0E4E; Fri,  9 Jun 2023 12:36:34 +0200 (CEST)
Date: Fri, 9 Jun 2023 12:36:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 3/8] mfd: Add Renesas RZ/G2L MTU3a core driver
Message-ID: <ZIMAse1ikTuycJ02@duo.ucw.cz>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LJ2P+5DjXX84MEmB"
Content-Disposition: inline
In-Reply-To: <20230606075235.183132-4-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 10:36:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11932


--LJ2P+5DjXX84MEmB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> the Renesas RZ/G2L family SoCs. It consists of eight 16-bit timer
> channels and one 32-bit timer channel. It supports the following
> functions
>  - Counter
>  - Timer
>  - PWM
>=20
> The 8/16/32 bit registers are mixed in each channel.
>=20
> Add MTU3a core driver for RZ/G2L SoC. The core driver shares the
> clk and channel register access for the other child devices like
> Counter, PWM and Clock event.



> +static void rz_mtu3_start_stop_ch(struct rz_mtu3_channel *ch, bool start)
> +{
> +	struct rz_mtu3 *mtu =3D dev_get_drvdata(ch->dev->parent);
> +	struct rz_mtu3_priv *priv =3D mtu->priv_data;
> +	unsigned long flags, tstr;
> +	u16 offset;
> +	u8 bitpos;
> +
> +	/* start stop register shared by multiple timer channels */
> +	raw_spin_lock_irqsave(&priv->lock, flags);
> +
> +	offset =3D rz_mtu3_get_tstr_offset(ch);
> +	bitpos =3D rz_mtu3_get_tstr_bit_pos(ch);

These two can be done outside raw_spin_lock protection.=20

> +	tstr =3D rz_mtu3_shared_reg_read(ch, offset);
> +	__assign_bit(bitpos, &tstr, start);
> +	rz_mtu3_shared_reg_write(ch, offset, tstr);
> +
> +	raw_spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +bool rz_mtu3_is_enabled(struct rz_mtu3_channel *ch)
> +{
> +	struct rz_mtu3 *mtu =3D dev_get_drvdata(ch->dev->parent);
> +	struct rz_mtu3_priv *priv =3D mtu->priv_data;
> +	unsigned long flags, tstr;
> +	bool ret =3D false;
> +	u16 offset;
> +	u8 bitpos;
> +
> +	/* start stop register shared by multiple timer channels */
> +	raw_spin_lock_irqsave(&priv->lock, flags);
> +
> +	offset =3D rz_mtu3_get_tstr_offset(ch);
> +	bitpos =3D rz_mtu3_get_tstr_bit_pos(ch);

These two can be done outside raw_spin_lock protection.=20

> +	tstr =3D rz_mtu3_shared_reg_read(ch, offset);
> +	ret =3D tstr & BIT(bitpos);

As can be the ret computation.

Your critical sections are small enough that raw_spin_lock is okay
thing to do AFAICT.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LJ2P+5DjXX84MEmB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIMAsQAKCRAw5/Bqldv6
8sBqAJ90Q4CJ7bg4No7fk0tPHlPlNcvmrACeN629lL+XX8gnu2X+AEYIVwSr79I=
=7kH9
-----END PGP SIGNATURE-----

--LJ2P+5DjXX84MEmB--


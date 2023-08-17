Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21CFC27C7A
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 11:16:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.184743.1692270981666525561
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 04:16:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 33B431C0004; Thu, 17 Aug 2023 13:16:20 +0200 (CEST)
Date: Thu, 17 Aug 2023 13:16:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 09/13] rtc: isl1208: Add isl1208_set_xtoscb()
Message-ID: <ZN4BgzG2xmzOzdFZ@duo.ucw.cz>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
 <20230816142458.147476-10-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zk9S5dxhr3dhmaaP"
Content-Disposition: inline
In-Reply-To: <20230816142458.147476-10-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 11:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12759


--Zk9S5dxhr3dhmaaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As per the HW manual, set the XTOSCB bit as follows:
>=20
> If using an external clock signal, set the XTOSCB bit as 1 to
> disable the crystal oscillator.
>=20
> If using an external crystal, the XTOSCB bit needs to be set at 0
> to enable the crystal oscillator.

> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -6,6 +6,7 @@
> @@ -175,6 +176,20 @@ isl1208_i2c_validate_client(struct i2c_client *clien=
t)
>  	return 0;
>  }
> =20
> +static int isl1208_set_xtoscb(struct i2c_client *client, int sr, int xto=
sb_val)
> +{
> +	/* Do nothing if bit is already set to desired value */
> +	if ((sr & ISL1208_REG_SR_XTOSCB) =3D=3D xtosb_val)
> +		return 0;

XTOSCB bit is not bit 0, but xtosb_val is either 0 or 1. If it is 1,
test will never succeed. I don't think that's intended.

> +	if (xtosb_val)
> +		sr |=3D ISL1208_REG_SR_XTOSCB;
> +	else
> +		sr &=3D ~ISL1208_REG_SR_XTOSCB;
> +
> +	return i2c_smbus_write_byte_data(client, ISL1208_REG_SR, sr);

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Zk9S5dxhr3dhmaaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN4BgwAKCRAw5/Bqldv6
8nd0AJ9eSlOh6/1CnDtFRUJmmgvxS1QTCwCfZCfOXEo8X5j0Sq/ddb7ppyxSrZA=
=6P/L
-----END PGP SIGNATURE-----

--Zk9S5dxhr3dhmaaP--


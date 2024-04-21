Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2651C4345F
	for <webhook@archiver.kernel.org>; Sun, 21 Apr 2024 14:24:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.32863.1713709460351077081
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Apr 2024 07:24:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E55F71C0080; Sun, 21 Apr 2024 16:24:17 +0200 (CEST)
Date: Sun, 21 Apr 2024 16:24:17 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 37/53] pinctrl: renesas: rzg2l: Add support
 for different DS values on different groups
Message-ID: <ZiUhkX5xyChq0wlL@duo.ucw.cz>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
 <20240419081742.3496709-38-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qr8OoYVD6Ltgaesh"
Content-Disposition: inline
In-Reply-To: <20240419081742.3496709-38-claudiu.beznea.uj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 Apr 2024 14:24:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15717


--Qr8OoYVD6Ltgaesh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> RZ/G3S supports different drive strength values for different power
> sources and pin groups (A, B, C).  On each group there could be up to 4
> drive strength values per power source.  Available power sources are
> 1v8, 2v5, 3v3.  Drive strength values are more fine tuned than what was
> previously available on the driver thus the necessity of having
> micro-amp support.  As drive strength and power source values are linked
> together the hardware setup for these was moved at the end of
> rzg2l_pinctrl_pinconf_set() to ensure proper validation of the new
> values.
>=20
> The drive strength values are expected to be initialized though the
> SoC-specific hardware configuration data structure.

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c

> +static enum rzg2l_iolh_index rzg2l_ps_to_iolh_idx(u16 ps)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(available_ps); i++) {
> +		if (available_ps[i] =3D=3D ps)
> +			break;
> +	}
> +
> +	/*
> +	 * We multiply with RZG2L_IOLH_MAX_DS_ENTRIES as we have
> +	 * RZG2L_IOLH_MAX_DS_ENTRIES DS values per power source
> +	 */
> +	return i * RZG2L_IOLH_MAX_DS_ENTRIES;
> +}

Is it valid that ps is not in the array and so that i =3D=3D ARRAY_SIZE(ava=
ilable_ps)?

> +static u16 rzg2l_iolh_val_to_ua(const struct rzg2l_hwcfg *hwcfg, u32 cap=
s, u8 val)
> +{
> +	if (caps & PIN_CFG_IOLH_A)
> +		return hwcfg->iolh_groupa_ua[val];
> +
> +	if (caps & PIN_CFG_IOLH_B)
> +		return hwcfg->iolh_groupb_ua[val];
> +
> +	if (caps & PIN_CFG_IOLH_C)
> +		return hwcfg->iolh_groupc_ua[val];
> +
> +	/* Should not happen. */
> +	return 0;

I'd expect WARN or pr* or return -EINVAL here.

> +static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl *pctrl, u32 caps,
> +				  enum rzg2l_iolh_index iolh_idx,
> +				  u16 ds)
> +{
> +	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
> +	const u16 *array =3D NULL;
> +	unsigned int i;
> +
> +	if (caps & PIN_CFG_IOLH_A)
> +		array =3D hwcfg->iolh_groupa_ua;
> +
> +	if (caps & PIN_CFG_IOLH_B)
> +		array =3D hwcfg->iolh_groupb_ua;
> +
> +	if (caps & PIN_CFG_IOLH_C)
> +		array =3D hwcfg->iolh_groupc_ua;
> +
> +	/* Should not happen. */
> +	if (!array)
> +		return false;

I'd expect WARN or pr* or return -EINVAL here.


>  		index =3D rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
> +		/*
> +		 * Drive strenght mA is supported only by group A and only
> +		 * for 3V3 port source.
> +		 */

Typo "strenght".

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Qr8OoYVD6Ltgaesh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZiUhkQAKCRAw5/Bqldv6
8tm9AJ4nIsPszHQrQakzpp98y04BQiEr/ACfaLJr60cXyVb7jsOSNeXXHA2/ZuY=
=1wXp
-----END PGP SIGNATURE-----

--Qr8OoYVD6Ltgaesh--


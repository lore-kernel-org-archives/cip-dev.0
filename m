Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D04C433EF
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 11:05:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.47409.1643713555100381611
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 03:05:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 49F3B1C0B82; Tue,  1 Feb 2022 12:05:50 +0100 (CET)
Date: Tue, 1 Feb 2022 12:05:49 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 05/27] pinctrl: renesas: rzg2l: Add helper
 functions to read/write pin config
Message-ID: <20220201110548.GA30077@amd>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220131121903.8620-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20220131121903.8620-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 11:05:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7551


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit d1189991c823b50990291c8157b56fb141c47155 upstream.
>=20
> Add helper functions to read/read modify write pin config.
>=20
> Switch to use helper functions for pins supporting PIN_CONFIG_INPUT_ENABLE
> capabilities.

Along with refactoring code, this also removes locking from the
reads. Which is okay AFAICT, but note in changelog would not hurt.

Best regards,
								Pavel

> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -424,6 +424,39 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *=
pctldev,
>  	return ret;
>  }
> =20
> +static u32 rzg2l_read_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
> +				 u8 bit, u32 mask)
> +{
> +	void __iomem *addr =3D pctrl->base + offset;
> +
> +	/* handle _L/_H for 32-bit register read/write */
> +	if (bit >=3D 4) {
> +		bit -=3D 4;
> +		addr +=3D 4;
> +	}
> +
> +	return (readl(addr) >> (bit * 8)) & mask;
> +}
> +
> @@ -452,17 +485,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
>  	case PIN_CONFIG_INPUT_ENABLE:
>  		if (!(cfg & PIN_CFG_IEN))
>  			return -EINVAL;
> -		spin_lock_irqsave(&pctrl->lock, flags);
> -		/* handle _L/_H for 32-bit register read/write */
> -		addr =3D pctrl->base + IEN(port_offset);
> -		if (bit >=3D 4) {
> -			bit -=3D 4;
> -			addr +=3D 4;
> -		}
> -
> -		reg =3D readl(addr) & (IEN_MASK << (bit * 8));
> -		arg =3D (reg >> (bit * 8)) & 0x1;
> -		spin_unlock_irqrestore(&pctrl->lock, flags);
> +		arg =3D rzg2l_read_pin_config(pctrl, IEN(port_offset), bit, IEN_MASK);
>  		break;
> =20
>  	case PIN_CONFIG_POWER_SOURCE: {

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAmH5FAwACgkQMOfwapXb+vLcKACgnxO302mJ01bD9QEecjAi5Eom
UBQAkwYSfD0JctnpoXij4v/T88U0zg8=
=G8Q3
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


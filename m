Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CDBC43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 20:53:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1172.1658782410372702120
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jul 2022 13:53:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DCC8D1C0009; Mon, 25 Jul 2022 22:53:26 +0200 (CEST)
Date: Mon, 25 Jul 2022 22:53:26 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 24/24] arm64: dts: renesas:
 rzg2l-smarc: Move pinctrl definitions
Message-ID: <20220725205326.GA2302@duo.ucw.cz>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
 <20220715072244.2298757-25-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20220715072244.2298757-25-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Jul 2022 20:53:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8904


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> RZ/G2L and RZ/G2LC SMARC EVK use the same carrier board, but the pin
> mappings between the RZ/G2L and the RZ/G2LC SMARC SoM are different.
> Therefore we need to update the carrier board pin definitions based
> on the corresponding SoM pin mapping.
>=20
> Move pinctrl definitions out of the RZ/G2L SMARC common file, so that
> we can reuse the common file to support RZ/G2LC SMARC EVK.
=2E..

This really needs subsequent patches to be useful; plus, git complains
about blank line at EOF. Anyway, I believe we can still take it.

> diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi b/a=
rch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
> new file mode 100644
> index 000000000000..71d83e447670
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
> +	};
> +};
> +

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYt8CxgAKCRAw5/Bqldv6
8uE8AJ0TyBo0LnYjUGUl4D4E/2Zrk/nNegCgp7bCgtsajsjCaWmBHiPFve7bkHg=
=2Bi3
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

